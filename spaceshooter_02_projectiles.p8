pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- spaceshooter series
-- example 02: projectiles
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: make_plyr()
-- tab 2: move_plyr()
-- tab 3: shoot()
-- tab 4: laser functions

function _init()
	friction = 0.9
	make_plyr()
	lasers = {} -- create table of lasers
end

function _update()
	move_plyr()

	-- foreach takes an array 
	-- (the 1st value) and runs
	-- a function (2nd value)
	-- for each item in the array
	foreach(lasers,move_laser) 
end

function _draw()
	cls()

	-- draw the player
	spr(plyr.n,plyr.x,plyr.y,1,1,plyr.flpx,plyr.flpy)

	-- draw all lasers
	foreach(lasers,draw_laser)

	-- display current ammo
	print("ammo: "..plyr.ammo,2,2,10)
end
-->8
-- make_plyr
function make_plyr()
	plyr = {}
	plyr.n = 1
	plyr.x = 60
	plyr.y = 60
	plyr.w = 8
	plyr.h = 8
	plyr.flpx = false
	plyr.flpy = false
	plyr.dir = "up"
	plyr.dx = 0
	plyr.dy = 0
	plyr.spd = 0.5
	plyr.ammo = 100
end
-->8
-- move_plyr
function move_plyr()

	-- apply friction
	plyr.dx *= friction
	plyr.dy *= friction
 
	-- left arrow
	if btn(⬅️) then
		-- negative because x values 
		-- increase from left to right,
		-- so moving left will be a 
		-- smaller value
		plyr.dx -= plyr.spd 
		
		-- horizontal sprite
		plyr.n = 2

		-- don't flip since plyr 
		-- sprite faces left by default
		plyr.flpx = false

		-- set direction
		plyr.dir = "left"
       
	end -- end if btn(⬅️)
    
	-- right arrow
	if btn(➡️) then

		-- positive because x values 
		-- increase from left to right
		-- so moving right will be a
		-- larger value
		plyr.dx += plyr.spd
		
		-- horizontal sprite
		plyr.n = 2

		-- flip the sprite (left-facing 
		-- by default) to face right 
		-- while moving right
		plyr.flpx = true

		-- set direction
		plyr.dir = "right"
       
	end -- end if btn(➡️)
    
	-- up arrow
	if btn(⬆️) then

		-- negative because y values
		-- increase going lower on the 
		-- screen, so moving up will be
		-- a smaller value
		plyr.dy -= plyr.spd

		-- vertical sprite
		plyr.n = 1
		
		-- don't flip since plyr sprite
		-- faces up by default
		plyr.flpy = false

		-- set direction
		plyr.dir = "up"
      
	end -- end if btn(⬆️)
    
	-- down arrow
	if btn(⬇️) then

		-- positive because y values
		-- increase going lower on screen,
		-- so moving down will be a 
		-- larger value
		plyr.dy += plyr.spd

		-- vertical sprite
		plyr.n = 1
		
		-- flip the sprite (up-facing by
		-- default) to face down while 
		-- moving down
		plyr.flpy = true

		-- set direction
		plyr.dir = "down"
    
	end -- end if down arrow
    
	-- update position (dx and dy 
	-- calculated based on which 
	-- arrow key is pressed)
	plyr.x += plyr.dx
	plyr.y += plyr.dy

	-- keep on screen left
	if plyr.x < 0 then
		plyr.x = 0
	end
    
	-- keep on screen right (factor
	-- in sprite's width)
	if plyr.x > 128-plyr.w then
		plyr.x = 128-plyr.w
	end
    
	-- keep on screen top
	if plyr.y < 0 then
		plyr.y = 0
	end
    
	-- keep on screen bottom
	-- (factor in sprite's height)
	if plyr.y > 128-plyr.h then
		plyr.y = 128-plyr.h
	end

	-- press x to shoot
	if btn(❎) then
		shoot()
	end -- end if btn(❎)

end -- end move_plyr()
-->8
-- shoot()
function shoot()
 	
	-- only shoot if has ammo
	if plyr.ammo > 0 then
  
		-- subtract ammo and play sfx
		plyr.ammo -= 1
		sfx(0)
  	
		-- constrain ammo to 0
		if plyr.ammo < 0 then
			plyr.ammo = 0
		end -- end if plyr.ammo < 0
  	
		-- set laser position, direction
		if plyr.dir == "left" then
			make_laser(plyr.x-4, plyr.y,plyr.dir)
		elseif plyr.dir == "right" then
			make_laser(plyr.x+4, plyr.y,plyr.dir)
		elseif plyr.dir == "up" then
			make_laser(plyr.x, plyr.y-4,plyr.dir)
		elseif plyr.dir == "down" then
			make_laser(plyr.x, plyr.y+4,plyr.dir)
		end -- end if dir
			
	-- if no ammo
	else
		sfx(1) -- empty sfx
	end -- end if plyr.ammo > 0
	
end -- end function shoot()
-->8
-- laser functions

-- create an individual laser
-- at the player's position
function make_laser(x,y,dir)
	
	-- create a laser object
	local laser = {}
    
	-- pass the values x,y,dir
	-- from the function
	laser.x = x
	laser.y = y
	laser.dir = dir
    
	-- w,h reflect sprite px size
	laser.w=4
	laser.h=4
    
	-- not moving by default
	laser.dx=0
	laser.dy=0
    
	-- add the laser to the table
	add(lasers,laser)
 
end -- end make_laser(x,y,dir)

-- move the laser in the
-- direction the player was
-- facing when they fired
function move_laser(laser)

	-- negative dx to move left
	if laser.dir == "left"
	then
 	laser.dx = -4
 	laser.dy = 0
 
	-- positive dx to move right
	elseif laser.dir == "right"
	then
		laser.dx = 4
		laser.dy = 0
  
	-- negative dy to move up
	elseif laser.dir == "up"
	then
		laser.dx = 0
		laser.dy = -4
 
	-- positive dy to move down
	elseif laser.dir == "down"
	then
		laser.dx = 0
		laser.dy = 4
	end -- end if dir
 
	-- update x,y by dx,dy
	laser.x += laser.dx
	laser.y += laser.dy
 
	-- delete the laser if
	-- off-screen
	if laser.x < 0
	or laser.x > 128
	or laser.y < 0
	or laser.y > 128
	then
		del(lasers,laser)
	end -- end if laser off-screen
 
end -- end move_laser(laser)

-- draw the laser on screen
function draw_laser(laser)
	spr(3,laser.x,laser.y)
end
__gfx__
00000000000cc000000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000cc0000000cccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000cccc0000cccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000cccc00cccccccc000aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000cccccc0cccccccc000aa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000cccccc000cccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccc0000cccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccc000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008888000088888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008888008888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888808888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888800088888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888880000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888880000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000990000000009900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000990000000999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009999000099999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009999009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000099999909999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000099999900099999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999990000999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000999999990000009900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000292502c2502f2503125000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200002a7502c7502f750317502c700307003370000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500000f05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
