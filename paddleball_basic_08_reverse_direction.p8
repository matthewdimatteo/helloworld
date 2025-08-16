pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- paddleball
-- lesson 08: reverse direction
-- by matthew dimatteo

-- tab 1: make paddle and ball
-- tab 2: move paddle
-- tab 3: move ball and collide

-- runs once at start
-- variables, objects
function _init()

	-- "call" functions to
	-- run their code
	make_paddle() -- tab 1
	make_ball() -- tab 1

end -- /function _init()

-- runs 30x/sec
-- movement, calculation
function _update()
	
	-- "call" functions to
	-- run their code
	move_paddle() -- tab 2
	move_ball() -- tab 3
	
end -- /function _update()

-- runs 30x/sec
-- output/graphics
function _draw()
	cls() -- refresh screen
	
	-- draw paddle sprite
	spr(padn,padx,pady)
	
	-- draw ball sprite
	spr(baln,balx,baly)
end -- /function _draw()
-->8
-- make paddle and ball

-- paddle variables 
function make_paddle()
	padn = 1 -- sprite number
	padx = 60 -- x coordinate
	pady = 118 -- y coordinate
	padspd = 3 -- speed	

	-- we need to know width
	-- and height of objects to
	-- detect if they collide
	padw = 8 -- width
	padh = 2 -- height
end -- /function make_paddle()

-- ball variables 
function make_ball()
	baln = 2 -- sprite number
	balx = 60 -- x coordinate
	baly = 2 -- y coordinate
	balspd = 3 -- speed	

	-- we need to know width
	-- and height of objects to
	-- detect if they collide
	balw = 8 -- width
	balh = 8 -- height
	
	-- *** we need variables to
	-- track the ball's direction
	balxdir = "" -- horizontal
	balydir = "down" -- vertical
end -- /function make_ball()
-->8
-- move paddle
function move_paddle()

	-- left arrow moves pad left
	-- type shift l for ⬅️
	if btn(⬅️) then
		padx = padx - padspd
	end -- /if btn(⬅️)

	-- right arrow moves pad right
	-- type shift r for ➡️
	if btn(➡️) then
		padx = padx + padspd
	end -- /if btn(➡️)
	
	-- keep pad on screen left
	if padx < 0 then
		padx = 0
	end -- /if padx < 0
	
	-- keep pad on screen right
	if padx > 120 then
		padx = 120
	end -- /if padx > 120
	
end -- /function move_paddle()
-->8
-- move ball and collide
function move_ball()
	
	-- *** move ball up
	if balydir == "up" then
		baly = baly - balspd
	end -- /if balydir == "up"

	-- *** move ball down
	if balydir == "down" then
		baly = baly + balspd
	end -- /if balydir == "down"
	
	-- collide with paddle
	if 	balx + balw >= padx
	and	balx <= padx + padw
	and	baly + balh >= pady
	and baly <= pady + padh
	then
		-- *** reverse direction
		-- after hittiing paddle
		balydir = "up"
	end -- /if-else collision
	
	-- *** bounce off ceiling
	if baly < 0 then
		balydir = "down"
	end -- /if baly < 0
	
end -- /function move_ball()
__gfx__
000000000000000000cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777770cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000007777777700cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
