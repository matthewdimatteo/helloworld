pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- game loop

-- runs once at start
function _init()

	-- physics
	gravity=0.3
	friction=0.85

	-- player default start pos
	player_start_x=16
	player_start_y=0

	-- camera position
	cam_x=0
	cam_y=0

	-- map: 128 px / screen (16 tiles x 8 px per tile) x 8 screens = 1024 px
	map_start=0
	map_end=1022 -- 2px buffer
	
	-- map tile flags
	ground=0
	platform=1

	-- object initialization
	make_player()

end -- end _init()

-- runs 30x per second
function _update()
	move_player()
	move_camera()
end -- end _update()

-- runs 30x per second
function _draw()
	cls() -- clear screen
	map(0,0) -- draw the map
	print("plyr: "..flr(player.x)..","..flr(player.y),cam_x+71,cam_y+2,7) -- print player position
	print("cam:  "..flr(cam_x)..","..flr(cam_y),cam_x+75,cam_y+10,7) -- print camera position
	rect(cam_x,cam_y,cam_x+8,cam_y+8) -- draw box at camera origin
	draw_player()
end -- end _draw()
-->8

-- camera
function move_camera()

	cam_x=player.x-64+player.w/2 -- center camera on player

	-- constrain to left edge
	if cam_x<map_start then 
		cam_x=map_start
	end -- end if at map_start

	-- constrain to right edge
	if player.x>=map_end-64 then 
		cam_x=map_end-125 
	end -- end if at map_end

	camera(cam_x,cam_y) -- position the camera

end -- end move_camera()
-->8

-- player

-- make_player()
function make_player()

	-- player object
	player={}
	
	-- sprite number
	player.sp=1

	-- starting position (in px)
	player.x=player_start_x
	player.y=player_start_y

	-- width and height (in px)
	player.w=8
	player.h=8

	-- sprite direction (x-axis)
	player.flip=false

	-- change in x/y
	player.dx=0
	player.dy=0

	-- max speed
	player.max_dx=2
	player.max_dy=3

	-- acceleration
	player.x_acc=0.5
	player.y_acc=4

	-- player state
	player.running=false
	player.jumping=false
	player.falling=false
	player.landed=false
	player.facing="right"
	
end -- end make_player()

-- move player
function move_player()

	player.dy+=gravity -- increment change in y by gravity
	player.dx*=friction -- if friction < 1, multiplication reduces change in x

	-- hold left
	if btn(0) then 
		player.dx-=player.x_acc
		player.running=true
		player.flip=true
		player.facing="left"
	end -- end if btn(0)

	-- hold right
	if btn(1) then 
		player.dx+=player.x_acc
		player.running=true
		player.flip=false
		player.facing="right"
	end -- end if btn(1)

	-- press up or x to jump
	if (btnp(2) or btnp(5))
	and player.landed then 
		player.dy-=player.y_acc
		player.landed=false
		sfx(6) -- jump sound
	end -- end if btnp(2 or 5)

	-- stop running when not pressing arrow keys
	if player.running 
	and not btn(0)
	and not btn(1)
	and not player.falling 
	and not player.jumping then
		player.running=false
	end -- end if player.running

	-- check vertical collision below (if dy is positive, the player is falling)
	if player.dy>0 then 

		-- set player state
		player.falling=true 
		player.landed=false 
		player.jumping=false

		-- handle collision with floor
		if map_collision(player,"down",ground) then
			player.landed=true 
			player.falling=false
			player.dy=0 -- stop moving
			player.y-=((player.y+player.h+1)%8)-1 -- correct y position
		end -- end map_collision ground

	end -- end if player.dy>0

	-- check horizontal collision left (if dx negative, the player is moving left)
	if player.dx<0 then
	 
		if map_collision(player,"left",ground) then
			player.dx=0 -- stop moving
		end -- end map_collision left

	-- check horizontal collision right (if dx positive, the player is moving right)
	elseif player.dx>0 then 
	
		if map_collision(player,"right",ground) then
			player.dx=0 -- stop moving
			player.x-=((player.x+player.w+1)%8)-1 -- correct x position to prevent getting stuck in wall
		end -- end map_collision right

	end -- end if player.dx</>0

	-- update x,y pos by dx,dy
	player.x+=player.dx
	player.y+=player.dy

	-- constrain player to left edge of map
	if player.x<map_start then 
		player.x=map_start
	end -- end if at map_start

	-- switch to jumping sprite
	if player.jumping then 
		player.sp=6
	end -- end if player.jumping

	-- default sprite
	if player.landed then 
		player.sp=1
	end -- end if player.landed

