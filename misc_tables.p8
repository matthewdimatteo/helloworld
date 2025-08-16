pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- tables
-- by matthew dimatteo

-- tables are a special type of
-- variable that can contain a
-- list of other variables

-- we can use them to organize
-- a game object's properties
-- (such as x,y position, size,
-- speed, health, etc.)

-- we can also use tables when
-- we have several instances of
-- a type of object, such as
-- projectiles, that we want
-- to display

-- but really, tables are just
-- lists, like a grocery list.
-- this example is meant to
-- showcase how tables work
-- in a general sense, and how
-- you write them in your code

-- runs once at start
-- variables, objects
function _init()

	-- method 1:
	-- create an empty table
	fruits = {}
	
	-- add items to the table
	-- using a dot and a variable
	-- name after the table name
	fruits.a = "apple"
	fruits.b = "banana"
	fruits.c = "orange"
	
	-- method 2:
	-- add items to the table
	-- when first creating it,
	-- by placing variable names
	-- between the brackets
	-- and separating with commas
	veggies = {
	 a = "carrot",
	 b = "broccoli",
	 c = "spinach"
	}
end -- /function _init()

-- runs 30x/sec
-- output/graphics
function _draw()
	cls() -- refresh screen
	
	-- print names of fruits
	print(fruits.a,12,10,8)
	print(fruits.b,12,18,8)
	print(fruits.c,12,26,8)
	
	-- print names of veggies
	print(veggies.a,12,50,11)
	print(veggies.b,12,58,11)
	print(veggies.c,12,66,11)
end -- /function _draw()
__gfx__
000000000077770000cccc0000eeee00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077777700cccccc00eeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070077777777cccccccceeeeeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700077777777cccccccceeeeeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700077777777cccccccceeeeeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070077777777cccccccceeeeeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077777700cccccc00eeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000077770000cccc0000eeee00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
