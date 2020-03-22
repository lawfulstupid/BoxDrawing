
module BoxDrawing.Internal.Direction (
   Direction(..), direction
) where

import BoxDrawing.Internal.Primitive
import BoxDrawing.Internal.Util

--------------------------------------------------------------------------------

data Direction = L | U | R | D
   deriving (Eq, Ord, Enum, Bounded)

--------------------------------------------------------------------------------

base :: [(Char, Direction)]
base = [(left, L), (up, U), (right, R), (down, D)]

mapping :: [(Char, Direction)]
mapping = base >>= \(a,b) -> [(a, b), (heavy a, b), (double a, b)]

--------------------------------------------------------------------------------

direction :: Char -> Direction
direction c = case lookup c mapping of
   Just dir -> dir
   Nothing  -> errInvalidChar c
