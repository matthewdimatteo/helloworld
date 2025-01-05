pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- spaceshooter series
-- example 04: enemies
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: make_plyr()
-- tab 2: move_plyr()
-- tab 3: laser functions
-- tab 4: pickups functions
-- tab 5: enemy functions
-- tab 6: collision function

function _init()
	score = 0
	ammo = 10
	lives = 3
	health = 100
	gameover = false
	friction = 0.9
	make_plyr()
	
	-- create tables
	lasers = {}
	pickups = {}
	enemies = {}
end

function _update()
	if gameover == false then 
		move_plyr()
		foreach(lasers,move_laser)
		foreach(pickups,move_pickup)
		spawn_pickups()
		foreach(enemies,move_enemy)
		spawn_enemies()
	else
		-- press x to restart
		if btn(❎) then 
			_init()
		end -- end if btn(5)
	end -- end if gameover
end -- end _update()

function _draw()
	cls()
 
	if gameover == false then
	
		-- print hud
		print("Lives: "..lives,2,2,8)
		print("Health: "..health,2,10,8)
		print("Ammo: "..ammo,2,18,10)
		print("Score: "..score,2,26,10)
		
		-- draw game objects
		spr(plyr.n,plyr.x,plyr.y,1,1,plyr.flpx,plyr.flpy)
		foreach(lasers,draw_laser)
		foreach(pickups,draw_pickup)
		foreach(enemies,draw_enemy)
		
	else
		-- draw game over screen
		print("game over!", 40,50,8)
		print("your score: "..score,30,60,10)
		print("press x to restart",25,70,7)
	end -- end if gameover
 
end -- end _draw()
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
end

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
	if ammo > 0 then
  
		-- subtract ammo and play sfx
		ammo -= 1
		sfx(0)
  	
		-- constrain ammo to 0
		if ammo < 0 then
			ammo = 0
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
		sfx(2) -- empty sfx
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
	
	-- detect collision w/enemies
	for enemy in all(enemies) do
		if collide(laser,enemy) then
			del(lasers,laser)
			del(enemies,enemy)
			score += 100
			sfx(3)
		end -- end if collide w/plyr
	end -- end for
 
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
-->8
-- pickup functions
function spawn_pickups()

	-- pickups will fall from the
	-- top of the screen
	
	-- randomize x between 0-120
	local x = flr(rnd(120))
	
	x += 4 -- account for spr w
	local y = -4 -- start offscrn
	
	-- generate random number and
	-- only make pickup if = 1
	-- runs 30x/sec, so (1/90) x
	-- (30) = 1/3 spawn chance per
	-- second
	rng = flr(rnd(90))
	if rng == 1 then
		make_pickup(x,y)
	end
	
end -- end spawn_pickups()

function make_pickup(x,y)
	local pickup = {}
	pickup.n = 19
	pickup.x = x
	pickup.y = y
	pickup.w = 4
	pickup.h = 4
	pickup.dy = 1
	
	-- add to table
	add(pickups,pickup)
end -- end make_pickup(x,y)

function move_pickup(pickup)

	-- move lower on screen
	pickup.y += pickup.dy
 
	-- delete if off-screen
	if pickup.y > 128 then
		del(pickups,pickup)
	end
 
	-- detect collision w/plyr
	for pickup in all(pickups) do
		if collide(pickup,plyr) then
			del(pickups,pickup)
				ammo += 10
			sfx(1)
		end -- end if collide w/plyr
	end -- end for
 
end -- end move_pickup(pickup)

function draw_pickup(pickup)
	spr(pickup.n,pickup.x,pickup.y,1,1)
end -- end draw_pickup(pickup)
-->8
-- enemy functions
function spawn_enemies()

	-- randomize x between 0-120
	local x = flr(rnd(120))
	x += 4 -- account for spr w
	
	-- start off screen top
	local y = -4
	
	-- generate random number and
	-- only make pickup if = 1
	-- runs 30x/sec:(1/90) x (30)
	-- = 1/3 chance per second
	rng = flr(rnd(90))
	if rng == 1 then
		make_enemy(x,y)
	end -- end if rng == 1
	
end -- end spawn_enemies()

-- make a single enemy object
function make_enemy(x,y)
	local enemy = {}
	enemy.n = 17
	enemy.x = x
	enemy.y = y
	enemy.w = 4
	enemy.h = 4
	enemy.dy = 1
	
	-- add to table
	add(enemies,enemy)
end -- end make_enemy(x,y)

function move_enemy(enemy)

	-- move downward
	enemy.y += enemy.dy
  
	-- delete if off-scrn bottom
	if enemy.y > 128 then
		del(enemies,enemy)
	end
 
	-- detect collision w/plyr
	-- loop through all enemies
	for enemy in all(enemies) do
		if collide(enemy,plyr) then
		
			-- remove the enemy
			del(enemies,enemy)
			
			-- play a crash sound
			sfx(3)
			
			-- score less than you
			-- would for a laser shot
			score += 10
			
			-- take damange
			health -= 50

			-- lose a life and respawn
			if health <= 0 then
				sfx(4) -- play death sound
				lives -= 1
				health = 100
				make_plyr() -- respawn plyr
			end -- end if health <= 0

			-- game over if lives < 1
			if lives < 1 then 
				gameover = true
			end -- end if lives < 1

		end -- end if collide w/plyr
	
	end -- end for
 
end -- end move_enemy(enemy)

-- draw enemy
function draw_enemy(enemy)
  spr(enemy.n,enemy.x,enemy.y,1,1,false,true)
end -- end draw_enemy(enemy)
-->8
-- collision
function collide(a,b)

	if b.x+b.w >= a.x
	and b.x <= a.x+a.w
	and b.y+b.h >= a.y
	and b.y <= a.y+a.h
	then
		return true
	else
		return false
	end -- end if
 
end -- end function collide(a,b)
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
00000000008888000088888800077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008888008888888800777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888808888888800777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888800088888800077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
000f000026750297502e7500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002075020750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002465021650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000240502405020050200501a0501a0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
