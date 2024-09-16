pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- basics series
-- example 10: game over
-- by matthew dimatteo

-- tab 0: game loop
-- tab 1: game functions
-- tab 2: gameover functions
-- tab 3: hud, gameover screens

-- runs once at start
function _init()

	-- gameover is a "boolean"
	-- variable: it can be either
	-- true or false
	gameover = false
	health = 100
end -- end _init()

-- loops 30x/sec
function _update()
	
	-- run the game if gameover is
	-- false; run the game over
	-- screen if true
	
	-- use == to compare values
	if gameover == false then
	 	play_game() -- tab 1
	else
	 	game_over() -- tab 2
	end

end -- end _update()

-- loops 30x/sec
function _draw()
	cls() -- clear the screen
 
	-- draw either the game or the
	-- game over screen depending
	-- on whether gameover is true
	-- or false
	if gameover == false then
		draw_game() -- tab 3
	else
		draw_gameover() -- tab 3
	end
	
end -- end _draw()
-->8
-- game functions
function play_game()

	-- press x to decrease health
	if btn(❎) then
	 	health = health - 2
	end
	
	-- game over if health at 0
	if health < 0 then
		gameover = true 
		sfx(1) -- game over sfx
	end -- end if health < 0
	
end -- end play_game()
-->8
-- gameover functions
function game_over()

	-- press z/c to restart
	if btn(🅾️) then
	
		-- call _init() to reset 
		-- all variables to their
		-- initial value
		_init() 
		
	end -- end if btn(🅾️)
 
end -- end game_over()
-->8
-- draw game hud, gameover scrn
function draw_game()
	print("press x to lose health",2,2,7)
	print("health: "..health,2,10,8)	
end

-- draw game over screen
function draw_gameover()
	print("game over!",45,50,8)
	print("press z to restart",30,60,7)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
001200002955021550137501370000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000315502e5502b5502855025550245501c5501c5401c5300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
