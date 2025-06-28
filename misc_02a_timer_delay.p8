pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- misc series
-- example 02a: timer delay
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: paddle functions
-- tab 2: ball and timer
-- tab 3: collision function

-- runs once at start
function _init()
	gravity = 0.3
	make_pad() -- tab 1
	make_bal() -- tab 2
end -- /function _init()

-- runs 30x/second
function _update()
	move_pad() -- tab 1
	move_bal() -- tab 2
end -- /function _update()

-- runs 30x/sec
function _draw()
	cls() -- refresh screen
	
	-- print delay timer
	print("delay: "..bal.delay)
	
	-- draw sprites
	spr(pad.sp,pad.x,pad.y)
	spr(bal.sp,bal.x,bal.y)
end -- /function _draw()
-->8
-- paddle functions

-- make paddle object
function make_pad()
	pad = {} -- table
	pad.sp = 1 -- sprite number
 
	-- x,y position in pixels
	pad.x = 60
	pad.y = 118
 
	-- width/height in pixels
	pad.w = 10
	pad.h = 2
 
	-- speed in pixels per frame
	pad.speed = 3
end -- /function make_pad()

-- move paddle with arrow keys
function move_pad()
 
	-- move left
	if btn(⬅️) then
		pad.x -= pad.speed
	end -- /if btn(⬅️)
 
	-- move right
	if btn(➡️) then
		pad.x += pad.speed
	end -- /if btn(➡️)
 
	-- keep on screen left
	if pad.x < 0 then
		pad.x = 0
	end -- /if pad.x < 0
 
	-- keep on screen right
	if pad.x > 128-pad.w then
		pad.x = 128-pad.w
	end -- /if pad.x > 128-w
 
end -- /function move_pad()
-->8
-- ball and timer functions

-- make ball object
function make_bal()
	bal = {} -- table
	bal.sp = 2 -- sprite number
 
	-- x,y position in pixels
	bal.x = 60
	bal.y = 2
	
	-- width/height in pixels
	bal.w = 8
	bal.h = 8
	
	-- active x,y speed
	bal.dx = 0
	bal.dy = 0

	-- maximum speed
	bal.maxdy = 8
 
	-- start delay timer at 0
	bal.delay = 0 
 
	-- start moving when timer==30
	-- this will be 1 second
	bal.start = 30
 
end -- /function make_bal()

-- move ball
function move_bal()

	-- timer begins counting
	bal.delay += 1
 
	-- start moving when time's up
	if bal.delay >= bal.start
	then
		bal.dy += gravity
	end -- /if delay > start
 
	-- bounce off paddle
	if collide(bal,pad) then
		bal.y = 110
		sfx(0)
		bal.dy *= -1
  
		if btn(⬅️) then
			bal.dx = -pad.speed
		end -- /if btn(⬅️)
  
		if btn(➡️) then
			bal.dx = pad.speed
		end -- /if btn(➡️)
  
	end -- /if collide
 
	-- reset after falling
	if bal.y > 128 then
		sfx(1)
		make_bal()
	end -- /if bal.y > 128
 
	-- bounce off ceiling
	if bal.y < 0 then
		bal.y = 2
		sfx(0)
		bal.dy *= -1
	end -- /if bal.y < 2
 
	-- bounce off left/right walls
	if bal.x < 0 
	or bal.x > 128-bal.w
	then
		sfx(0)
		bal.dx *= -1
	end -- /if ball x < 0 / > 128
 
	-- speed limit
	if bal.dy > bal.maxdy then
		bal.dy = bal.maxdy
	end -- /if dy > maxdy
 
	-- speed limit (moving up)
	if bal.dy < -bal.maxdy then
		bal.dy = -bal.maxdy
	end -- /if by < -maxdy
 
	-- start moving when time's up
	if bal.delay >= bal.start then
		bal.x += bal.dx
		bal.y += bal.dy
	end -- /if delay >= start

end -- /function move_bal()
-->8
-- collision function
function collide(a,b)
	if b.x + b.w >= a.x
	and b.x <= a.x + a.w
	and b.y + b.h >= a.y
	and b.y <= a.y + a.h
	then
		return true
	else
		return false
 end -- /if
end -- /function collide(a,b)
__gfx__
000000000000000000cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777770cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000007777777700cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100001b05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000028750227501d7501a750147500d7000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
