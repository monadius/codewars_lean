import Mathlib.Algebra.Group.Aut

open MulAut

theorem solution [Group G] (g h : G) : conj g h = g * h * g⁻¹ := rfl
