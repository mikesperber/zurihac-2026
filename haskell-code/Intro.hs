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
-- template:
-- isCute Dog = _
-- isCute Cat = _
-- isCute Snake = _

isCute Dog = True
isCute Cat = True
isCute Snake = False

-- Animals on the Texas highway:

-- Armadillo has following attributes:
-- - dead or alive   AND
-- - weight
-- compound data
-- record:

data Liveness = Dead | Alive

type Weight = Integer -- type alias

data Dillo = MkDillo { dilloLiveness :: Liveness,
                       dilloWeight :: Weight }

-- MkDillo: constructor

dillo1 :: Dillo
dillo1 = MkDillo { dilloLiveness = Alive, dilloWeight = 5}