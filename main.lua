curve = require 'curvy'

--From 0 to 100 it takes 0.8 seconds
acceleration = curve( {0, 0.8, 2.20}, {0, 100, 200} )

--From the speed of 25 we further accelerate for a second
speed1 = acceleration(25, 1) --~128.6

--From the speed of 0 we accelerate for 1 second
speed2 = acceleration(0, 1) --~114.3

print(speed1, speed2)
