pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- game loop

-- runs once at start
function _init()
	-- map tile sprite flags
	wall=0
	make_player()
	
	target_x=player.x
	target_y=player.y
	
	target_x2=0
	target_y2=0
	
end -- end _init()

-- loops 30x/sec
function _update()
	move_player()
end -- end _update()

-- loops 30x/sec
function _draw()
	cls() -- clear screen
	map() -- draw map at 0,0
	
	-- multiply the player's x,y
	-- by 8 to convert from tiles
	-- to pixels (each tile is
	-- 8x8 pixels)
	spr(player.sp,player.x*8,player.y*8,player.sw,player.sh,player)
	--rect(target_x*8,target_y*8,(player.sw*8)+(target_x*8)-1,(player.sh*8)+(target_y*8)-1,8)
	
	-- draw target coords as dots
 rect(target_x*8,target_y*8,target_x*8,target_y*8,8) 
	rect(target_x2*8,target_y2*8,target_x2*8,target_y2*8,8) 
 	 
	-- print tile coodinates
	print("tile  "..player.x..","..player.y,2,2,7)

	-- print pixel coordinates
	print("pixel "..(player.x*8)..","..(player.y*8),2,10,7)
end -- end _draw()
-->8
-- player
function make_player()
	player = {} -- player object
	player.sp=70
	player.sw=3 -- sprite 3 tiles wide
	player.sh=3 -- sprite 3 tiles tall
	
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
	
	 -- target_x is one tile to
	 -- the left of the player
		target_x=player.x-1
		target_y=player.y
		player.facing="left"
		
		target_x2=target_x
		target_y2=player.y+player.sh-1
	end -- end if left
	
	-- right arrow
	if btnp(1) then
	
	 -- target_x is one player width
	 -- to the right of the player
		target_x=player.x+player.sw
		target_y=player.y
		player.facing="right"
		
		-- we also need to check the
		-- lower side of the quadrant
		-- to the right
		target_x2=target_x
		target_y2=player.y+player.sh-1
	end -- end if right

	-- up arrow
	if btnp(2) then
	
	 -- target_y is one tile
	 -- above the player
		target_x=player.x
		target_y=player.y-1
		player.facing="up"
		
		target_x2=player.x+player.sw-1
		target_y2=target_y
	end -- end if up	
	
	-- down arrow
	if btnp(3) then
	
	 -- target_y is one player width
	 -- below the player
		target_x=player.x
		target_y=player.y+player.sh
		player.facing="down"
		
		-- we also need to check the
		-- right side of the quadrant
		-- below the player
		target_x2=player.x+player.sw-1
  target_y2=target_y
	end -- end if down

	-- move if able to
	if can_move(target_x,target_y)
	and can_move(target_x2,target_y2)
	then
		-- move the player to the
		-- targeted position
		
		-- because we must check
		-- multiple tiles to the right
		-- or below the player, but
		-- only want to move one tile
		-- at a time, we must reset
		-- target_x/y here
		if btnp(1) then
		 target_x = player.x+1
		end
		if btnp(3) then
		 target_y = player.y+1
		end
		
		player.x=target_x
  player.y=target_y
		
	end -- end if can_move
	
	-- play bump sfx if trying
	-- to move to a wall tile
	if
 (
  not can_move(target_x,target_y)
  or not can_move(target_x2,target_y2)
 )
	and
	(
	 btn(0) or btn(1) or
	 btn(2) or btn(3)
	) then
		sfx(0)
	end -- end if not can_move
	
end -- end move_player()
-->8
-- tiles and movement

-- check if the sprite for a tile
-- has a particular flag, where:
-- flag = the flag number you're
-- looking for, and
-- x,y = the coords of the tile
function is_tile(flag,x,y)

 -- get the sprite number of
 -- a tile at x,y
	tile=mget(x,y)
	
	-- get the flag number of
	-- the sprite for that tile
	has_flag=fget(tile,flag)
	
	-- returns true if the tile
	-- you're looking for is on
	-- the sprite for that tile
	return has_flag
	
end -- end is_tile(flag,x,y)

-- determine whether player can
-- move, based on adjacent tiles
function can_move(x,y)

 -- here, is_tile() checks for
 -- the wall flag on a tile
 -- at x,y
 return not is_tile(wall,x,y)
 
 -- if true, the tile is a wall
 -- which means the player
 -- cannot move there ...
 
 -- so we use "not" because
 -- we want to move only if
 -- the tile is not a wall,
 -- or if is_tile returns
 -- not true
	
