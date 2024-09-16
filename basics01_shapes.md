# helloworld
Explanation of basics01_shapes.p8

PICO-8 offers some built-in functions for drawing basic shapes:  

rect() draws a rectangle based on a pair of x,y coordinates (x1,y1,x2,y2)  
circ() draws a circle based on a pair of x,y coordinates and a radius (x,y,r)  

When providing values for x,y coordinates, consider that: 

The PICO-8 game window is 128 pixels square  
The origin (0,0) is in the top-left corner of the screen  
X increases from left to right  
Y increases from top to bottom (slightly counterintuitive)  

There are variants rectfill() and circfill() which fill in the shape  
Each of these functions can take an optional final value for the color code (0-15)  

Refer to the PICO-8 cheat sheet for color codes: https://www.lexaloffle.com/bbs/files/16585/PICO-8_CheatSheet_0111Gm_4k.png
