pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- top-down series
-- example 07:
-- pixel-based item collection
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: make player
-- tab 2: move player

-- runs once at start
function _init()
	-- map tile sprite flags
	wall=0
	berry=1
	make_plyr() -- tab 1

	-- number collected
	berries = 0

	-- map collision variables:
	-- coordinates of location
	-- the player is trying to
	-- move to (set to a default
	-- value here to initialize)
	wall_x1=plyr.x
	wall_y1=plyr.y
	wall_x2=wall_x1
	wall_y2=wall_y1

	berry_x1=plyr.x
	berry_y1=plyr.y
	berry_x2=berry_x1
	berry_y2=berry_y1
	
	-- sprite numbers of map tiles
	-- to check collision with
	-- (also just given a default
	-- value to initialize)
	wall1=0
	wall2=0
	berry1=0
	berry2=0
	
	-- boolean (true/false) values
	-- for whether there is a wall
	-- tile at the location the
	-- player is trying to move to
	-- (also just given a default
	-- value to initialize)
	is_wall1=0 -- has flag (point 1)
	is_wall2=0 -- has flag (point 2)
	is_berry1=0
	is_berry2=0

end -- end _init()

-- loops 30x/sec
function _update()
	move_plyr()
end -- end _update()

-- loops 30x/sec
function _draw()
	cls() -- clear screen
	map() -- draw map at 0,0
	
	-- draw the player
	spr(plyr.n,plyr.x,plyr.y,plyr.w/8,plyr.h/8,plyr.flip)

	-- inventory count
	print("Berries: "..berries,2,2,14) 

	-- print flag-checking boolean
	-- values (true if wall)
	if is_berry1 == true then
		print("berry pt 1",70,2,14)
	else
		print("no berry pt 1",70,2,7)
	end -- end if is_berry1 == true
	if is_berry2 == true then
		print("berry pt 2",70,10,14)
	else
		print("no berry pt 2",70,10,7)
	end -- end if is_berry2 == true

	-- draw target coords as dots
	rect(berry_x1,berry_y1,berry_x1,berry_y1,14) 
	rect(berry_x2,berry_y2,berry_x2,berry_y2,14) 

end -- end _draw()
-->8
-- make player
function make_plyr()
	plyr = {} -- player object
	plyr.n=64
	
	-- x,y pixel coordinates
	plyr.x=32
	plyr.y=32
	plyr.w=8
	plyr.h=8
	
	-- direction
	plyr.flip=false
	plyr.facing="down"

	plyr.spd=4 -- speed
