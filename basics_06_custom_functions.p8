pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- basics series
-- example 06: custom functions
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: make paddle
-- tab 2: make ball

-- runs once at the start
-- set starting conditions here
function _init()
	gravity = 0.3 -- variable
	
	-- functions must be "called"
	-- like this in order to run
	make_pad() -- tab 1
	make_bal() -- tab 2
end

-- runs 30x/sec
-- perform calculations here
function _update()
	
end -- end _update()

-- runs 30x/sec
-- draw graphics here
function _draw()
	cls() -- clear the screen
	spr(pad.n,pad.x,pad.y)
	spr(bal.n,bal.x,bal.y)
end
-->8
-- make paddle
function make_pad()
	pad = {} -- object
	pad.n = 1 -- sprite number
	pad.x = 60 -- x position
	pad.y = 118 -- y position
	pad.w = 8 -- width
	pad.h = 2 -- height
end

-- this function won't do
-- anything unless it is
-- "called"

-- in _init(), type:
-- 	make_pad()
-- to call this function
-->8
-- make ball
function make_bal()
	bal = {}
	bal.n = 2 -- sprite number
	bal.x = 60 -- x position
	bal.y = 2 -- y position
	bal.w = 8 -- width
	bal.h = 8 -- height
end

-- this function won't do
-- anything unless it is
-- "called"

-- in _init(), type:
-- 	make_bal()
-- to call this function
__gfx__
000000000000000000cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777770cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000007777777700cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
