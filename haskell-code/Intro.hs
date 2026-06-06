module Intro where
-- comment
x :: Integer
x = 10

y :: Integer
y = x + 5

-- >>> y
-- 15

-- data definition:
-- Pet is one of the following:
-- - dog  OR
-- - cat  OR
-- - snake
-- case analysis: enumeration

data Pet =
    Dog 
  | Cat 
  | Snake

-- Is a pet cute?
isCute :: Pet -> Bool

-- >>> isCute Dog
-- True
-- >>> isCute Snake
-- False

{-
isCute pet =
    case pet of
        Dog -> True
        Cat -> True
        Snake -> False
-}


