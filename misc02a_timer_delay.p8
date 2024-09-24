pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

function _init()
 gravity = 0.3
 make_paddle()
 make_ball()
end

function _update()
 move_paddle()
 move_ball()
end

function _draw()
 cls()
 print("delay: "..ball.delay)
 --print("dx: "..ball.dx,2,2)
 --print("dy: "..ball.dy,2,10)
 spr(paddle.sp,paddle.x,paddle.y)
 spr(ball.sp,ball.x,ball.y)
end

-->8
-- paddle
function make_paddle()
 paddle = {}
 paddle.sp = 1
 paddle.x = 60
 paddle.y = 118
 paddle.w = 10
 paddle.h = 2
 paddle.speed = 3
end

function move_paddle()
 
 -- move left
 if btn(⬅️) then
  paddle.x -= paddle.speed
 end
 
 -- move right
 if btn(➡️) then
  paddle.x += paddle.speed
 end
 
 -- keep on screen left
 if paddle.x < 0 then
  paddle.x = 0
 end
 
 -- keep on screen right
 if paddle.x > 128-paddle.w then
  paddle.x = 128-paddle.w
 end
 
end
-->8
-- ball
function make_ball()
 ball = {}
 ball.sp = 2
 ball.x = 60
 ball.y = 2
 ball.w = 8
 ball.h = 8
 ball.dx = 0
 ball.dy = 0
 ball.maxdy = 8
 
 -- start delay timer at 0
 ball.delay = 0 
 
 -- start moving when timer==20
 ball.start = 20
 
end

function move_ball()

 -- timer begins counting
 ball.delay += 1
 
 -- start moving when time's up
	if ball.delay >= ball.start then
 	ball.dy += gravity
 end
 
 -- bounce off paddle
 if collide(ball,paddle) then
 	ball.y = 110
 	sfx(0)
  ball.dy *= -1
  
  if btn(⬅️) then
   ball.dx = -paddle.speed
  end
  
  if btn(➡️) then
   ball.dx = paddle.speed
  end
  
 end -- end if collide
 
 -- reset after falling
 if ball.y > 128 then
 	sfx(1)
 	ball.x = 60
  ball.y = 2
  ball.dx = 0
  ball.dy = 0
  ball.delay = 0
 end
 
 -- bounce off ceiling
 if ball.y < 0 then
 	ball.y = 2
  sfx(0)
  ball.dy *= -1
 end
 
 -- bounce off left/right walls
 if ball.x < 0 
 or ball.x > 128-ball.w
 then
 	sfx(0)
  ball.dx *= -1
 end
 
 -- speed limit
 if ball.dy > ball.maxdy then
  ball.dy = ball.maxdy
 end
 
 -- speed limit (moving up)
 if ball.dy < -ball.maxdy then
  ball.dy = -ball.maxdy
 end
 
 -- start moving when time's up
 if ball.delay >= ball.start then
 	ball.x += ball.dx
 	ball.y += ball.dy
 end

end
-->8
-- collision
function collide(a,b)
 if b.x + b.w >= a.x
 and b.x <= a.x + a.w
 and b.y + b.h >= a.y
 and b.y <= a.y + a.h
 then
  return true
 else
  return false
 end
end
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
000100001b05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000028750227501d7501a750147500d7000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
