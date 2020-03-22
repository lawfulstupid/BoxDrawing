
module BoxDrawing.Internal.Util where

errInvalidChar :: Char -> a
errInvalidChar c = errorWithoutStackTrace
   ("Invalid character: " ++ [c])

errInvalidChars :: Char -> Char -> a
errInvalidChars x y = errorWithoutStackTrace
   ("Invalid character combination: " ++ [x] ++ " and " ++ [y])

(?:) :: Ord a => a -> (a,a) -> Bool
x ?: (a,b) = a <= x && x <= b

(?<) :: (Ord a, Foldable t) => t a -> (a,a) -> Bool
xs ?< (a,b) = all (?: (a,b)) xs