# helloworld
Explanation of basics03_variables.p8

Variables are used to store values that can change -- they're what makes action possible in your game  

Variables must be "declared" -- given a name and an initial value  
Some programming languages allow you to declare variables without assigning them a value, but we must assign a value in PICO-8  

Name your variable whatever you want, as long as it is not another keyword recognized by the engine (like "function" or "print"), there are no spaces in the name, and the name starts with a letter  

You can assign a value using an equals sign -- for example:  
x = 60  

You can also write this without spaces:  
x=60  

Declare your variables in the _init() function  

You can use _update() to change variable values -- this example adds 2 to the variable y each frame (30fps)  

Within the _draw() function, you can use the spr() function to draw sprites -- spr() takes the following values, in order:  

The number of the sprite (refer to the sprite editor for this)  
The x coordinate of the sprite  
The y coordinate of the sprite  
And several other optional values we will cover in later examples  

We can "plug in" our variables into the spr() function to draw a sprite at a location that changes over time:  
spr(n,x,y)  

y begins at 2, then increases by 2 each frame, so whatever that value is at the current frame, that's what y stands for  
