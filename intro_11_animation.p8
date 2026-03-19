pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- intro to game programming
-- lesson 11: animation
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: make player, key
-- tab 2: move player
-- *** tab 3: animate key

-- runs once at start
-- variables, objects
function _init()
	make_plyr() -- tab 1
	make_key() -- tab 1
	
	timer = 0 -- *** animation timer
end -- /function _init()

-- runs 30x/sec
-- movement, calculation
function _update()
	move_plyr() -- tab 2	
	anim_key() -- *** tab 3
end -- /function _update()

-- runs 30x/sec
-- output/graphics
function _draw()
	cls() -- refresh screen

	-- draw player and key
	spr(plyr_n,plyr_x,plyr_y)
	spr(key_n,key_x,key_y)
end -- /function _draw()
-->8
-- make player, make_key

-- make player
function make_plyr()
	plyr_n=1 -- sprite number
	plyr_x=4 -- x coordinate
	plyr_y=60 -- y coordinate
	plyr_spd=1 -- speed
end -- /function make_plyr()

-- make key
function make_key()
	key_n=2
	key_x=116
	key_y=60
end -- /function make_key()
-->8
-- move player
function move_plyr()

	-- move left
	if btn(⬅️) then
		plyr_x = plyr_x - plyr_spd
	end -- /if btn(⬅️)
	
	-- move right
	if btn(➡️) then
		plyr_x = plyr_x + plyr_spd
	end -- /if btn(➡️)
	
	-- move up
	if btn(⬆️) then
		plyr_y = plyr_y - plyr_spd
	end -- /if btn(⬆️)
	
	-- move down
	if btn(⬇️) then
		plyr_y = plyr_y + plyr_spd
	end -- /if btn(⬇️)
	
end -- /function move_plyr()
-->8
-- *** animate key
function anim_key()
	
	-- rate of animation
	rate = 9

	-- range of animation
	anim_start = 2
	anim_end = 4

	-- start timer
	timer = timer + 1
	
	-- every few frames, swap
	-- the key's sprite
	if timer >= rate then
	
		-- go to next sprite
		key_n = key_n + 1 
		
		-- if key sprite reaches end
		-- of loop, go back to start
		if key_n > anim_end then
			key_n = anim_start
		end -- /if key > anim_end
		
		-- reset timer
		timer = 0
	end -- /if timer >= rate
	
end -- /function anim_key()
__gfx__
000000000099990000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009aaaa9000000000000000700a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007009aaaa5a90000066600700666000007770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770009aaaaaa96666660666666606777777070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770009aaaaaa96060066660600666707007770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007009aaaaaa90000000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009aaaa9000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
