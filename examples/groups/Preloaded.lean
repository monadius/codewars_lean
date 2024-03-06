import Mathlib.Algebra.Group.Aut

universe u

def TASK_1 := ∀ (G : Type u) [Group G] (g h : G), MulAut.conj g h = g * h * g⁻¹
notation "TASK_1" => TASK_1
