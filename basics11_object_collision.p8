pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- basics series
-- example 11: object collision
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: pad functions
-- tab 2: bal functions
-- tab 3: collision detection

-- runs once at start
function _init()
	grav = 0.3 -- gravity
	make_pad() -- tab 1
	make_bal() -- tab 2
end

-- loops 30x/sec
function _update()
	move_pad() -- tab 1
	move_bal() -- tab 2
end

-- loops 30x/sec
function _draw()
	cls() -- clear the screen
	
	-- draw bal and pad
	spr(pad.n, pad.x, pad.y)
	spr(bal.n, bal.x, bal.y)
	
end -- end function _draw()
-->8
-- paddle functions
function make_pad()
	pad = {} -- object
	pad.n = 1 -- sprite number
	pad.x = 60 -- x position
	pad.y = 118 -- y position
	pad.w = 8 -- width
	pad.h = 2 -- height
	pad.spd = 3 -- speed
end

function move_pad()

	-- left arrow to move left
	if btn(⬅️) then
		pad.x -= pad.spd
	end

	-- right arrow to move right
	if btn(➡️) then
		pad.x += pad.spd
	end

	-- keep on screen left
	if pad.x < 0 then
		pad.x = 0
	end

	-- keep on screen right
	if pad.x > 128 - pad.w then
		pad.x = 128 - pad.w
	end
 
end -- end function move_pad()
-->8
-- ball functions
function make_bal()
	bal= {} -- object
	bal.n = 2 -- sprite number
	bal.x = 60 -- x position
	bal.y = 2 -- y position
	bal.w = 8 -- width
	bal.h = 8 -- height
	bal.dx= 0 -- hor speed
	bal.dy= 0 -- vert speed
end

function move_bal()

	-- apply gravity each frame
	bal.dy += grav
	
	-- bounce off of paddle
	if collide(bal,pad) then
	
		bal.y -= 1
		bal.dy *=- 1
	 
		-- bounce in direction of pad
		if btn(⬅️) then
			bal.dx = -pad.spd
		end
		
		if btn(➡️) then
			bal.dx = pad.spd
		end
		
		sfx(0) -- play sound
	 
	end -- end if collide
	
	-- bounce off left wall
	if bal.x < 0 then
		bal.x += 1
		bal.dx = pad.spd
		sfx(0)
	end
	
	-- bounce off right wall
	if bal.x > 128 - bal.w then
		bal.x = 128 - bal.w - 1
		bal.dx = -pad.spd
		sfx(0)
	end
	
	-- bounce off ceiling
	if bal.y < 0 then
		bal.y += 1
		bal.dy *= -1
		sfx(0)
	end
	
	-- reset bal if fell thru floor
	if bal.y > 128 then
		bal.x = 60
		bal.y = 2
		bal.dx = 0
		bal.dy = 0
		sfx(6) -- play sound
	end -- end if bal.y > 128
	
	-- move bal the calculated distance
	bal.x += bal.dx
	bal.y += bal.dy
	
end -- end function move_bal()
-->8
-- collision detection
function collide(a,b)
	if b.x+b.w >= a.x
	and b.x <= a.x+a.w
	and b.y+b.h >= a.y
	and b.y <= a.y+a.h
	then
		return true
	else
		return false
	end
end
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
000100001d0501d050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002205025050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002405027050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002605029050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000280502b050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000290502e050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000240501e0501d0501d05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000