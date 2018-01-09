# Atari-Breakout76 DISPLAY ASSET ESTIMATION

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Introduction]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README00Intro.md "Introduction" ) | [. . . README . . .]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README" ) | [Audio . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README02Audio.md "Audio" ) 

---

**DISPLAY ASSET ESTIMATION**:

Arcade Breakout's screen display is black and white, but is not an ordinary black and white television.  It is a specialized, dedicated monitor with a very tall aspect.  The display exhibits the expected CRT behavior just like a TV -- "pixels" are drawn in horizontal scan lines.  Vertically stacked scan lines create the complete display.  Pixels are represented in a conventional computer by memory.  The couputer would make a Brick shape appear on screen by turn on a collection of individual pixels in a group which would require updating several memory locations. 

However, "pixels" in this sense is not exactly the same in the Breakout arcade game.  I saw a video of Woz discussing the game wherein he reveals the only memory in the game is 256 bits -- enough to represent one bit per brick for two players.  When a bit is on the digital logic outputs a signal the size of a brick on several successive scan lines.  Therefore, a Brick is a "pixel".

Due to the display's extremely tall aspect the game's video output is certainly not timed like the Atari's display tied to the NTSC color clock.  Also, since the Bricks are output by a pre-determined signal size the dimensions of a Brick do not likely correspond to the Atari's color-clock-sized pixels.  Consequently, the best that can be done is an approximation on the Atari.  

Below is a screen capture of video of an emulator implementing Breakout: 

![Game Screen Overscan](Breakout_bw_startup_overscan_plus_ball.png?raw=true "Game Screen Overscan")

The emulator blurs and blends its pixels to simulate the output of the CRT.  This makes it difficult to determine the real start and end positions of the Breakout game "pixels".  Also, the Breakout vertical aspect is very tall; far greater than the Atari's display intended for NTSC color television.  Therefore, due to the vague nature of the Breakout emulator's pixels versus the approximation of an Atari NTSC-based pixel all discussion of object sizes in terms of "pixel" dimensions are implicitly qualified with "appears to be", "looks like", or "is a guess pulled out of thin air."

So, then how to make that approximation acceptably reasonable?  Designing the graphics assets is a matter of measuring the sizes for objects in the Breakout emulator screen grab and scaling this to fit within the Atari display geometry.

**OVERALL ESTIMATION**:

The screen grab of the emulator video from Youtube is 331 x 480 pixels tall.  

The emulator is duplicating full overscan video for the arcade game display.  In a real Breakout game a portion of the top and bottom of the display visible in the emulator screen grab extends off the edge of the CRT and is not visible to the player.  This does not need to be represented on the the Atari and can be cropped.  

Cropping the emulator screen grab to only the vertical size needed for display reduces the image height to 400 pixels:

![Game Screen Visible Pixels](Breakout_bw_startup_crop_to_underscan.png?raw=true "Game Screen Visible Pixels")

On the Atari we need to define an appropriate vertical size for the game screen.  Contrary to Commodore's marketing information in the 1980s the Atari is not limited to 192 scan lines.  The Atari's display hardware is flexible and inherently capable of producing graphics and text up to 240 scan lines -- well into the vertical overscan area off the edges of the screen.  In my experience the typical 13" color television of the 1980s could safely display about 16 complete scan lines more than the default 192 scan lines before losing screen image in the vertical overscan area (being blocked by the screen bezel).

On the Atari 208 scan lines are easily workable and visible on the majority of NTSC displays.  This should put the math close to 2 to 1 for the Breakout emulator screen grabs vs the scan lines needed for the Atari.  More scan lines means a larger overall display in both dimensions.

Therefore 208 Atari scan lines divided by 400 emulator screen scan lines provide a Breakout-to-Atari scaling factor of 0.52 (or in the other direction 1.92307692308).

However, this scaling factor is correct only for vertical estimation.  The Breakout emulator screen grab is taken from an internet video intended for display on a modern screen with square pixels.  Therefore the emulator screen pixels are assumed to be square.  Real Atari pixels are based on the NTSC color clock timing which is not square.  (This aspect ratio for the color clock horizontal to scan line vertical size relationship is the same for other systems following NTSC specifications -- Bally Astrocade, Atari 2600, Apple II, Amiga.)  Therefore, an additional scaling factor is needed to determine the real horizontal dimension measured in color clocks per the number of square pixels in the screen grab image. 

The color clock horizontal to vertical ratio is 22 / 13 which is a 1.692307 scaling factor (or 0.5909090909 when multiplying in the other direction.)   (The 22 / 13 ratio is derived from the 11 / 13 aspect ratio published in the Amiga's RKM/Hardware Reference Manual for the Amiga's low resolution/140ns pixels which are 1/2 color clock wide.)

The horizontal color clocks needed for the Breakout screen is 331 emulator pixels times 0.52 to scale down to the Atari screen size, times 0.5909090909 to convert the horizonal dimensions to color clocks, or 101.7072 color clocks, and so, 102 Atari medium res pixels (i.e. color clocks).  This includes the vertical borders around Bricks' playfield area.  The pixel width is well within the Atari's horizontal display dimensions, and is actually smaller than the Atari's narrow screen width (128 color clocks).

The 102 color clocks is a target and not necessarily the definite width of the Atari display.  The final size depends on the real Atari pixel size that best fits the Bricks. 

**BORDERS**:

![Top Border](Breakout_bw_startup_crop_top_border.png?raw=true "Top Border")

