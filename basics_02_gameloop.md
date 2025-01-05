# helloworld
Explanation of basics02_gameloop.p8

PICO-8 offers three unique functions that form the base structure of the program, which we call the "game loop":

_init() -- runs once at the start; use for setting the initial conditions of the game  
_update() -- runs in a loop 30 times per second; use for making calculations, checking for input, making objects move, etc.  
_draw() -- also runs in a loop 30 times per second; use for displaying text and graphics  

Don't forget the underscore _ at the beginning of each of these three function names! Other functions do not require this underscore; it's used to differentiate these three.  

All functions must be written with a pair of parentheses directly after the function name.  

All functions must be "closed" -- in some languages, this is done with a pair of curly brackets; in Lua, the language PICO-8 uses, functions are closed with the keyword "end"  

All of your code can be organized within these three functions that comprise the PICO-8 game loop  

See basics06_custom_functions.p8 for writing custom functions outside the game loop and then "calling" the functions within the game loop for more readable code
