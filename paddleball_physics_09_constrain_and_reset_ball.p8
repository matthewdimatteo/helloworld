pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- paddleball w/physics
-- lesson 09: reset ball
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: paddle functions
-- tab 2: ball functions

-- runs once at start
-- variables, objects
function _init()
	gravity = 0.3
	make_paddle() -- tab 1
	make_ball() -- tab 2
end -- /function _init()

-- runs 30x/sec
-- movement, calculation
function _update()
	move_paddle() -- tab 1
	move_ball() -- tab 2
end -- /function _update()

-- runs 30x/sec
-- output/graphics
function _draw()
	cls() -- refresh screen
	
	-- draw paddle
	spr(pad.n,pad.x,pad.y)
	
	-- draw ball
	spr(bal.n,bal.x,bal.y)
end -- /function _draw()
-->8
-- paddle
function make_paddle()
	pad = {} -- game object

	-- properties of object
	pad.n = 1 -- sprite number
	pad.x = 60
	pad.y = 118
	pad.w = 8 -- width
	pad.h = 2 -- height
	pad.spd = 3 -- speed
end -- /function make_paddle()

function move_paddle()

	-- move left
	if btn(⬅️) then
		pad.x -= pad.spd
	end -- / if btn(⬅️)
 
	-- move right
	if btn(➡️) then
		pad.x += pad.spd
	end -- / if btn(➡️)
 
	-- keep on screen left
	if pad.x < 0 then
		pad.x = 0
	end -- /if pad.x < 0
 
	-- keep on screen right
	if pad.x > 120 then
		pad.x = 120
	end -- /if pad.x > 120
 
end -- /function move_paddle()
-->8
-- ball
function make_ball()
	bal = {} -- game object

	-- properties of object
	bal.n = 2 -- sprite number
	bal.x = 60
	bal.y = 2
	bal.w = 8 -- width
	bal.h = 8 -- height
	bal.dx = 0 -- active x speed
	bal.dy = 0 -- active y speed
end -- /function make_ball()

function move_ball()
 
	-- apply gravity to speed
	bal.dy += gravity
    
	-- check collision
	if collide(bal,pad) then

		-- reverse direction
		bal.dy *= -1
        
		-- bounce left
		if btn(⬅️) then
			bal.dx = -pad.spd
		end -- /if btn(⬅️)
        
		-- bounce right
		if btn(➡️) then
			bal.dx = pad.spd
		end -- /if btn(➡️)
    
	end -- /if collide
    
	-- bounce off left wall
	if bal.x < 0 then
		bal.dx *= -1
	end -- /if bal.x < 0
 
	-- bounce off right wall
	if bal.x > 120 then
		bal.dx *= -1
	end -- /if bal.x > 120
    
	-- bounce off ceiling
	if bal.y < 0 then
		bal.y += 1 -- don't get stuck
		bal.dy *= -1
	end -- /if bal.y < 0
 
	-- reset after falling below
	if bal.y > 128 then
		bal.x = 60
		bal.y = 2
		bal.dx = 0
		bal.dy = 0
	end -- /if bal.y > 128
    
	-- apply speed to position
	bal.x += bal.dx
	bal.y += bal.dy
 
end -- /function move_ball()
-->8
-- object collsiion
function collide(b,p)
	if b.x + b.w >= p.x
	and b.x <= p.x + p.w
	and b.y + b.h >= p.y
	and b.y <= p.y + p.h
	then
		return true
	else
		return false
	end -- /if
end -- /function collide()
__gfx__
000000000000000000cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777770cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000007777777700cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
