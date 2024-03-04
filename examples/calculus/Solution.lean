import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Comp
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv

lemma DifferentiableAt.comp_linear {a b x : ℝ} {f : ℝ → ℝ} (ha : a ≠ 0) :
    DifferentiableAt ℝ (fun x => f (a * x + b)) x ↔ DifferentiableAt ℝ f (a * x + b) := by
  constructor <;> intro df
  · have : f = (fun x => f (a * x + b)) ∘ (fun x => (x - b) / a) := by
      ext y; congr; field_simp; ring
    rw [this]
    apply DifferentiableAt.comp
    · rw [add_sub_cancel, mul_div_cancel_left _ ha]
      exact df
    · simp only [differentiableAt_id', differentiableAt_const, sub, div_const]
  · rw [← Function.comp]
    apply DifferentiableAt.comp
    · exact df
    · simp only [differentiableAt_add_const_iff]
      exact DifferentiableAt.const_mul differentiableAt_id' _

lemma HasDerivAt.const_rpow {f : ℝ → ℝ} {f' a : ℝ} (ha : 0 < a) (hf : HasDerivAt f f' x) :
    HasDerivAt (fun x => a ^ f x) ((Real.log a * f') * a ^ f x) x := by
  rw [(by norm_num; ring : (Real.log a * f') * a ^ f x = 0 * f x * a ^ (f x - 1) + f' * a ^ f x * Real.log a)]
  exact HasDerivAt.rpow (hasDerivAt_const x a) hf ha
