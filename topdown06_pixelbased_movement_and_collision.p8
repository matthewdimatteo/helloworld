pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- topdown adventure example
-- example 06
-- pixel-based movement/collision
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: make player
-- tab 2: move player

-- runs once at start
function _init()
	make_plyr() -- tab 1
	
	-- target x,y (where the plyr
	-- is trying to move to)
	tx=plyr.x
	ty=plyr.y
	
	-- check other side of sprite
	tx2=tx
	ty2=ty
	
end -- end function _init()

-- loops 30x/sec
function _update()
 	move_plyr() -- tab 2
end -- end function _update()

-- loops 30x/sec
function _draw()
	cls() -- clear screen
	map() -- draw map at 0,0
	spr(plyr.n,plyr.x,plyr.y)
	
	-- draw target x,y
	rect(tx,ty,tx,ty,7)
	rect(tx2,ty2,tx2,ty2,7)
end -- end function _draw()
-->8
-- make player
function make_plyr()
	plyr = {} -- player object
	
	-- sprite number
	plyr.n=64
	
	-- x,y pixel coordinates
	plyr.x=8*8 -- 64
	plyr.y=7*8 -- 56
	
	-- width and height (in pixels)
	plyr.w=8
	plyr.h=8
	
	-- player speed
	plyr.spd = 2
	
end -- end function make_plyr()
-->8
-- move player
function move_plyr()
	
	-- move left
	if btn(⬅️) then
		tx=plyr.x-1
		ty=plyr.y
		
		tx2=tx
		ty2=plyr.y+plyr.h-1
	end -- end if btn(⬅️)
	
	-- move right
	if btn(➡️) then
		tx=plyr.x+plyr.w+1
		ty=plyr.y
		
		tx2=tx
		ty2=plyr.y+plyr.h-1
	end -- end if btn(➡️)
	
	-- move up
	if btn(⬆️) then
		tx=plyr.x
		ty=plyr.y-1
		
		tx2=plyr.x+plyr.w-1
		ty2=ty
	end -- end if btn(⬆️)
	
	-- move down
	if btn(⬇️) then
		tx=plyr.x
		ty=plyr.y+plyr.h+1
		
		tx2=plyr.x+plyr.w-1
		ty2=ty
	end -- end if btn(⬇️)
	
	-- convert from pixels to tiles
	-- divide by 8 and round down
	x1=flr(tx/8)
	y1=flr(ty/8)
	x2=flr(tx2/8)
	y2=flr(ty2/8)
	
	-- mget finds the sprite number
	-- of a tile at an x,y location
	-- but it needs this value in
	-- terms of map tiles, not px
	tile=mget(x1,y1)
	tile2=mget(x2,y2)
	
	-- fget finds whether a flag
	-- is turned on for a sprite
	-- it needs the sprite number
	-- and flag number
	is_wall=fget(tile,0)
	is_wall2=fget(tile2,0)
	
	-- only move if not a wall at
	-- target location
	if not is_wall
	and not is_wall2 then
	 
		-- move left
		if btn(⬅️) then
			plyr.x -= plyr.spd
		end -- end if btn(⬅️)
		
		-- move right
		if btn(➡️) then
			plyr.x += plyr.spd
		end -- end if btn(➡️)
		
		-- move up
		if btn(⬆️) then
			plyr.y -= plyr.spd
		end -- end if btn(⬆️)
		
		-- move down
		if btn(⬇️) then
			plyr.y += plyr.spd
		end -- end if btn(⬇️)
		
	end -- end if not is_wall

	-- keep on screen left
	if plyr.x < 0 then
		plyr.x = 0
	end -- end if plyr.x < 0
	
	-- keep on screen top
	if plyr.y < 0 then
	 plyr.y = 0
	end -- end if plyr.y < 0
	
