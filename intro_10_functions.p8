pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- intro to game programming
-- lesson 10: functions
-- by matthew dimatteo

-- *** tab 0: game loop
-- *** tab 1: make player, key
-- *** tab 2: move player

-- runs once at start
-- variables, objects
function _init()
	make_plyr() -- *** tab 1
	make_key() -- *** tab 1
end -- /function _init()

-- runs 30x/sec
-- movement, calculation
function _update()
	move_plyr() -- *** tab 2	
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
-- *** make player, make_key

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
-- *** move player
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
__gfx__
00000000009999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009aaaa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007009aaaa5a90000066600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770009aaaaaa96666660600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770009aaaaaa96060066600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007009aaaaaa90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009aaaa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
