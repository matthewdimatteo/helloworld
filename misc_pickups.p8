pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- pickups
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: player
-- tab 2: pickups
-- tab 3: object collision

-- runs once at start
-- variables, objects
function _init()

	-- physics
	friction = 0.9

	-- game variables
	score = 0

	-- player variables
	make_plyr()
	
	-- create table for all
	-- active pickups
	pickups = {}
end -- /function _init()

-- runs 30x/sec
-- movement, calculation
function _update()
	move_plyr() -- tab 1

	-- manage pickups, tab 2
	spawn_pickups()
	foreach(pickups,move_pickup)
end -- /function _update()

-- runs 30x/sec
-- output/graphics
function _draw()
	cls() -- refresh screen

	-- print score
	print("score: "..score,2,2,10)

	-- draw player
	spr(plyr.n,plyr.x,plyr.y,1,1,plyr.flpx,plyr.flpy)

	-- draw pickups, tab 2
	foreach(pickups,draw_pickup)

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
-- pickups

-- randomly spawn pickups
-- call this function in _update()
function spawn_pickups()

	-- pickups will fall from the
	-- top of the screen
	
	-- randomize x between 0-120
	local x = flr(rnd(120))
	x += 4 -- account for spr w
	
	-- start above screen
	local y = -4
	
	-- generate random number and
	-- only make pickup if = 1
	-- runs 30x/sec, so (1/90) x
	-- (30) = 1/3 spawn chance per
	-- second
	rng = flr(rnd(90))
	if rng == 1 then
		make_pickup(x,y) -- tab 4
	end -- /if rng == 1
	
end -- /function spawn_pickups()

-- make a single pickup at x,y
-- call this function in
-- spawn_pickups()
function make_pickup(x,y)

	-- table (use local so each
	-- instance is separate)
	local pickup = {}

	-- sprite number
	pickup.n = 19

	-- get x,y coords from function
	pickup.x = x
	pickup.y = y

	-- width height
	pickup.w = 4
	pickup.h = 4

	-- active y speed
	pickup.dy = 1
	
	-- add to table
	add(pickups,pickup)
end -- /function make_pickup(x,y)

-- move a single pickup

-- call this function using
-- foreach in _update():
-- foreach(pickups,move_pickup)
function move_pickup(pickup)

	-- move down
	pickup.y += pickup.dy
 
	-- delete if off screen
	if pickup.y > 128 then
		del(pickups,pickup)
	end -- /if pickup.y > 128
 
	-- detect collision w/plyr
	for pickup in all(pickups) do

		-- collide() on tab 6
		if collide(pickup,plyr) then
			del(pickups,pickup)
			score += 10
			sfx(1)
		end -- /if collide
		
	end -- /for
 
end -- /function move_pickup(pickup)

-- draw a single pickup

-- call this function using
-- foreach in _draw():
-- foreach(pickups,draw_pickup)
function draw_pickup(pickup)
	spr(pickup.n,pickup.x,pickup.y,1,1)
end -- /function draw_pickup(pickup)
-->8
-- *** collision btwn objects

-- call this function in
-- _update() or in an object
-- movement function, using
-- a for-loop to check
-- collision between all
-- active sets of objects 

-- e.g., pickups and player:
-- for pickup in all(pickups) do
--  if collide(pickup,plyr) then
---  del(pickups,pickup)
--   score += 10
--  end
-- end
function collide(a,b)

	if b.x+b.w >= a.x
	and b.x <= a.x+a.w
	and b.y+b.h >= a.y
	and b.y <= a.y+a.h
	then
		return true
	else
		return false
	end -- /if
 
end -- /function collide(a,b)
__gfx__
00000000000cc000000000cc00000000000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000cc0000000cccc00000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000cccc0000cccccc00000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000cccc00cccccccc000aa000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000cccccc0cccccccc000aa000007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000cccccc000cccccc00000000077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccc0000cccc00000000077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cccccccc000000cc00000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008888000088888800987900000880000000077000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000088880088888888007ca800000770000087770000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000888888088888888008ab700000770000087770000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088888800088888800978900007777000000077000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888880000888800000000007007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888888880000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000009900000000099aaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000009900000009999aaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000099990000999999a8aa888a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000099990099999999a8aa8a8a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000999999099999999a8aa8a8a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000999999000999999a8aa888a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000009999999900009999aaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000009999999900000099aaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000292502c2502f2503125000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000023750287502f7501c70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002075020750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
