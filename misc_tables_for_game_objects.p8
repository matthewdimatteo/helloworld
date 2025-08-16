pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- tables for game objects
-- by matthew dimatteo

-- this example shows a new way
-- to define the properties of
-- a game object, such as its
-- sprite number and x,y 
-- coordinates.

-- see how the paddle is being
-- defined below. "pad" is a
-- table (like a spreadsheet)
-- that can be used to contain
-- a list of values.

-- to add those values to the
-- table, you type the table
-- name (such as pad) followed
-- by a dot, then whatever you
-- want to name the variables
-- for those values.

-- for example, pad.n is the
-- sprite number for the paddle


-- runs once at start
-- variables, objects
function _init()

	-- without a table
	baln=1
	balx=20
	baly=4
	
	-- with a table (method 1)
	bal2 = {} -- this is the table

	-- use a dot between the table
	-- name and the name of the
	-- variable you want to add to
	-- the table 
	bal2.n=2
	bal2.x=60
	bal2.y=60
	
	-- with a table (method 2)
	bal3 = {
	
		-- place the variables inside
		-- the brackets, separated by
		-- commas
		n=3,
		x=100,
		y=116
	}
end -- /function _init()

-- runs 30x/sec
-- output/graphics
function _draw()
	cls() -- refresh screen
	
	-- draw ball 1
	spr(baln,balx,baly)
	
	-- draw ball 2
	spr(bal2.n,bal2.x,bal2.y)
	
	-- draw ball 3
	-- you still need to refer to
	-- these variables the same way
	-- as for ball 2: with the name
	-- of the table, followed by a
	-- dot and the name of the
	-- variable
	spr(bal3.n,bal3.x,bal3.y)
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
