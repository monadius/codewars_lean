import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Comp
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv

def TASK_1 := ∀ (a b x : ℝ) (f : ℝ → ℝ), (ha : a ≠ 0) →
    DifferentiableAt ℝ (fun x => f (a * x + b)) x ↔ DifferentiableAt ℝ f (a * x + b)
notation "TASK_1" => TASK_1

def TASK_2 := ∀ (x : ℝ) (f : ℝ → ℝ) (f' a : ℝ), (ha : 0 < a) → (hf : HasDerivAt f f' x) →
    HasDerivAt (fun x => a ^ f x) ((Real.log a * f') * a ^ f x) x
notation "TASK_2" => TASK_2