end -- end move_player()

-- draw_player
function draw_player()
	spr(player.sp,player.x,player.y,1,1,player.flip)
end -- end draw_player
-->8

-- map collision
function map_collision(obj,dir,flag)
	
	-- this function checks two points on the tile adjacent to the player:
	-- x1,y1 and x2,y2
	
	-- we can then use these coordinates to look up the tile's sprite number and whether it has a flag
	
	local x1=0
	local y1=0
	local x2=0
	local y2=0
	
	-- position of tile to left
	if dir=="left" then 
		x1=obj.x-1
		y1=obj.y+1
		x2=x1-1
		y2=y1+obj.h-3
		
	-- position of tile to right
	elseif dir=="right" then 
		x1=obj.x+obj.w
		y1=obj.y+1
		x2=x1+1
		y2=y1+obj.h-3
	
	-- position of tile above
	elseif dir=="up" then 
		x1=obj.x
		y1=obj.y-1
		x2=x1+8
		y2=y1-1
		
	-- position of tile below
	elseif dir=="down" then 
		x1=obj.x+2
		y1=obj.y+obj.h
		x2=x1+obj.w/2-1
		y2=y1+1
	end -- end if/elseif

	-- convert from pixels to tiles (each tile is 8x8 pixels)
	local point_1_x=flr(x1/8)
	local point_1_y=flr(y1/8)
	local point_2_x=flr(x2/8)
	local point_2_y=flr(y2/8)

	-- get sprite number of adjacent tile
	local point_1_sprite=mget(point_1_x,point_1_y)
	local point_2_sprite=mget(point_2_x,point_2_y)

	-- check flag on sprite for adjacent tile
	local point_1_has_flag=fget(point_1_sprite,flag)
	local point_2_has_flag=fget(point_2_sprite,flag)
	
	-- if either point of the tile is a sprite with the flag, there is collision between the player and the tile
	if point_1_has_flag or point_2_has_flag then
		return true
	else
		return false
	end -- end if/else

end -- end map_collision()

