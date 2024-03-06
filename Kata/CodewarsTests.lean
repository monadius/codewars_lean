import Lean

open Lean Elab Command Term Meta

private def printSuccess [Monad m] [MonadLog m] [AddMessageContext m] [MonadOptions m] : m Unit := do
  logInfo "\n<PASSED::>Test passed"

private def printFailure [Monad m] [MonadLog m] [AddMessageContext m] [MonadOptions m]
    (err : MessageData) : m Unit := do
  logInfo m!"\n<FAILED::> {err}"

/-- Checks that the term has the given type and prints assertion messages.

`#cw_assert_type term : type_term`

### Example

```lean
def expected_type := ∀ n, n + 1 = 1 + n
theorem solution : n + 1 = 1 + n := sorry
#cw_assert_type @solution : expected_type
```
-/
elab "#cw_assert_type " t:term ":" ty:term : command => do
  logInfo m!"\n<IT::>Type of '{t}'"
  withoutModifyingEnv <| runTermElabM fun _ => do
    let t ← elabTerm t none
    -- perform a whnf reduction to unfold definitions from Preloaded
    let expected_ty ← whnf (← elabTerm ty none)
    let actual_ty ← inferType t
    if ← isDefEq expected_ty actual_ty then
      printSuccess
    else do
      printFailure m!"Incorrect type:<:LF:>Expected: {expected_ty}<:LF:>Actual: {actual_ty}"
  logInfo m!"\n<COMPLETEDIN::>"

private def checkAxioms (name : Name) (allowed : List Name) : CommandElabM Unit := do
  logInfo m!"\n<IT::>Axioms of '{name}'"
  let (_, st) := (CollectAxioms.collect name).run (← getEnv) |>.run {}
  let badAxioms := st.axioms.toList.filter (fun ax => !allowed.contains ax)
  if badAxioms.length != 0 then
    printFailure m!"The following axioms are not allowed:<:LF:>{badAxioms}"
  else
    printSuccess
  logInfo m!"\n<COMPLETEDIN::>"

/-- Checks that the given definition contains the standard axioms only.

`#cw_assert_standard_axioms identifier`

The standard axioms are `Classical.choice`, `Quot.sound`, and `propext`.

### Examples
```lean
#cw_assert_standard_axioms Classical.em
#cw_assert_standard_axioms funext

theorem unproved : ∀ n, n + 1 = 1 + n := sorry
#cw_assert_standard_axioms unproved
```
-/
elab "#cw_assert_standard_axioms " t:ident : command => do
  let name ← resolveGlobalConstNoOverload t
  checkAxioms name [``Classical.choice, ``Quot.sound, ``propext]

/-- Checks that the given definition contains the allowed axioms only.

`#cw_assert_axioms identifier assumes axiom_identifiers*`

### Examples
```lean
#cw_assert_axioms Classical.em assumes Classical.choice Quot.sound propext
#cw_assert_axioms funext assumes Quot.sound
#cw_assert_axioms Nat.add_comm assumes

theorem unproved : ∀ n, n + 1 = 1 + n := sorry
#cw_assert_axioms unproved assumes sorryAx
```
-/
elab "#cw_assert_axioms " t:ident " assumes " axioms:ident* : command => do
  let name ← resolveGlobalConstNoOverload t
  let allowed ← axioms.toList.mapM (fun ⟨a⟩ => resolveGlobalConstNoOverload a)
  checkAxioms name allowed
