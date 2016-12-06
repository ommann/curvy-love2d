# Curvy
Curvy is a module for creating curve objects for love2d.

# Usage
Curve objects are best thought as an interace for strictly ascending or descending line diagrams.

Curve objects are initialized with two tables given as arguments.
First table represents the x-values and the second corresponding y-values.

```lua
--From 0 to 100 it takes 0.8 seconds
acceleration = curve( {0, 0.8, 2}, {0, 100, 200} )
```

Curve objects take two arguments:
* y-value that is used as a starting spot
* positive or negative adjustment value

```lua
--From the speed of 25 we further accelerate for a second
speed = acceleration(25, 1)
```

# Full example
```lua
curve = require 'curvy'

love.load = function()
  --From 0 to 100 it takes 0.8 seconds
  acceleration = curve( {0, 0.8, 2.20}, {0, 100, 200} )

  --From the speed of 25 we further accelerate for a second
  speed1 = acceleration(25, 1) --~128.6

  --From the speed of 0 we accelerate for 1 second
  speed2 = acceleration(0,  1) --~114.3

  print(speed1, speed2)
end
```
