pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- projectiles
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: player
-- tab 2: shooting
-- tab 3: lasers

-- runs once at start
-- variables, objects
function _init()

	-- physics
	friction = 0.9

	-- game variables
	ammo = 10

	-- player variables
	make_plyr() -- tab 1
	
	-- create tables for all active
	-- sets of objects
	lasers = {}
end -- /function _init()

-- runs 30x/sec
-- movement, calculation
function _update()
	move_plyr() -- tab 1

	-- press x to shoot
	if btnp(❎) then
		shoot() -- tab 2
	end -- /if btnp(❎)

	-- manage lasers, tab 3
	foreach(lasers,move_laser)
end -- /function _updatE()

-- runs 30x/sec
-- output/graphics
function _draw()
	cls() -- refresh screen

	-- display hud
	print("ammo: "..ammo,2,2,10)
	
	-- draw player
	spr(plyr.n,plyr.x,plyr.y,1,1,plyr.flpx,plyr.flpy)

	-- draw lasers, tab 3
	foreach(lasers,draw_laser)
end -- /function _draw()
-->8
-- player

-- make player
-- call this function in _init()
function make_plyr()

	-- table
	plyr = {}

	-- sprite number
	plyr.n = 1

	-- x,y coords
	plyr.x = 60
	plyr.y = 60

	-- width,height
	plyr.w = 8
	plyr.h = 8

	-- sprite flip
	plyr.flpx = false
	plyr.flpy = false

	-- direction
	plyr.dir = "up"

	-- base speed
	plyr.spd = 0.5

	-- active x,y speed
	plyr.dx = 0
	plyr.dy = 0

end -- /function make_plyr()

-- move player
-- call this function in _update()
function move_plyr()

	-- apply friction
	plyr.dx *= friction
	plyr.dy *= friction
 
	-- move left
	if btn(⬅️) then
		-- subtract from change in x
		plyr.dx -= plyr.spd 
		
		-- horizontal sprite
		plyr.n = 2

		-- don't flip player sprite
		-- (it faces left by default)
		plyr.flpx = false

		-- set direction
		plyr.dir = "left"
       
	end -- /if btn(⬅️)
    
	-- move right
	if btn(➡️) then

		-- add to change in x
		plyr.dx += plyr.spd
		
		-- horizontal sprite
		plyr.n = 2

		-- flip sprite to face right
		plyr.flpx = true

		-- set direction
		plyr.dir = "right"
       
	end -- /if btn(➡️)
    
	-- move up
	if btn(⬆️) then

		-- subtract from change in y
		plyr.dy -= plyr.spd

		-- vertical sprite
		plyr.n = 1
		
		-- don't flip player sprite
		-- (faces up by default)
		plyr.flpy = false

		-- set direction
		plyr.dir = "up"
      
	end -- /if btn(⬆️)
    
	-- move down
	if btn(⬇️) then

		-- add to change in y
		plyr.dy += plyr.spd

		-- vertical sprite
		plyr.n = 1
		
		-- flip sprite down
		plyr.flpy = true

		-- set direction
		plyr.dir = "down"
    
	end -- /if btn(⬇️)
    
	-- update x,y by the calculated
	-- change (delta x, delta y)
	plyr.x += plyr.dx
	plyr.y += plyr.dy

	-- keep on screen left
	if plyr.x < 0 then
		plyr.x = 0
	end -- /if plyr.x < 0
    
	-- keep on screen right;
	-- factor in sprite's width
	if plyr.x > 128-plyr.w then
		plyr.x = 128-plyr.w
	end -- /if plyr.x > 128-plyr.w
    
	-- keep on screen top
	if plyr.y < 0 then
		plyr.y = 0
	end -- /if plyr.y < 0
    
	-- keep on screen bottom;
	-- factor in sprite's height
	if plyr.y > 128-plyr.h then
		plyr.y = 128-plyr.h
	end -- /if plyr.y > 128-plyr.h
	
end -- /function move_plyr()
-->8
-- shooting

-- call this function in an if
-- statement in move_plyr():

-- if btnp(❎) then
	-- shoot()
-- end
function shoot()
 	
	-- only shoot if there's ammo
	if ammo > 0 then
  
		ammo -= 1 -- subtract ammo
		sfx(0) -- play sound
  	
		-- constrain ammo to 0
		if ammo < 0 then
			ammo = 0
		end -- /if plyr.ammo < 0
  	
		-- spawn laser based on
		-- player's direction
		-- make_laser() on tab 3
		if plyr.dir == "left" then
			make_laser(plyr.x-4, plyr.y,plyr.dir)
		elseif plyr.dir == "right" then
			make_laser(plyr.x+4, plyr.y,plyr.dir)
		elseif plyr.dir == "up" then
			make_laser(plyr.x, plyr.y-4,plyr.dir)
		elseif plyr.dir == "down" then
			make_laser(plyr.x, plyr.y+4,plyr.dir)
		end -- /if-else plyr.dir
			
	-- if no ammo, play empty sound
	else
		sfx(2)
	end -- /if-else plyr.ammo > 0
	
end -- /function shoot()
-->8
-- lasers

-- create a single laser
-- at the player's position

-- call this function in shoot()
-- in an if statement providing
-- the x,y coords and direction
-- the laser should move in
function make_laser(x,y,dir)
	
	-- table (use local so each
	-- instance is separate)
	local laser = {}
    
	-- get values from function
	laser.x = x
	laser.y = y
	laser.dir = dir
    
	-- width,height
	laser.w=4
	laser.h=4
    
	-- active speed
	laser.dx=0
	laser.dy=0
    
	-- add to table
	add(lasers,laser)
 
end -- /function make_laser(x,y,dir)

-- move a single laser in the
-- direction the player was
-- facing when they fired

-- call this function using
-- foreach in _update():
-- foreach(lasers,move_laser)
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
	end -- /if-else laser.dir
 
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
	end -- /if laser off-screen
 
end -- /function move_laser()

-- draw a single laser on screen
-- call this function using
-- foreach in _draw():
-- foreach(lasers,draw_laser)
function draw_laser(laser)
	spr(3,laser.x,laser.y)
end -- /function draw_laser()
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
