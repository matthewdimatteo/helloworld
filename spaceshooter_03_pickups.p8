pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- spaceshooter series
-- example 03: pickups
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: make_plyr()
-- tab 2: move_plyr()
-- tab 3: pickup functions
-- tab 4: collision function

function _init()
	score = 0
	friction = 0.9
	make_plyr()
	
	-- create tables
	lasers = {}
	pickups = {}
end

function _update()
	move_plyr()
	
	-- foreach takes an array 
	-- (the 1st value) and runs
	-- a function (2nd value)
	-- for each item in the array
	foreach(pickups,move_pickup)
	spawn_pickups()
end -- end _update()

-- loops 30x/sec
function _draw()
	cls()

	-- draw the player
	spr(plyr.n,plyr.x,plyr.y,1,1,plyr.flpx,plyr.flpy)

	-- draw all pickups
	foreach(pickups,draw_pickup)

	-- display current score
	print("score: "..score,2,2,10)
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
	plyr.dx = 0
	plyr.dy = 0
	plyr.spd = 0.5
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

end -- end move_plyr()
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
			score += 10
			sfx(1)
		end -- end if collide w/plyr
	end -- end for
 
end -- end move_pickup(pickup)

function draw_pickup(pickup)
	spr(pickup.n,pickup.x,pickup.y,1,1)
end -- end draw_pickup(pickup)
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