end -- end function move_plyr()
__gfx__
00000000bbbbbbbbbbbbbbbbbb5555bbbbb33bbbbbb33bbbbbbbbbbbbbbbbbbb00000000bbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000
00000000bbbbbbbbbbbbbbbbb555555bbb3333bbbb3333bbbbbbbbbbbbbbbbbb00000000bbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000
00700700bbbbbbbbb3ebbbbb55555555b338333bb333333bbbbbebbbbbbbbbbb00000000bbbbbbb5555555555bbbbbbb00000000000000000000000000000000
00077000bbbbbbbbbb3bbbbb555555553333383333333333bbbe3ebbbbbbbbbb00000000bbbbbb555555555555bbbbbb00000000000000000000000000000000
00077000bbbbbbbbbbbbbbe355555555b383333bb333333bbbbb3bbbbbb33bbb00000000bbbbb55555555555555bbbbb00000000000000000000000000000000
00700700bbbbbbbbbbb3bb3b55555555bb3333bbbb3333bbbbbbbbbbbb3333bb00000000bbbb5555555555555555bbbb00000000000000000000000000000000
00000000bbbbbbbbbbe3bbbbb005500bbbb44bbbbbb44bbbbbbbbbbbbbbbbbbb00000000bbb555555555555555555bbb00000000000000000000000000000000
00000000bbbbbbbbbbbbbbbbbb0000bbbbb44bbbbbb44bbbbbbbbbbbbbbbbbbb00000000bb55555555555555555555bb00000000000000000000000000000000
000000001111111111111111115555111111111111111111111111111111111100000000bb55555555555555555555bb00000000000000000000000000000000
000000001111111111111111155555511111111111111111111111111111111100000000bb55555555555555555555bb00000000000000000000000000000000
000000001111111111cc1111555555551111ccc111c1c1c111bbbb111111111100000000bb55555555555555555555bb00000000000000000000000000000000
000000001111111111111111555555551ccc11111c1c1c1111beeb111111111100000000bb55555555555555555555bb00000000000000000000000000000000
00000000111111111111111155555555111111111111111111beeb111111111100000000bb55555555555555555555bb00000000000000000000000000000000
00000000111111111cc1cc11555555551111ccc111c1c1c111bbbb111111111100000000bb55555555555555555555bb00000000000000000000000000000000
000000001111111111111111155555511ccc11111c1c1c11111111111111111100000000bb55555555555555555555bb00000000000000000000000000000000
000000001111111111111111115555111111111111111111111111111111111100000000bb55555555555555555555bb00000000000000000000000000000000
000000006666666666666666656656650000000000000000000000000000000033333333bb55555555555555555555bb00000000000000000000000000000000
000000006666666666666666555555550000000000000000000000000000000033333333bbb555555555555555555bbb00000000000000000000000000000000
000000006666666666566666665666560000000000000000000000000000000099933333bbbb5555555555555555bbbb00000000000000000000000000000000
00000000666666666666656655555555000000000000000000000000000000009a999999bbbbb55555555555555bbbbb00000000000000000000000000000000
0000000066666666666666665666566600000000000000000000000000000000939aa9a9bbbbbb055555555550bbbbbb00000000000000000000000000000000
000000006666666666666666555555550000000000000000000000000000000099933a3abbbbbbb0000000000bbbbbbb00000000000000000000000000000000
0000000066666666666656666656656600000000000000000000000000000000aaa33333bbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000
000000006666666666666666555555550000000000000000000000000000000033333333bbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000
00000000999999999999999999444499333333544444444445333333000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999999999994444449333335444544445444533333000000000000000000000000000000000000000000000000000000000000000000000000
000000009999999999a9999944444444333354444444444444453333000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999999999944444444333544544445444445445333000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999999994944444444335444444444445444444533000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999999999944444444354454444544444444454453000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999699999994444449544444544444544444444445000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999999999999999444499445444444444444445444544000000000000000000000000000000000000000000000000000000000000000000000000
00044000000440000000044000044000000440000004400000000000000000000000000000000000000000000000000000000000000000000000000000000000
00099000000440000000099000099000000990000009900000000000000000000000000000000000000000000000000000000000000000000000000000000000
00099000000990000000099000099000000990000009900000000000000000000000000000000000000000000000000000000000000000000000000000000000
08888880088888800000088000088000000880000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000
80888808808888080000088800088000000880000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000
00cccc0000cccc0000000cc0000c80000008c000000c800000000000000000000000000000000000000000000000000000000000000000000000000000000000
00c00c0000c00c0000000cc0000cc000000cc000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000
00c00c0000c00c0000000cc0000cc000000cc000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000103010000000101010000000000010101030502850001010100000000000000012000000000010101000000000000000101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010201010101010102010101040100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010103010101010101010102010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0502010101010101040101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101020101010101010301010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010501010101010201010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010301010101010501010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501020101010101010101020101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101020101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0501010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000c05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500002a05035050350500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00050000277502c750317503375037750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000