
module BoxDrawing.Draw (
   module BoxDrawing.Draw,
   module BoxDrawing.Internal.Primitive,
   module BoxDrawing.Internal.Assembly
) where

import BoxDrawing.Internal.Primitive
import BoxDrawing.Internal.Assembly

--------------------------------------------------------------------------------

class Draw a where
   assemble :: a -> [[Char]]

draw :: Draw a => a -> IO ()
draw = putStr . unlines . assemble
