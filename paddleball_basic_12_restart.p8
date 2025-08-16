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
-- variables, objects
function _init()

	-- "call" functions to
	-- run their code
	make_paddle() -- tab 1
	make_ball() -- tab 1
	
	-- game variables
	score = 0
	lives = 3

end -- /function _init()

-- runs 30x/sec
-- movement, calculation
function _update()
	
	-- only run the game if
	-- the player has lives
	if lives > 0 then
		move_paddle() -- tab 2
		move_ball() -- tab 3
	else -- /if lives > 0
	
		-- *** press ❎ to restart
		if btnp(❎) then
			_init()
		end -- /if btnp(❎)
	 
	end -- /if-else lives > 0
	
end -- end function _update()

-- runs 30x/sec
-- output/graphics
function _draw()
	cls() -- refresh screen
	
	-- *** draw game objects
	-- if player has lives
	if lives > 0 then
		
		-- draw sprites
		spr(padn,padx,pady)
		spr(baln,balx,baly)
	
		-- print score, lives
		print("score: "..score,2,2)
		print("lives: "..lives,2,10)
	
	-- *** game over message
	else
		print("game over",46,58,8)
		print("your score: "..score,36,66,10)

		-- *** instructions
		print("press ❎ to restart",28,74,7)
	end -- /if-else lives > 0
	
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
	
	-- we need variables to track
	-- the direction of the ball
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

	-- move ball left
	if balxdir == "left" then
		balx = balx - balspd
	end -- /if balxdir == "left"
	
	-- move ball right
	if balxdir == "right" then
		balx = balx + balspd
	end -- /if balxdir == "right"
	
	-- move ball higher on screen
	if balydir == "up" then
		baly = baly - balspd
	end -- /if balydir == "up"

	-- move ball lower on screen
	if balydir == "down" then
		baly = baly + balspd
	end -- /if balydir == "down"
	
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
		
		-- bounce sound
		sfx(0)
		
		-- hit ball to left
		if btn(⬅️) then
			balxdir = "left"
		end -- /if btn(⬅️)
		
		-- hit ball to right
		if btn(➡️) then
			balxdir = "right"
		end -- /if btn(➡️)
		
	end -- /if-else collision
	
	-- bounce off ceiling
	if baly < 0 then
		balydir = "down"
		sfx(0) -- bounce sound
	end -- /if baly < 0
	
	-- bounce off left wall
	if balx < 0 then
		balxdir = "right"
		sfx(0) -- bounce sound
	end -- /if balx < 0
	
	-- bounce off right wall
	if balx > 120 then
		balxdir = "left"
		sfx(0) -- bounce sound
	end -- /if balx > 120
	
	-- reset ball when missed
	if baly > 128 then
		balx = 60
		baly = 2
		balxdir = ""
		balydir = "down"

		-- lose a life
		lives = lives - 1

		-- failure sound
		sfx(1)
	end -- /if baly > 128
	
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
__sfx__
000100001e0501e0501e0501e05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000028750217501b7501675013750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