end -- end can_move(x,y)
__gfx__
00000000bbbbbbbb3333333333555533bbb33bbbbbb33bbb00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb3333333335555553bb3333bbbb3333bb00000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700bbbbbbbb3be3333355555555b338333bb333333b00000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000bbbbbbbb33b3333355555555333338333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000bbbbbbbb333333eb55555555b383333bb333333b00000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700bbbbbbbb333b33b355555555bb3333bbbb3333bb00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb33eb333335555553bbb44bbbbbb44bbb00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb3333333333555533bbb44bbbbbb44bbb00000000000000000000000000000000000000000000000000000000000000000000000000000000
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
000440000004400000044000000440000004400000044000aaaaaaaaaaaaaaaaaaaaaaaa00000000b7b7b7b7b7b737b7b7b7b7bb000000000000000000000000
000990000004400000099000000990000009900000099000aaaaaaaaaaaaaaaaaaaaaaaa000000007bbbbbbbbb3333bbbbbbbbb7000000000000000000000000
000990000009900000099000000990000009900000099000aaaaccccccccccccccccaaaa00000000bbbbbbbbb333333bbbbbbbbb000000000000000000000000
088888800888888000088000000880000008800000088000aaaccccccccccccccccccaaa000000007bbbbbbb33333333bbbbbbb7000000000000000000000000
808888088088880800088800000880000008800000088000aaccccccccccccccccccccaa00000000bbbbbbb3333333333bbbbbbb000000000000000000000000
00cccc0000cccc00000cc000000c80000008c000000c8000aacccc444cccccc444ccccaa000000007bbbbb333333333333bbbbb7000000000000000000000000
00c00c0000c00c00000cc000000cc000000cc000000cc000aacccc777cccccc777ccccaa00000000bbbbb33333333333333bbbbb000000000000000000000000
00c00c0000c00c00000cc000000cc000000cc000000cc000aacccc747cccccc747ccccaa000000007bbb3333333333333333bbb7000000000000000000000000
000000000000000000000000000000000000000000000000aacccc777cccccc777ccccaa00000000bbb333333333333333333bbb000000000000000000000000
000000000000000000000000000000000000000000000000aaccccccccccccccccccccaa000000007b33333333333333333333b7000000000000000000000000
000000000000000000000000000000000000000000000000aaccccccccccccccccccccaa00000000b3333333333333333333333b000000000000000000000000
000000000000000000000000000000000000000000000000aaccccccccccccccccccccaa00000000733333333333333333333337000000000000000000000000
000000000000000000000000000000000000000000000000aaccccccccccccccccccccaa00000000b33333333333333333333333000000000000000000000000
000000000000000000000000000000000000000000000000aaccccccc888888cccccccaa00000000733333333333333333333337000000000000000000000000
000000000000000000000000000000000000000000000000aacccccc88555588ccccccaa00000000bb33333333333333333333bb000000000000000000000000
000000000000000000000000000000000000000000000000aacccccc85555558ccccccaa000000007bb333333333333333333bb7000000000000000000000000
000000000000000000000000000000000000000000000000aacccccc85555558ccccccaa00000000bbbb3333333443333333bbbb000000000000000000000000
000000000000000000000000000000000000000000000000aacccccc88555588ccccccaa000000007bbbb33333444433333bbbb7000000000000000000000000
000000000000000000000000000000000000000000000000aaccccccc888888cccccccaa00000000bbbbbb333444444333bbbbbb000000000000000000000000
000000000000000000000000000000000000000000000000aaccccccccccccccccccccaa000000007bbbbbbbbb4444bbbbbbbbb7000000000000000000000000
000000000000000000000000000000000000000000000000aaaccccccccccccccccccaaa00000000bbbbbbbbbb4444bbbbbbbbbb000000000000000000000000
000000000000000000000000000000000000000000000000aaaaccccccccccccccccaaaa000000007bbbbbbbbb4444bbbbbbbbb7000000000000000000000000
000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaa00000000bbbbbbbbbb4444bbbbbbbbbb000000000000000000000000
000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaa00000000b7b7b7b7b74747b7b7b7b7b7000000000000000000000000
__gff__
0000000103010000000000000000000000010101030502850000000000000000000000012000000000000000000000000000000101010100000000000000000000000000000000000000010101000000000000000000000000000101010000000000000000000000000001010100000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1717171717171717171717171717171700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1717171717171717171717171717171700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101014a4b4c0101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101015a5b5c0101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101016a6b6c0101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000c05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500002a05035050350500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00050000277502c750317503375037750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000