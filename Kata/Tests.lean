import Kata.Preloaded
import Kata.Solution
import Kata.CodewarsTests

-- theorem task_1 : TASK_1 := immediate
-- #print axioms task_1

-- theorem task_2 : TASK_2 := plus_comm
-- #print axioms task_2

-- theorem task_3 : TASK_3 := excluded_middle
-- #print axioms task_3

#cw_assert_type immediate : TASK_1
#cw_assert_axioms immediate assumes

#cw_assert_type plus_comm : TASK_2
#cw_assert_axioms plus_comm assumes

#cw_assert_type excluded_middle : TASK_3
#cw_assert_standard_axioms excluded_middle
