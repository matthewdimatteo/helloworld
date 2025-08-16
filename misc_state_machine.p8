pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- state machine
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: start screen functions
-- tab 2: game functions
-- tab 3: end screen functions

-- runs once at start
-- variables, objects
function _init()
	state = "start"
end -- /function _init()

-- runs 30x/sec
-- movement, calculation
function _update()

	-- run the corresponding update
	-- function for current state
	if state == "start" then
		update_start()
	elseif state == "game" then
		update_game()
	elseif state == "end" then
		update_end()
	end -- /if-elseif state
	
end -- /function _update()

-- runs 30x/sec
-- output/graphics
function _draw()
	cls() -- refresh screen
 
	-- run the corresponding draw
	-- function for current state
	if state == "start" then
		draw_start()
	elseif state == "game" then
		draw_game()
	elseif state == "end" then
	 	draw_end()
	end -- /if-elseif state
	
end -- /function _draw()
-->8
-- start-screen functions
function update_start()

	-- press x to start game
	if btn(❎) then
		state = "game"
		init_game() -- starts game
	end -- /if btn(❎)
 
end -- /function update_start()

function draw_start()
	cls() -- refresh screen
	print("press x to start",30,60,10)
end -- /function draw_start()
-->8
-- game functions

-- declare variables
function init_game()
	health = 100
	score = 0
end -- /function init_game()

function update_game()

	-- up arrow to score
	if btn(⬆️) then
		score += 1
	end -- /if btn(⬆️)
	
	-- down arrow to damage
	if btn(⬇️) then
		health -=10
	end -- /if btn(⬇️)
 
	-- game over if health < 0
	if health < 0 then
		state = "end"
		
		-- pass the score to the
		-- next state
		init_end(score)
	end -- /if health < 0
 
end -- /function update_game()

function draw_game()
	print("press down arrow to lose health",2,26,8)
	print("health: "..health,2,34,8)
	print("press up arrow to increase score",2,2,10)
	print("score: "..score,2,8,10)
end -- /function draw_game()
-->8
-- end-screen functions
function init_end(score)
	score = score -- get from game state
end -- /function init_end()

function update_end()

	-- press x to restart
	if btn(❎) then
		state = "game"
		init_game()
	end -- /if btn(❎)
 
	-- press z for start screen
	if btn(🅾️) then
		state = "start"
		update_start()
	end -- /if btn(🅾️)
 
end -- /function update_end()

function draw_end()
	cls() -- refresh screen
	print("game over!",45,40,8)
	print("your score: "..score,35,50,10)
	print("press x to restart",28,70,7)
	print("z to return to title screen",11,80,7)
end -- /function draw_end()
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