end -- end make_plyr()
-->8
-- move player
function move_plyr()

	-- left arrow
	if btnp(⬅️) then
	
		-- wall_x1 and wall_y1 are the target
		-- x,y of the tile the player
		-- is trying to move to

		-- we check 2 points
		-- (wall_x1,wall_y1 and wall_x2, wall_y2)
		-- to check opposite sides
		-- of the player

		-- target is to the left of
		-- the player
		wall_x1=plyr.x-1
		wall_y1=plyr.y
		
		-- factor in the height for
		-- the second point
		wall_x2=wall_x1
		wall_y2=plyr.y+plyr.h-1

		-- set sprite to face the
		-- correct direction
	   	plyr.n=66 -- facing left
		plyr.flip=true
		plyr.facing="left"
	
	end -- end if left
	
	-- right arrow
	if btnp(➡️) then
	
		-- target is to the right
		-- of the player
		wall_x1=plyr.x+plyr.w
		wall_y1=plyr.y
		
		-- factor in the height for
		-- the second point
		wall_x2=wall_x1
		wall_y2=plyr.y+plyr.h-1

		-- set sprite to face the
		-- correct direction
		plyr.n=66 -- facing right
		plyr.flip=false
		plyr.facing="right"
	 
	end -- end if right

	-- up arrow
	if btnp(⬆️) then
	
		-- target is above the player
		wall_x1=plyr.x
		wall_y1=plyr.y-1
		
		-- factor in the width for the
		-- second point
		wall_x2=plyr.x+plyr.w-1
		wall_y2=wall_y1

		-- set sprite to face the
		-- correct direction
		plyr.n=65 -- facing up
		plyr.flip=false
		plyr.facing="up"
	 
	end -- end if up	
	
	-- down arrow
	if btnp(⬇️) then
	
		-- target is below the player
		wall_x1=plyr.x
		wall_y1=plyr.y+plyr.h
		
		-- factor in the width for the
		-- second point
		wall_x2=plyr.x+plyr.w-1
		wall_y2=wall_y1

		-- set sprite to face the
		-- correct direction
		plyr.n=64 -- facing down
		plyr.flip=false
		plyr.facing="down"
  
	end -- end if btn ⬇️

	if plyr.facing == "left" then 
		berry_x1=plyr.x-1
		berry_x2=berry_x1
		berry_y1=plyr.y
		berry_y2=plyr.y+plyr.h-1
	elseif plyr.facing == "right" then 
		berry_x1=plyr.x+plyr.w
		berry_x2=berry_x1
		berry_y1=plyr.y
		berry_y2=plyr.y+plyr.h-1
	elseif plyr.facing == "up" then 
		berry_x1=plyr.x
		berry_x2=plyr.x+plyr.w-1
		berry_y1=plyr.y-1
		berry_y2=berry_y1
	elseif plyr.facing == "down" then 
		berry_x1=plyr.x
		berry_x2=plyr.x+plyr.w-1
		berry_y1=plyr.y+plyr.h
		berry_y2=berry_y1
	end 

	-- feed target x,y into mget
	-- to get sprite number of tile
	-- the player is trying to move
	-- to (divide berry_y1 8 to convert
	-- from pixels to tiles, and
	-- use flr to round down
	wall1=mget(flr(wall_x1/8),flr(wall_y1/8))
	wall2=mget(flr(wall_x2/8),flr(wall_y2/8))
	
	-- feed sprite number into fget
	-- to check whether that sprite
	-- has flag 0 (wall) turned on
	is_wall1=fget(wall1,0)
	is_wall2=fget(wall2,0)
	
	-- hf1/hf2 will return false if
	-- no wall flag is turned on;
	-- move the player in this case
	if is_wall1 == false 
	and is_wall2 == false
	then
	
		-- move left
		if btnp(⬅️) then
			plyr.x-=plyr.spd
		end -- end if btnp(⬅️)
		
		-- move right
		if btnp(➡️) then
			plyr.x+=plyr.spd
		end -- end if btnp(➡️)
		
		-- move up
		if btnp(⬆️) then
			plyr.y-=plyr.spd
		end -- end if btnp(⬆️)
		
		-- move down
		if btnp(⬇️) then
			plyr.y+=plyr.spd
		end -- end if btnp(⬇️)
		
	end -- end if hf1/hf2 false

	-- berry_x1,berry_y1 and berry_x2,berry_y2 are the
	-- pixel coordinates where
	-- we are looking for berries
	-- we divide berry_y1 8 and round down
	-- using flr() to convert from
	-- pixel coords to tile coords
	berry_tx1=flr(berry_x1/8)
	berry_ty1=flr(berry_y1/8)
	berry_tx2=flr(berry_x2/8)
	berry_ty2=flr(berry_y2/8)

	-- berry1 and berry2 are the sprite
	-- numbers of the tile we are
	-- checking for the berry flag
	-- we can feed the tile coords
	-- berry_x1,berry_y1 and berry_x2,berry_y2 into the
	-- function mget() to get that
	-- sprite number
	berry1=mget(berry_tx1,berry_ty1) -- get the sprite number of  a tile at x,y
	berry2=mget(berry_tx2,berry_ty2)

	-- is_berry1 and is_berry2 are
	-- booleans (true or false values)
	-- for whether the tile checked
	-- is a sprite with the berry flag
	is_berry1=fget(berry1,berry)
	is_berry2=fget(berry2,berry)

	-- press x to interact
	if btnp(❎) then
		-- collect berry if target tile is a berry tree	
		if is_berry1 then
			get_berry(berry_tx1,berry_ty1)
		elseif is_berry2 then
		 	get_berry(berry_tx2,berry_ty2)
		end -- end if get_berry
		
	end -- end if btnp(❎)
	
end -- end move_plyr()	

-- collect
function get_berry(x,y)
	berries+=1 -- increase berry count berry_y1 1
	mset(x,y,5) -- turn the berry tree to a regular tree so that berries are not endless
	sfx(1) -- collection sound
end -- end get_berry(x,y)
__gfx__
00000000bbbbbbbbbbbbbbbb33555533333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbbbbbbbbbb35555553333ee3333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700bbbbbbbbbbbbbbbb5555555533eeee333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000bbbbbbbbbbb33bbb555555553eeeeee33333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000bbbbbbbbbbbbbbbb555555553eeeeee33333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700bbbbbbbbbb3333bb5555555533eeee333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbbbbbbbbbb35555553333ee3333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbbbbbbbbbb33555533333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111111555511111111111111111111111111111111111111111100000000000000000000000000000000000000000000000000000000
00000000111111111111111115555551111111111111111111111111111111111111111100000000000000000000000000000000000000000000000000000000
000000001111111111cc1111555555551111ccc111c1c1c111bbbbe1111111111111111100000000000000000000000000000000000000000000000000000000
000000001111111111111111555555551ccc11111c1c1c1111beebe1111111111111111100000000000000000000000000000000000000000000000000000000
00000000111111111111111155555555111111111111111111beebe1111111111111111100000000000000000000000000000000000000000000000000000000
00000000111111111cc1cc11555555551111ccc111c1c1c111bbbbe1111111111111111100000000000000000000000000000000000000000000000000000000
000000001111111111111111155555511ccc11111c1c1c1111111111111111111111111100000000000000000000000000000000000000000000000000000000
00000000111111111111111111555511111111111111111111111111111111111111111100000000000000000000000000000000000000000000000000000000
00000000666666666666666665665665000000000000000000000000000000003333333300000000000000000000000000000000000000000000000000000000
00000000666666666666666655555555000000000000000000000000000000003333333300000000000000000000000000000000000000000000000000000000
00000000666666666656666666566656000000000000000000000000000000009993333300000000000000000000000000000000000000000000000000000000
00000000666666666666656655555555000000000000000000000000000000009a99999900000000000000000000000000000000000000000000000000000000
0000000066666666666666665666566600000000000000000000000000000000939aa9a900000000000000000000000000000000000000000000000000000000
000000006666666666666666555555550000000000000000000000000000000099933a3a00000000000000000000000000000000000000000000000000000000
0000000066666666666656666656656600000000000000000000000000000000aaa3333300000000000000000000000000000000000000000000000000000000
00000000666666666666666655555555000000000000000000000000000000003333333300000000000000000000000000000000000000000000000000000000
00000000999999999999999999444499333333544444444445333333000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999999999994444449333335444544445444533333000000000000000000000000000000000000000000000000000000000000000000000000
000000009999999999a9999944444444333354444444444444453333000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999999999944444444333544544445444445445333000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999999994944444444335444444444445444444533000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999999999944444444354454444544444444454453000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999699999994444449544444544444544444444445000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999999999999444499445444444444444445444544000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccc75cc57ccccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccc77cc77cccccc47700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ccccccccc44cc44cccccc47500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cccccccccccccccccccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cccccccccccccccccccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c44cc44cccccccccccccc47500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c77cc77cccccccccccccc47700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c75cc57ccccccccccccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000103010000000000000000000000010101030502850000000000000000000000012000000000000000000000000000000101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1717171717171717171717171717171700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1717171717171717171717171717171700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505040505040505050504050504050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101050501010400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505010101010101010504050101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0401010101010101040505040105010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050101010105040501010105040500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0504010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505010101010101010501010101050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050105040505010405010101010400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050105050505010505040101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505040105050504010505050501010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050105040505010505050405010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505010101010505010105050105010400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0504010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050504050504050505050504050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000c05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500002a05035050350500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00050000277502c750317503375037750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000