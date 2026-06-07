# Exercises for Beginners' Track

- Design a datatype for wallclock time, i.e. hour and minute.
  - How can you ensure that illegal states are unrepresentable?
  - Write a function that calculates the number of minutes that have
    passed since midnight.
  - Write a function that does the reverse, i.e. take the number of
    minutes since midnight as input and produces the wallclock-time
    object.

- Write a function to feed an `Animal` a specifiable amount.  Dead
  armadillos will not gain weight.
  
- A geometric shape is one of the following
  - a circle
  - a square
  - an overlay of two geometric shapes
  
  Design a data represenation of geometric shapes, and write a
  function that determines whether a point is inside a shape or not.

- Write a function `listFilter` that takes as input a predicate
  (i.e. a function returning a `Bool`) and a list, which returns the
  list of elements of the input list for which the predicate returned
  true.

- Write a function reversing a list.

- Find the documentation of the `Semigroup` and `Monoid` typeclasses.
  Write a function analogous to `listSum`, but which refers to the
  operation and the identity of a monoid.  What is its type signature?

- Check out https://hoogle.haskell.org/ and search for type 
  `(a -> b) -> [a] -> [b]`

- Write datatypes to represent the cards of a card game with the
  French deck (wie ranks 2-10, Jack, Queen, King, Ace, and suites
  spades, hearts, diamonds, clubs.  Write a function that returns a
  list of all the cards in the deck from a list of suites and a list
  of ranks.  Use Hoogle to find functions useful for the task.

