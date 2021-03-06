
module BoxDrawing.Internal.Assembly (
   (&), curve, overlay
) where

import BoxDrawing.Internal.Direction
import BoxDrawing.Internal.Primitive
import BoxDrawing.Internal.Util

import Data.Set (Set)
import qualified Data.Set as Set

import Data.Bimap (Bimap)
import qualified Data.Bimap as Bimap

import Data.List ((\\))
import Data.Maybe (fromJust)

--------------------------------------------------------------------------------

{- Combines -}
(&) :: Char -> Char -> Char
x & y | x == y = x
x & y = case (sequence $ atoms <$> [x,y]) >>= fromAtoms . Set.unions of 
   Nothing -> errInvalidChars x y
   Just z  -> z

overlay :: Char -> Char -> Char
overlay ' ' y = y
overlay x ' ' = x
overlay x y = if null z
   then errInvalidChars x y
   else fromJust z
   where
   z = (sequence $ atoms <$> [x,y]) >>= \[xs,ys] -> fromAtoms . Set.union xs $
      Set.filter (flip Set.notMember (Set.map direction xs) . direction) ys

{- curve (down & left) = '╮' -}
curve :: Char -> Char
curve = \case
   '┌' -> '╭'
   '┐' -> '╮'
   '└' -> '╰'
   '┘' -> '╯'
   chr -> errInvalidChar chr

--------------------------------------------------------------------------------

atoms :: Char -> Maybe (Set Char)
atoms = (`Bimap.lookup` atomMap)

fromAtoms :: Set Char -> Maybe Char
fromAtoms = (`Bimap.lookupR` atomMap)

atomMap :: Bimap Char (Set Char)
atomMap = Bimap.fromList list
   where
   list = [(c, Set.singleton c) | c <- ['╴'..'╻'] ++ [double left, double up, double right, double down]]
      ++ [(c, atoms' c) | c <- "─━│┃╼╽╾╿" ++ (['┌'..'╬'] \\ "╌╍╎╏")]
      ++ [(' ', Set.empty)]
   
   atoms' :: Char -> Set Char
   atoms' = Set.fromList . \case
      -- lines
      '─' -> [left, right]
      '━' -> [heavy left, heavy right]
      '│' -> [up, down]
      '┃' -> [heavy up, heavy down]
      '╼' -> [left, heavy right]
      '╽' -> [up, heavy down]
      '╾' -> [heavy left, right]
      '╿' -> [heavy up, down]
      '═' -> [double left, double right]
      '║' -> [double up, double down]
      -- bends
      '┌' -> [right, down]
      '┍' -> [heavy right, down]
      '┎' -> [right, heavy down]
      '┏' -> [heavy right, heavy down]
      '┐' -> [left, down]
      '┑' -> [heavy left, down]
      '┒' -> [left, heavy down]
      '┓' -> [heavy left, heavy down]
      '└' -> [up, right]
      '┕' -> [up, heavy right]
      '┖' -> [heavy up, right]
      '┗' -> [heavy up, heavy right]
      '┘' -> [left, up]
      '┙' -> [heavy left, up]
      '┚' -> [left, heavy up]
      '┛' -> [heavy left, heavy up]
      '╒' -> [double right, down]
      '╓' -> [right, double down]
      '╔' -> [double right, double down]
      '╕' -> [double left, down]
      '╖' -> [left, double down]
      '╗' -> [double left, double down]
      '╘' -> [up, double right]
      '╙' -> [double up, right]
      '╚' -> [double up, double right]
      '╛' -> [double left, up]
      '╜' -> [left, double up]
      '╝' -> [double left, double up]
      -- junctions
      '├' -> [up, down, right]
      '┝' -> [up, down, heavy right]
      '┞' -> [heavy up, down, right]
      '┟' -> [up, heavy down, right]
      '┠' -> [heavy up, heavy down, right]
      '┡' -> [heavy up, down, heavy right]
      '┢' -> [up, heavy right, heavy down]
      '┣' -> [heavy up, heavy right, heavy down]
      '┤' -> [left, up, down]
      '┥' -> [heavy left, up, down]
      '┦' -> [left, heavy up, down]
      '┧' -> [left, up, heavy down]
      '┨' -> [left, heavy up, heavy down]
      '┩' -> [heavy left, heavy up, down]
      '┪' -> [heavy left, up, heavy down]
      '┫' -> [heavy left, heavy up, heavy down]
      '┬' -> [left, right, down]
      '┭' -> [heavy left, right, down]
      '┮' -> [left, heavy right, down]
      '┯' -> [heavy left, heavy right, down]
      '┰' -> [left, right, heavy down]
      '┱' -> [heavy left, right, heavy down]
      '┲' -> [left, heavy right, heavy down]
      '┳' -> [heavy left, heavy right, heavy down]
      '┴' -> [left, up, right]
      '┵' -> [heavy left, up, right]
      '┶' -> [left, up, heavy right]
      '┷' -> [heavy left, up, heavy right]
      '┸' -> [left, heavy up, right]
      '┹' -> [heavy left, heavy up, right]
      '┺' -> [left, heavy up, heavy right]
      '┻' -> [heavy left, heavy up, heavy right]
      '╞' -> [up, double right, down]
      '╟' -> [double up, right, double down]
      '╠' -> [double up, double right, double down]
      '╡' -> [double left, up, down]
      '╢' -> [left, double up, double down]
      '╣' -> [double left, double up, double down]
      '╤' -> [double left, double right, down]
      '╥' -> [left, right, double down]
      '╦' -> [double left, double right, double down]
      '╧' -> [double left, up, double right]
      '╨' -> [left, double up, right]
      '╩' -> [double left, double up, double right]
      -- crosses
      '┼' -> [left, up, right, down]
      '┽' -> [heavy left, up, right, down]
      '┾' -> [left, up, heavy right, down]
      '┿' -> [heavy left, up, heavy right, down]
      '╀' -> [left, heavy up, right, down]
      '╁' -> [left, up, right, heavy down]
      '╂' -> [left, heavy up, right, heavy down]
      '╃' -> [heavy left, heavy up, right, down]
      '╄' -> [left, heavy up, heavy right, down]
      '╅' -> [heavy left, up, right, heavy down]
      '╆' -> [left, up, heavy right, heavy down]
      '╇' -> [heavy left, heavy up, heavy right, down]
      '╈' -> [heavy left, up, heavy right, heavy down]
      '╉' -> [heavy left, heavy up, right, heavy down]
      '╊' -> [left, heavy up, heavy right, heavy down]
      '╋' -> [heavy left, heavy up, heavy right, heavy down]
      '╪' -> [double left, up, double right, down]
      '╫' -> [left, double up, right, double down]
      '╬' -> [double left, double up, double right, double down]
      chr -> errInvalidChar chr