The game displays a visible Border at the top, left and right sides of the screen which rebound the ball.  The horizontal Border is about 16 lines tall -- converted to Atari dimensions this is 8.32 scan lines, so then 8 scan lines thick.

The left and right Borders work out to two Atari pixels (color clocks) wide.

**BALL**:

![Game Ball](Breakout_bw_startup_crop_ball.png?raw=true "Game Ball")

The Ball is the smallest, visible, discrete object in Breakout and is noticeably NOT square -- it appears wider than it is tall.  While it is the smallest "lit" object it does not correspond to the smallest visible signal control for Breakout.  The vertical gaps between Bricks appear smaller than the Ball's width. 

On the screen grab the Ball is about six pixels wide by four pixels tall.  Per the Atari pixel scale it is approximately two scan lines tall.  Horizontally, it is one and a half color clocks wide.  Rounding to one color clock makes the ball appear taller than wide which is the wrong effect.  Rounding to two color clocks makes the ball wider than tall, but is then noticeably larger than the ball appears in Breakout. 

So, this is where compromise is needed.  The choice is that the ball is displayed as only one color clock, one scan line tall to maintain its visual appearance relative to the dimensions of the screen, or two color clocks, two scan lines tall (four times larger).  The first choice may be too small to see easily.  The second may be too large per the look and feel of the arcade game.  When the game reaches implementation we'll find out if 1x1 or 2x2 fits best.

**BRICKS**:

![Game Bricks](Breakout_bw_startup_crop_brick_area.png?raw=true "Game Bricks")

There are eight rows of 14 Bricks each.  The area of the bricks is 63 pixels tall.  Scaled to the Atari dimensions this is 32.76 scan lines.  32 is a good approximation as this is the closest number evenly divisible by the number of Brick Rows.  A row of bricks works out to 3 scan lines of pixels and one blank line separating each row.

The area of the Bricks is 318 pixels wide.  Scaled to the Atari color clocks this is 97.712 pixels wide which works out to 6.97948 color clocks per brick including one color clock for the gap between bricks.  Rounding up makes 7 color clocks per Brick.  So, a total of 98 pixels, less one for the unneeded gap after the last Brick is 97 color clocks.

The left and right borders at 2 pixels each makes the screen width 101 pixels wide -- almost exactly the calculated value.

**Side bar...** 14 is such a weird number in computing terms.  Considering the discrete electronics nature of the game construction it would seem more sensible for there to be a base 2 number of bricks -- such as 16 bricks, not 14.  I can only theorize the left and right borders actually (or electronically) represent the two missing bricks.

**PADDLE**:

![Game Paddle](Breakout_bw_startup_crop_paddle.png?raw=true "Game Paddle")

The Paddle at its widest is the same width as a Brick -- 6 visible pixels (color clocks).  When the Paddle switches to narrow width it is half the width, or three pixels (color clocks) wide.  The Paddle is visibly thicker than the height of a brick -- definitively four Atari scan lines tall. 

When the game is over a solid horizontal Border the width of the screen replaces the Paddle.  This border acts as a giant Paddle during the game's demo/attract mode keeping the ball rebounding up toward the Bricks. 

**PLAYER, BALL COUNTER, and SCORES**:

![Numbers](Breakout_bw_startup_crop_number_area.png?raw=true "Numbers")

The current Player number, the Ball Counter, and the Scores appear in the blank area above the Bricks.  The Ball travels through this area and straight through any of the numbers without being deflected.  This maximizes use of the playfield's vertical space to nearly the entire CRT display height.

![A Number](Breakout_bw_startup_crop_number.png?raw=true "A Number")

These numbers are large, tall objects on screen. The numbers and the space between them match the width of the bricks below them, so the math is already done -- horizontally, the numbers including the space between them are 7 color clocks wide.  The height of the number area is identical to the size of the bricks -- about 63 pixels tall.  Scaled to the Atari dimensions this is 32.76 scan lines per line of numbers which includes the blank space below each number.  Therefore the vertical size of a number will be 16 scan lines including a blank scan line to separate the rows of numbers.

**EXTERNAL LABELS**:

![Glass Labels](GlassLabels.png?raw=true "Glass Labels")

The arcade game has labels painted in yellow on the glass over the display identifying the numbers in the top row.  The number on the left is the "PLAYER NUMBER", and the number on the right is the "BALL IN PLAY" counter.  These real world labels must be presented in the game display to provide necessary information to the player.  The best location for placement is the closest location on screen -- within the horizontal top border immediately above the Player number and Ball counter values.

**COLOR**:

The Breakout arcade game display is black and white video.  However, colored plastic strips placed horizontally on the screen over the Bricks add "color" to the display.  Each pair of Brick rows is provided a different color.  From top to bottom: red, orange, green, yellow.  A blue plastic overlay is provided for the Paddle row.  The picture below is the color representation from the Breakout emulator:

![Game Color Pixels](Breakout_cl_startup_crop_to_underscan.png?raw=true "Game Color Pixels")

Looking at the screen as a whole leads to the conclusion that the game needs a graphics mode that displays seven colors.  (background/black, white, the four brick colors, and blue for the Paddle/bottom border.)  This is incorrect when the screen display is considered from the point of view of how the Atari generates a TV display. ntation section.

**Note from Capt Obvious**: Since the plastic overlay covers the width of the screen, the Borders are also colored at those row positions, and the Ball is also colored when it passes through those rows. 

---

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Introduction]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README00Intro.md "Introduction" ) | [. . . README . . .]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README" ) | [Audio . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README02Audio.md "Audio" ) 
