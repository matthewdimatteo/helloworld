pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- basics series
-- example 01: shapes
-- by matthew dimatteo

cls() -- clears the screen

-- draws a rectangle
-- from two points
-- x1,y1,x2,y2
rect(50,30,70,50)

-- fills a rectangle with
-- a color (fifth value)
rectfill(60,40,80,60,10)

-- draws a circle
-- x1,y1,radius,color
circ(60,80,10,8)
circfill(60,100,5,12)
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000