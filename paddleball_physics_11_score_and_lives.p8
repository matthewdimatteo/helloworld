pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- runs once at the start
-- set starting conditions here
function _init()

    -- global variables
    gravity = 0.3
    score = 0
    lives = 10
    gameover = false
    
    -- declare game objects
    make_paddle()
    make_ball()
 
end -- end _init()

-- runs 30x/sec
-- perform calculations here
function _update()

    if not gameover then
        -- run the game
        move_paddle()
        move_ball()

    else

      -- press x to restart
      if btn(5) then
          _init() -- restart
      end -- end if btn(5)
 	
    end -- end if not gameover
 
end -- end _update()

-- runs 30x/sec
-- draw graphics here
function _draw()
    cls() -- clear the screen
    
    if not gameover then
        print("lives: "..lives,2,2,7)
        print("score: "..score,2,10,7)
        spr(paddle.sp,paddle.x,paddle.y)
        spr(ball.sp,ball.x,ball.y)
    else
        print("game over!",40,50,8)
        print("your score: "..score,30,60,10)
        print("press x to restart",25,70,7)
    end -- end if not gameover
 
end -- end _draw()
-->8
-- paddle
function make_paddle()
    paddle = {} -- game object
    paddle.sp = 1 -- property of object
    paddle.x = 60
    paddle.y = 118
    paddle.w = 10
    paddle.h = 2
    paddle.speed = 3
end

function move_paddle()
	
    -- left arrow
    if btn(0) then
        paddle.x -= paddle.speed
    end -- end if btn(0)
 
    -- right arrow
    if btn(1) then
      paddle.x += paddle.speed
    end -- end if btn(1)
 
    -- keep on screen left
    if paddle.x < 0 then
      paddle.x = 0
    end -- end if paddle.x < 0
 
    -- keep on screen right
    if paddle.x > 120 then
      paddle.x = 120
    end -- end if paddle.x > 120
 
end -- end move_paddle()
-->8

-- ball
function make_ball()
  ball = {}
  ball.sp = 2
  ball.x = 60
  ball.y = 2
  ball.w = 8
  ball.h = 8
  ball.xspeed = 0
  ball.yspeed = 0
end

function move_ball()
 
    ball.yspeed += gravity
 
    if collide(ball,paddle) then
 	    sfx(0) -- ping sound
      ball.y -= 1
      ball.yspeed *= -1
  
        -- bounce left
        if btn(0) then
            ball.xspeed = -paddle.speed
        end -- end if btn(0)
    
        -- bounce right
        if btn(1) then
            ball.xspeed = paddle.speed
        end -- end if btn(1)
        
        -- increase score
        if ball.xspeed != 0 then
            score += 10
        end -- end if ball.xspeed
  
    end -- end if collide
 
    -- bounce off left wall
    if ball.x < 0 then
        sfx(0) -- ping sound
        ball.xspeed *= -1
    end -- end if ball.x < 0
    
    -- bounce off right wall
    if ball.x > 120 then
        sfx(0) -- ping sound
        ball.xspeed *= -1
    end -- end if ball.x > 120
 
    -- bounce off top wall
    if ball.y < 0 then
        sfx(0) -- ping sound
        ball.y += 1 -- keep from getting stuck
        ball.yspeed *= -1
    end -- end if ball.y < 0
 
    -- reset after falling below
    if ball.y > 128 then
        sfx(1) -- sad sound
        ball.x = 60
        ball.y = 2
        ball.xspeed = 0
        ball.yspeed = 0
        
        -- subtract a life
        lives -= 1
        
        -- gameover
        if lives < 1 then
            gameover = true
        end -- end if lives < 1
      
    end -- end if ball.y > 128
 
    -- max downward speed
    if ball.yspeed > 9 then
        ball.yspeed = 9
    end -- end if ball.yspeed > 9
    
    -- max upward speed
    if ball.yspeed < -9 then
        ball.yspeed = -9
    end -- end if ball.yspeed < -9
    
    ball.x += ball.xspeed
    ball.y += ball.yspeed
 
end -- end function move_ball()
-->8

-- object collsiion
function collide(b,p)
    if b.x + b.w >= p.x
    and b.x <= p.x + p.w
    and b.y + b.h >= p.y
    and b.y <= p.y + p.h
    then
        return true
    else
        return false
    end -- end if
end -- end function
__gfx__
000000000000000000cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777770cccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000007777777700cccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100002905029050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002a0502705024050200501d050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
