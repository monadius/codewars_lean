-- Task 1: Prove that n + m = n + m
theorem immediate : ∀ n m : Nat, n + m = n + m := by
  intros; sorry

-- Task 2: Prove that n + m = m + n
theorem plus_comm : ∀ n m : Nat, n + m = m + n := by
  intros; apply Nat.add_comm

-- Task 3: Prove excluded middle
theorem excluded_middle : ∀ p : Prop, p ∨ ¬p := Classical.em
