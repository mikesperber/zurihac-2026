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

data Parrot = ...

data Animal = AnimalDillo Dillo | AnimalParrot Parrot
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

-- curried functions
f :: Integer -> Integer -> Integer

-- >>> f 2 5
-- 7
f x y = x + y

-- List is one of the following
-- - the empty list  OR                                     []
-- - a cons list consisting of first element AND rest list   :  (infix)
--                                                    ^^^^ self-reference

-- 1element list: 5
list1 :: [Integer]
list1 = 5 : []

-- 2element list: 8 5
list2 = 8 : 5 : []

-- 3element list: 3 8 5
list3 = 3 : list2 --  8 : 5 : []
list3' = [3,8,5]

listSum :: [Integer] -> Integer
listSum [] = 0
listSum (first:rest) = first + listSum rest

listMap :: (a -> b) -> [a] -> [b]
listMap f [] = []
listMap f (x:xs) = (f x) : (listMap f xs)

data Optional a =
    Null
  | Result a
  deriving Show

-- Eq a: constraint
listIndex :: Eq a => a -> [a] -> Optional Integer

-- >>> listIndex 3 [0, 4, 3, 2, 5]
-- Result 2

-- >>> listIndex Snake [Dog, Cat, Snake, Cat]
-- No instance for `Eq Pet' arising from a use of `listIndex'
-- In the expression: listIndex Snake [Dog, Cat, Snake, Cat]
-- In an equation for `it_a5ObL':
--     it_a5ObL = listIndex Snake [Dog, Cat, Snake, Cat]

listIndex element [] = Null
listIndex element (x:xs) =
    if element == x
    then Result 0
    else case listIndex element xs of
           Null -> Null
           Result index -> Result (index+1)

-- type class: think interface
-- >>> :info Eq
-- type Eq :: * -> Constraint
-- class Eq a where
--   (==) :: a -> a -> Bool