-- use this function inside move_player()
-- for example: if map_collision(player,"down",0) checks for flag 0 below player
__gfx__
00000000000000000000000000000000000000000000000000000000009499000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000008800094999900750057000000000000000000000000000000000000000000000000000000000
00700700000008000000080000000800000008000000080000000880990999990576675000000000000000000000000000000000000000000000000000000000
00077000000008800000088000000880000008800000088080008808999999990065560000000000000000000000000000000000000000000000000000000000
00077000000088080000880880008808000088080000808888888888707999990065560000000000000000000000000000000000000000000000000000000000
00700700008888888088888808888888008888c80088888808888880000999990576675000000000000000000000000000000000000000000000000000000000
00000000088888800888888000888880088888c0088888e000800800099999900750057000000000000000000000000000000000000000000000000000000000
00000000808008000008008000800800808008008080080000000000009999000000000000000000000000000000000000000000000000000000000000000000
00000000080000800000000000000000000000000000000000080800000000000000000000000000000000000000000000000000000000000000000000000000
00000000888008880000000000000b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888880000000000000bb0007777000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000008888888800330000000009b0078888700000088000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888880083800000009900078788700000880800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888800888880000099000078888700088888800000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000888800088888000099000000788870088888e000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000080800009900000000777008080080000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000aa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000a0000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aaa000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000a0000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000aaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbbbbbbbbbbbbbbbbbb000000000000000000000000000000005555555544444444000000009999999999999999999999990000000000000000
00000000bbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000066666666ffffffff000000009999999999999999999999990000000000000000
000000003333333333333333333333330000000000000000000000000000000066666666ffffffff00000000aaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
0000000034444444444444444444444300000000000000000000000000000000555555554444444400000000a4444444444444444444444a0000000000000000
000000003444444444444444444444430000000000000000000000000000000066666666ffffffff00000000a4444444444444444444444a0000000000000000
000000003444444444444444444444430000000000000000000000000000000066666666ffffffff00000000a4444444444444444444444a0000000000000000
0000000034444444444444444444444300000000000000000000000000000000555555554444444400000000a4444444444444444444444a0000000000000000
0000000034444444444444444444444300000000000000000000000000000000005555000044440000000000a4444444444444444444444a0000000000000000
bbbbbbbb344444444444444444444443bbbbbbbbbbbbbbbb333333330000000000566500004ff40099999999a4444444000000004444444a9999999999999999
bbbbbbbb344444444444444444444443bbbbbbbbbbbbbbbbc33ee33c0000000000566500004ff40099999999a4444444000000004444444a9999999999999999
333333333444444444444444444444433333333333333333cc3333cc0000000000566500004ff400aaaaaaaaa4444444000000004444444aaaaaaaaaaaaaaaaa
444444444444444444444444444444444444444334444444cccccccc0000000000566500004ff400444444444444444400000000444444444444444aa4444444
444444444444444444444444444444444444444334444444cccccccc0000000000566500004ff400444444444444444400000000444444444444444aa4444444
444444444444444444444444444444444444444334444444cccccccc0000000000566500004ff400444444444444444400000000444444444444444aa4444444
444444444444444444444444444444444444444334444444cccccccc0000000000566500004ff400444444444444444400000000444444444444444aa4444444
444444444444444444444444444444444444444334444444cccccccc0000000000566500004ff400444444444444444400000000444444444444444aa4444444
000000007070707000000000888888884444444334444444cccccccc111111110000000000000000777777777777777777777777000000004444444aa4444444
000000000707070700000000888888884444444334444444cccccccc111111110000000000000000777777777777777777777777000000004444444aa4444444
000000007070707000000000000660004444444334444444cccccccc111111110000000000000000666666666666666666666666000000004444444aa4444444
000000000707070700000000000660004444444334444444cccccccc111111110000000000000000111111166111111111111111000000004444444aa4444444
000000007070707000000000000660004444444334444444cccccccc111111110000000000000000111111166111111111111111000000004444444aa4444444
000000000006600088888888000660004444444334444444cccccccc111111110000000000000000111111166111111111111111000000004444444aa4444444
000000000006600088888888000660004444444334444444cccccccc111111110000000000000000111111166111111111111111000000004444444aa4444444
000000000006600000066000000660004444444334444444cccccccc111111110000000000000000111111166111111111111111000000004444444aa4444444
00000000000000000000000000000000000000000000000000000000000000000000000000000000111111166111111100000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000111111166111111100000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000111111166111111100000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000111111166111111100000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000111111166111111100000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000111111166111111100000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000111111166111111100000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000111111166111111100000000000000000000000000000000
__gff__
0000000000000041410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010101010100000303000909090000010100010101210000000909800909090000111101010000000005050500090900000000000000000000010100000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000554242424242425400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000655252525252526400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000655252525252526400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000655252525252526400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000655252525252526400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000655252525252526400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000655252525252526400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000048480000000000655252525252526400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000484858580000000000655252525252526400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000004848585858580000000000655252525252526400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000041424300000000005858585858580000000000655252525252526400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000065526400000000005858585858580000000000655252525252526400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505050505050505051525342424250505050504242425050505050515252525252525300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5252525252525252525252525252525252525252525252525252525252525252525252525252525200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5252525252525252525252525252525252525252525252525252525252525252525252525252525200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5252525252525252525252525252525252525252525252525252525252525252525252525252525200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100002355023550235502b5502b5502b55000000000002d5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000260502e050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002d0502d050270502605021050200501b05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001605007050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002073027750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002405020050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200001b7501f7501f7500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500000d7500d750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000