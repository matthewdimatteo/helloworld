pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- life meter
-- by matthew dimatteo

-- tab 0: game loop and controls
-- tab 1: life meter function

-- runs once at start
-- variables, objects
function _init()
	gameover = false
	lives = 10
	health = 100
end -- /function _init()

-- runs 30x/sec
-- movement, calculation
function _update()
 
	-- press x to restart
	if gameover == true then
		if btn(❎) then
			_init()
		end -- /if btn(❎)
		
	-- play the game
	else

		-- press down arrow to damage
		if btn(⬇️) then
			health -=10
		end -- /if btn(⬇️)
 
		-- no health
		if health <= 0 then
			lives -= 1 -- lose a life
 
			-- no lives
			if lives < 1 then
				health = 0
				gameover = true
			else
				health = 100 -- reset health
			end -- /if lives < 1
		end -- /if health <= 0

	end -- /if-else gameover
end -- /function _update()

-- runs 30x/sec
-- output/graphics
function _draw()
	cls() -- refresh screen
	
	-- game over message
	if gameover == true then
		print("game over!",45,50,8)
		print("press x to restart",28,60,10)
	else

		-- draw the game
		print("press down arrow to lose health",2,2,8)
		print("health: "..health,2,10,8)

		life_meter() -- tab 1
 
	end -- /if-else gameover 
end -- /function _draw()
-->8
-- draw life meter
function life_meter()

	-- draw sprite for each life 	
	for i = 1, lives do
		local n = 1 -- sprite number
		local x = (i*9)-7 -- x position
		local y = 18 -- y position
		spr(n,x,y) -- draw sprite
	end -- /for
end -- /function life_meter()
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000080000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700888008880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700088888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
