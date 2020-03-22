# BoxDrawing
Box drawing tools for Haskell


## Basic elements

`up`, `down`, `left`, `right`
Spoke in respective direction.
E.g. `up` = `'╵'`


## Weight

`heavy x`
Makes all elements of `x` heavy-lined.
E.g. `heavy '└'` = `'┗'`

`double x`
Makes all elements of `x` double-lined.
E.g. `double '└'` = `'╚'`
Note that not all box characters can be doubled.

## Combining elements

`x & y`
Combine base elements of chars x and y with `x & y`. Commutative.
E.g. `up & right` = `right & up` = `└`

`overlay x y`
Puts `x` on top of `y`.
E.g. `overlay (double right) '└'` = `╘`

`curve x`
Turns an L-joint `x` into a curve.
E.g. `curve '└'` = `'╰'`


## Drawing

`class Draw`
This class makes data types drawable. It has one operation: `assemble`, which is much like a 2-dimensional version of `show`.

`draw :: Draw a => a -> IO ()`
Draws a drawable object, much like a 2-dimensional version of `print`.