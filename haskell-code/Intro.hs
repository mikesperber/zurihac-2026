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

-- Animal on the Texas highway:
-- - armadillo OR
-- - parrot

-- Armadillo has following attributes:
-- - dead or alive   AND
-- - weight
-- compound data
-- record:

data Liveness = Dead | Alive
  deriving Show

type Weight = Integer -- type alias

{-
data Dillo = MkDillo { dilloLiveness :: Liveness,
                       dilloWeight :: Weight }
  deriving Show
-}

-- Dillo: type
-- MkDillo: constructor
-- dilloLiveness: selector

-- algebraic data type
data Animal =
    MkDillo { dilloLiveness :: Liveness,
              dilloWeight :: Weight }
  | MkParrot String Weight 
  deriving (Show)


dillo1 :: Animal
dillo1 = MkDillo { dilloLiveness = Alive, dilloWeight = 5}

dillo2 :: Animal
dillo2 = MkDillo Dead 8

-- >>> dillo2
-- MkDillo {dilloLiveness = Dead, dilloWeight = 8}

-- >>> dilloLiveness dillo1
-- Alive

-- >>> dilloWeight dillo1
-- 5

-- >>> :type dilloLiveness
-- dilloLiveness :: Dillo -> Liveness

runOverDillo :: Animal -> Animal
-- >>> runOverDillo dillo1
-- MkDillo {dilloLiveness = Dead, dilloWeight = 5}
-- runOverDillo dillo =
--    MkDillo { dilloLiveness = Dead, dilloWeight = dilloWeight dillo }
--- runOverDillo dillo = MkDillo Dead (dilloWeight dillo)
-- runOverDillo d = d { dilloLiveness = Dead } -- functional update
-- runOverDillo (MkDillo { dilloLiveness = l, dilloWeight = w}) =
--    MkDillo Dead w
-- runOverDillo (MkDillo {dilloWeight = w}) =
-- MkDillo Dead w
runOverDillo (MkDillo _ weight) = MkDillo Dead weight
runOverDillo (MkParrot sentence weight) = MkParrot "" weight