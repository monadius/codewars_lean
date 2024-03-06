import Kata.Preloaded
import Kata.Solution
import Kata.CodewarsTests

-- def task1 : TASK_1 := @DifferentiableAt.comp_linear
-- #print axioms task1

-- def task2 : TASK_2 := @HasDerivAt.const_rpow
-- #print axioms task2

#cw_assert_type @DifferentiableAt.comp_linear : TASK_1
#cw_assert_standard_axioms DifferentiableAt.comp_linear

#cw_assert_type @HasDerivAt.const_rpow : TASK_2
#cw_assert_standard_axioms HasDerivAt.const_rpow
-- #cw_assert_axioms HasDerivAt.const_rpow assumes
