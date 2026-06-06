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
  deriving Eq

{-
instance Eq Pet where
    -- (==) :: Pet -> Pet -> Bool
    (==) Dog Dog = True
    (==) Cat Cat = True
    (==) Snake Snake = True
    (==) _ _ = False
-}

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

-- >>> :info Functor
-- type Functor :: (* -> *) -> Constraint
-- class Functor f where
--   fmap :: (a -> b) -> f a -> f b

instance Functor Optional where
    fmap = optionalMap

optionalMap :: (a -> b) -> Optional a -> Optional b
optionalMap f Null = Null
optionalMap f (Result a) = Result (f a)

data Optional a =
    Null
  | Result a
  deriving Show

-- Eq a: constraint
listIndex :: Eq a => a -> [a] -> Optional Integer

-- >>> listIndex 3 [0, 4, 3, 2, 5]
-- Result 2

-- >>> listIndex Snake [Dog, Cat, Snake, Cat]
-- Result 2

inc index = index + 1

listIndex element [] = Null
listIndex element (x:xs) =
    if element == x
    then Result 0
    else fmap inc (listIndex element xs)
        
        {- case listIndex element xs of
           Null -> Null
           Result index -> Result (index+1)
        -}
-- type class: think interface
-- implementation: instance
-- >>> :info Eq
-- type Eq :: * -> Constraint
-- class Eq a where
--   (==) :: a -> a -> Bool

-- >>> :info Show
-- type Show :: * -> Constraint
-- class Show a where
--   show :: a -> String

newtype Seats = MkSeats Integer

makeSeats :: Integer -> Optional Seats
makeSeats n =
    if n >= 1 && n <= 8
    then Result (MkSeats n)
    else Null

newtype LicensePlate = MkLicensePlate String

makeLicensePlate :: String -> Optional LicensePlate
makeLicensePlate s =
    if length s >= 2
    then Result (MkLicensePlate s)
    else Null
    
-- Validation
data Car = MkCar {
    seats :: Seats, -- between 1 and 8
    licensePlate :: LicensePlate -- at least 2 characters
}


makeCar :: Integer -> String -> Optional Car
makeCar n s = MkCar <$> makeSeats n <*> makeLicensePlate s
{-
makeCar n s =
    case makeSeats n of
       Null -> Null
       Result seats ->
        case makeLicensePlate s of
            Null -> Null
            Result licensePlate -> Result (MkCar seats licensePlate)
-}
-- (<$>) = fmap

fmap2 :: (a -> (b -> c)) -> Optional a -> Optional b -> Optional c
-- fmap2 f opta optb = pure f <*> opta <*> optb
-- fmap2 f opta optb = (fmap f opta) <*> optb
fmap2 f opta optb = f <$> opta <*> optb

-- >>> :info Applicative
-- type Applicative :: (* -> *) -> Constraint
-- class Functor f => Applicative f where
--   pure :: a -> f a
--   (<*>) :: f (a -> b) -> f a -> f b

instance Applicative Optional where
    pure a = Result a
    -- (<*>) :: Optional (a -> b) -> Optional a -> Optional b
    (<*>) Null Null = Null
    (<*>) Null (Result a) = Null
    (<*>) (Result f) Null = Null
    (<*>) (Result f) (Result a) = Result (f a)
