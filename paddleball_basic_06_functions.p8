pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- paddleball
-- lesson 06: functions
-- by matthew dimatteo

-- runs once at start
function _init()

	-- "call" functions to
	-- run their code
	make_paddle() -- tab 1
	make_ball() -- tab 1

end -- end function _init()

-- loops 30 times per second
function _update()
	
	-- call the move paddle
	-- function
	move_paddle() -- tab 2
	
	-- move ball lower on screen
	baly = baly + balspd
	
end -- end function _update()

-- loops 30 times per second
function _draw()
	cls() -- clears the screen
	
	-- draw paddle sprite
	spr(padn,padx,pady)
	
	-- draw ball sprite
	spr(baln,balx,baly)
end
-->8
-- make paddle and ball

-- declare variables for paddle
function make_paddle()
	padn = 1 -- sprite number
	padx = 60 -- x coordinate
	pady = 118 -- y coordinate
	padspd = 3 -- speed	
end

-- declare variables for ball
function make_ball()
	baln = 2 -- sprite number
	balx = 60 -- x coordinate
	baly = 2 -- y coordinate
	balspd = 3 -- speed	
end
-->8
-- move paddle()
function move_paddle()

	-- left arrow moves pad left
	-- type shift l for ⬅️
	if btn(⬅️) then
		padx = padx - padspd
	end

	-- right arrow moves pad right
	-- type shift r for ➡️
	if btn(➡️) then
		padx = padx + padspd
	end
	
	-- keep pad on screen left
	if padx < 0 then
		padx = 0
	end
	
	-- keep pad on screen right
	if padx > 120 then
		padx = 120
	end
	
end -- end function make_paddle()
__gfx__
000000000000000000cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777770cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000007777777700cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
