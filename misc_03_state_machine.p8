pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- misc series
-- example 03: state machine
-- by matthew dimatteo

function _init()

 	state = "start" -- variable for state: "start" / "game" / "gameover"
 
end -- end _init()

function _update()

 	-- run the "clone" update for whichever state it is
	if state == "start" then
		update_start()
	elseif state == "game" then
		update_game()
	elseif state == "gameover" then
	 	update_gameover()
	end -- end if state
	
end -- end _update()

function _draw()
 	cls() -- clear screen
 
 	-- run the "clone" draw for whichever state it is
 	if state == "start" then
		draw_start()
	elseif state == "game" then
		draw_game()
	elseif state == "gameover" then
	 	draw_gameover()
	end -- end if state
	
end -- end _draw()
-->8

-- start screen
function update_start()

	-- press x to start game
	if btn(5) then
		state = "game"
		init_game() -- starts game
	end -- end if btn(5)
 
end -- end update_start()

function draw_start()
	cls() -- clear screen
	print("press x to start",30,60,10)
end -- end draw_start()
-->8

-- game

-- declare variables
function init_game()
 	health = 100
 	score = 0
end -- end init_game()

function update_game()

 	-- up arrow to score
	if btn(2) then
	 	score += 1
	end -- end if btn(2)
	
	-- down arrow to damage
 	if btn(3) then
  		health -=10
	end -- end if btn(3)
 
 	-- game over if health < 0
 	if health < 0 then
  		state = "gameover"
  		init_gameover(score) -- pass the score to the gameover state
 	end -- end if health < 0
 
end -- end update_game()

function draw_game()
	print("press down arrow to lose health",2,26,8)
	print("health: "..health,2,34,8)
	print("press up arrow to increase score",2,2,10)
	print("score: "..score,2,8,10)
end -- end draw_game()
-->8

-- game over
function init_gameover(score)
 	score = score -- get from game state
end -- end init_gameover()

function update_gameover()

	-- press x to restart
	if btn(5) then
		state = "game"
		init_game()
	end -- end if btn(5)
 
	-- press z for title screen
	if btn(4) then
		state = "start"
		update_start()
	end -- end if btn(4)
 
end -- end update_gameover()

function draw_gameover()
	cls() -- clear screen
	print("game over!",45,40,8)
	print("your score: "..score,35,50,10)
	print("press x to restart",28,70,7)
	print("z to return to title screen",11,80,7)
end -- end draw_gameover()
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
