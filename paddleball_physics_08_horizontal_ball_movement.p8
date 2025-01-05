pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- runs once at the start
-- set starting conditions here
function _init()
    gravity = 0.3 -- global variable
    
    -- declare game objects
    make_paddle()
    make_ball()
 
end -- end _init()

-- runs 30x/sec
-- perform calculations here
function _update()
    move_paddle()
    move_ball()
end -- end _update()

-- runs 30x/sec
-- draw graphics here
function _draw()
	cls() -- clear the screen
    spr(paddle.sp,paddle.x,paddle.y)
    spr(ball.sp,ball.x,ball.y)
end
-->8

-- paddle
function make_paddle()
    paddle = {} -- game object
    paddle.sp = 1 -- property of object
    paddle.x = 60
    paddle.y = 118
    paddle.w = 8
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
        ball.yspeed *= -1
        
        if btn(0) then
            ball.xspeed = -paddle.speed
        end -- end if btn(0)
        
        if btn(1) then
            ball.xspeed = paddle.speed
        end -- end if btn(1)
    
    end -- end if collide
    
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
