pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- top-down series
-- example 01: movement
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: make player
-- tab 2: move player
-- tab 3: animate player

-- runs once at start
function _init()
	make_plyr() -- tab 1
end -- end _init()

-- loops 30x/sec
function _update()
	move_plyr() -- tab 2
end -- end _update()

-- loops 30x/sec
function _draw()
	cls() -- clear screen
	map() -- draw map at 0,0
	spr(plyr.n,plyr.x,plyr.y,plyr.w/8,plyr.h/8,plyr.flip)
	
	-- print direction & spr info
	print("facing "..plyr.facing,2,2,7)
	print("sprite "..plyr.n,2,10,7) 
	if plyr.flip then
	 print("flipped",2,18,7)
	end -- end if plyr.flip
		
	-- instructions
	print("press ❎ to run!",64,2,c)
	print("speed: "..plyr.spd,95,10,c)

	-- print x,y position
	print(plyr.x..","..plyr.y,
	plyr.x-6,plyr.y-6,0) 
end -- end _draw()
-->8
-- make player
function make_plyr()
	plyr = {} -- player object
	
	-- sprite number
	plyr.n=64
	
	-- x,y pixel coordinates
	plyr.x=60
	plyr.y=60
	
	-- width and height (px)
	plyr.w=8
	plyr.h=8
	
	-- direction
	plyr.facing="down"
	plyr.flip=false
	
	plyr.spd=1 -- speed
	
end -- end make_plyr()
-->8
-- move player
function move_plyr()
	
	-- hold ❎ to run
	if btn(❎) then
	 	plyr.spd = 3
	 	c=10 -- color to print speed
	else
	 	plyr.spd = 1
	 	c=7 -- color to print speed
	end -- end if btn(❎)
	
	-- move left
	if btn(⬅️) then
		plyr.x-=plyr.spd
		plyr.n=66
		plyr.flip=true
	end -- end if btn(⬅️)
		
	-- move right
	if btn(➡️) then
		plyr.x+=plyr.spd
		plyr.n=66
		plyr.flip=false
	end -- end if btn(➡️)
		
	-- move up
	if btn(⬆️) then
		plyr.y-=plyr.spd
		plyr.n=65
		plyr.flip=false
	end -- end if btn(⬆️)
		
	-- move down
	if btn(⬇️) then
		plyr.y+=plyr.spd
		plyr.n=64
		plyr.flip=false
	end -- end if btn(⬇️)
	
	-- constrain to screen
	if plyr.x < 7 then 
	 	plyr.x=7
	end
	if plyr.x > 118-plyr.w then
	 	plyr.x=118-plyr.w
	end
	if plyr.y < 31 then
	 	plyr.y=31
	end
	if plyr.y > 128-plyr.h then
	 	plyr.y=128-plyr.h
	end -- end if
	
end -- end move_plyr()
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
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000c05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500002a05035050350500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00050000277502c750317503375037750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000