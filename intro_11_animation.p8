pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- rider game academy
-- intro to game programming
-- example 11: animation
-- by matthew dimatteo

-- runs once at start
-- variables, objects
function _init()
	make_plyr() -- tab 1
	
	key = 2 -- key sprite
	timer = 0 -- animation timer
end -- /function _init()

-- runs 30x/sec
-- movement, calculation
function _update()
	move_plyr() -- tab 2	
	anim_key() -- tab 3
end -- /function _update()

-- runs 30x/sec
-- output/graphics
function _draw()
	cls() -- refresh screen
	spr(n,x,y) -- draw plyr sprite
	spr(key,116,60) -- draw key
end -- /function _draw()
-->8
-- make player function
function make_plyr()
	n=1 -- sprite number
	x=4 -- x coordinate
	y=60 -- y coordinate
	spd=1 -- speed
end -- /function make_plyr()
-->8
-- move player function
function move_plyr()

	-- move left
	if btn(⬅️) then
		x = x - spd
	end -- /if btn(⬅️)
	
	-- move right
	if btn(➡️) then
		x = x + spd
	end -- /if btn(➡️)
	
	-- move up
	if btn(⬆️) then
		y = y - spd
	end -- /if btn(⬆️)
	
	-- move down
	if btn(⬇️) then
		y = y + spd
	end -- /if btn(⬇️)
	
end -- /function move_plyr()
-->8
-- animate key
function anim_key()

	-- start timer
	timer = timer + 1
	
	-- rate of animation
	rate = 9
	
	-- every few frames, swap
	-- the key's sprite
	if timer >= rate then
	
		-- go to next sprite
		key = key + 1 
		
		-- if key sprite reaches end
		-- of loop, go back to start
		if key > 4 then
			key = 2
		end -- /if key > 4
		
		-- reset timer
		timer = 0
	end -- /if timer >= 15
	
end -- /function 
__gfx__
000000000099990000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009aaaa9000000000000000700a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007009aaaa5a90000066600700666000007770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770009aaaaaa96666660666666606777777070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770009aaaaaa96060066660600666707007770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007009aaaaaa90000000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009aaaa9000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
