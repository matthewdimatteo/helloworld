pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- game loop

-- runs once at start
function _init()
	-- map tile sprite flags
	wall=0
	berry=1
	make_player()
	berries = 0
end -- end _init()

-- loops 30x/sec
function _update()
	move_player()
end -- end _update()

-- loops 30x/sec
function _draw()
	cls() -- clear screen
	map() -- draw map at 0,0
	
	-- multiply the player's x,y by 8 to convert from tiles to pixels (each tile is  8x8 pixels)
	spr(player.sp,player.x*8,player.y*8,1,1,player.flip_x,player.flip_y)

	print("Berries: "..berries,2,2,7) -- print number of berries found
end -- end _draw()
-->8

-- player
function make_player()
	player = {} -- player object
	player.sp=64
	
	-- x,y tile coords, not pixels
	player.x=2
	player.y=3
	
	player.flip_x=false
	player.flip_y=false
	player.facing="down"
end -- end make_player()

function move_player()

	-- left arrow
	if btnp(0) then
		target_x=player.x-1 -- target_x is one tile to the left of the player
		target_y=player.y
		player.sp=66 -- facing left
		player.flip_x=true
		player.facing="left"
	end -- end if left
	
	-- right arrow
	if btnp(1) then
		target_x=player.x+1 -- target_x is one tile to the right of the player
		target_y=player.y
		player.sp=66 -- facing right
		player.flip_x=false
		player.facing="right"
	end -- end if right

	-- up arrow
	if btnp(2) then
		target_x=player.x
		target_y=player.y-1 -- target_y is one tile above the player
		player.sp=65 -- facing up
		player.flip_x=false
		player.facing="up"
	end -- end if up	
	
	-- down arrow
	if btnp(3) then
		target_x=player.x
		target_y=player.y+1 -- target_y is one tile below the player
		player.sp=65 -- facing down
		player.flip_x=false
		player.facing="down"
	end -- end if down

	-- move if able to
	if can_move(target_x,target_y) then
		-- move the player to the
		-- targeted position
		player.x=target_x
		player.y=target_y
	end -- end if can_move
	
	-- play bump sfx if trying to move to a wall tile
	if (not can_move(target_x,target_y))
	and
	(
	 btn(0) or btn(1) or
	 btn(2) or btn(3)
	) then
		sfx(0)
	end -- end if not can_move
	
	-- press x to interact
	if btnp(5) then
		interact()
	end -- end if btnp(5)
	
end -- end move_player()
-->8

-- tiles and movement

-- check if the sprite for a tile has a particular flag, where:
	-- flag = the flag number you're looking for;
	-- x,y = the coords of the tile
	function is_tile(flag,x,y)
		tile=mget(x,y) -- get the sprite number of  a tile at x,y
		has_flag=fget(tile,flag) -- get the flag number of the sprite for that tile
		return has_flag -- returns true if the tile you're looking for is on the sprite for that tile
	end -- end is_tile(flag,x,y)
	
	-- determine whether player can move, based on adjacent tiles
	function can_move(x,y)
		 return not is_tile(wall,x,y) -- check for the wall flag on a tile at x,y
	
		 -- if true, the tile is a wall, which means the player cannot move there ...
		 -- so we use "not" because we want to move only if the tile is not a wall (if is_tile returns not true)
	
	end -- end can_move(x,y)
-->8

-- collection

-- inspect a tile and collect berry if it's a berry tree
function interact()
	
	-- obj_x and obj_y are the coords of the tile the player is inspecting
	obj_x=player.x
	obj_y=player.y
		
	-- increment based on direction
	if player.facing=="left" then
		obj_x-=1
	elseif player.facing=="right" then
		obj_x+=1
	elseif player.facing=="up" then
		obj_y-=1
	elseif player.facing=="down" then
		obj_y+=1
	end -- end if
	
	-- collect berry if target tile is a berry tree	
	if is_tile(berry,obj_x,obj_y) then
		get_berry(obj_x,obj_y)
	end -- end if get_berry
	
end -- end interact()

function get_berry(x,y)
	berries+=1 -- increase berry count by 1
	mset(x,y,5) -- turn the berry tree to a regular tree so that berries are not endless
	sfx(1) -- collection sound
end -- end get_berry(x,y)
__gfx__
00000000333333333333333333555533333bb333333bb33300000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000033333333333333333555555333bbbb3333bbbb3300000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700333333333be33333555555553bb8bbb33bbbbbb300000000000000000000000000000000000000000000000000000000000000000000000000000000
000770003333333333b3333355555555bbbbb8bbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700033333333333333eb555555553b8bbbb33bbbbbb300000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070033333333333b33b35555555533bbbb3333bbbb3300000000000000000000000000000000000000000000000000000000000000000000000000000000
000000003333333333eb333335555553333443333334433300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333333333333333555533333443333334433300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111111555511111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111115555551111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000
000000001111111111cc1111555555551111ccc111c1c1c111bbbb11111111110000000000000000000000000000000000000000000000000000000000000000
000000001111111111111111555555551ccc11111c1c1c1111beeb11111111110000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111155555555111111111111111111beeb11111111110000000000000000000000000000000000000000000000000000000000000000
00000000111111111cc1cc11555555551111ccc111c1c1c111bbbb11111111110000000000000000000000000000000000000000000000000000000000000000
000000001111111111111111155555511ccc11111c1c1c1111111111111111110000000000000000000000000000000000000000000000000000000000000000
00000000111111111111111111555511111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000
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
00044000000440000004400000044000000440000004400000000000000000000000000000000000000000000000000000000000000000000000000000000000
00099000000440000009900000099000000990000009900000000000000000000000000000000000000000000000000000000000000000000000000000000000
00099000000990000009900000099000000990000009900000000000000000000000000000000000000000000000000000000000000000000000000000000000
08888880088888800008800000088000000880000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000
80888808808888080008880000088000000880000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000
00cccc0000cccc00000cc000000c80000008c000000c800000000000000000000000000000000000000000000000000000000000000000000000000000000000
00c00c0000c00c00000cc000000cc000000cc000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000
00c00c0000c00c00000cc000000cc000000cc000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000103010000000000000000000000010101030502850000000000000000000000012000000000000000000000000000000101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1717171717171717171717171717171700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1717171717171717171717171717171700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505040505050505050504050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010102010101050501010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505010401010101010505050101020500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010501050505050105010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050102010105040501010105050400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0504010501050101010101020101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505010101010101010501010101050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050105050505010505010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050105050505010505040101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050105050505010505050501010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050105040505010505050405010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505010101010505010105050105010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0504010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050504050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000c05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500002a05035050350500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00050000277502c750317503375037750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000