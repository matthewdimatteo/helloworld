pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- paddleball
-- lesson 12: restart
-- by matthew dimatteo

-- tab 1: make paddle and ball
-- tab 2: move paddle
-- tab 3: move ball and collide

-- runs once at start
function _init()

	-- "call" functions to
	-- run their code
	make_paddle() -- tab 1
	make_ball() -- tab 1
	
	-- player variables
	score = 0
	lives = 3

end -- end function _init()

-- loops 30 times per second
function _update()
	
	-- stop the game if no lives
	if lives > 0 then
		move_paddle() -- tab 2
		move_ball() -- tab 3
	else
	
		-- press ❎ to restart
	 if btnp(❎) then
	 	_init()
	 end -- end if btnp(❎)
	 
	end -- end if/else lives > 0
	
end -- end function _update()

-- loops 30 times per second
function _draw()
	cls() -- clears the screen
	
	if lives > 0 then
		-- draw sprites
		spr(padn,padx,pady)
		spr(baln,balx,baly)
	
		-- print score, lives
		print("score: "..score,2,2)
		print("lives: "..lives,2,10)
	else
		-- print game over message
		print("game over",46,58,8)
		print("your score: "..score,36,66,10)
		print("press ❎ to restart",28,74,7)
	end -- end if lives > 0
	
end -- end function _draw()
-->8
-- make paddle and ball

-- declare variables for paddle
function make_paddle()
	padn = 1 -- sprite number
	padx = 60 -- x coordinate
	pady = 118 -- y coordinate
	padspd = 3 -- speed	
	padw = 8 -- width
	padh = 2 -- height
end

-- declare variables for ball
function make_ball()
	baln = 2 -- sprite number
	balx = 60 -- x coordinate
	baly = 2 -- y coordinate
	balspd = 3 -- speed	
	balw = 8 -- width
	balh = 8 -- height
	
	-- we need  variables to track
	-- the direction of the ball
	balxdir = "" -- horizontal
	balydir = "down" -- vertical
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
-->8
-- move ball and collide
function move_ball()

	-- move ball left
	if balxdir == "left" then
		balx = balx - balspd
	end
	
	-- move ball right
	if balxdir == "right" then
		balx = balx + balspd
	end
	
	-- move ball lower on screen
	if balydir == "down" then
		baly = baly + balspd
	end
	
	-- move ball higher on screen
	if balydir == "up" then
		baly = baly - balspd
	end
	
	-- collide with paddle
	if 	balx + balw >= padx
	and	balx <= padx + padw
	and	baly + balh >= pady
	and baly <= pady + padh
	then
		-- reverse direction
		balydir = "up"
		
		-- add to score
		score = score + 1
		
		-- play bounce sound
		sfx(0)
		
		-- hit ball to left
		if btn(⬅️) then
			balxdir = "left"
		end
		
		-- hit ball to right
		if btn(➡️) then
			balxdir = "right"
		end
		
	end -- end if collide
	
	-- bounce off ceiling
	if baly < 0 then
		balydir = "down"
		sfx(0) -- play bounce sound
	end
	
	-- bounce off left wall
	if balx < 0 then
		balxdir = "right"
		sfx(0) -- play bounce sound
	end
	
	-- bounce off right wall
	if balx > 120 then
		balxdir = "left"
		sfx(0) -- play bounce sound
	end
	
	-- reset ball when missed
	if baly > 128 then
		balx = 60
		baly = 2
		balxdir = ""
		balydir = "down"
		lives = lives - 1 -- lose life
		sfx(1) -- play failure sound
	end
	
end -- end function move_ball()
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
000100001e0501e0501e0501e05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000028750217501b7501675013750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
