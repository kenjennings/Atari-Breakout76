# Atari-Breakout76 DISPLAY ASSET ESTIMATION

**DISPLAY ASSET ESTIMATION**:

Arcade Breakout's screen display is black and white, but is not an ordinary black and white television.  It is a specialized, dedicated monitor with a very tall aspect.  The display exhibits the expected CRT behavior just like a TV -- "Pixels" are drawn in horizontal scan lines, and a number of scan lines stacked vertically to create the display.  "Pixels" may be stretching what the Breakout hardware actually does as the modern use of the word implies a memory value directly related to each dot on the display. The dedicated digital logic does not implement memory-mapped pixels in this sense.  "Pixels" are signals triggered by logic conditions.  (I saw a video of Woz discussing the game wherein he reveals the game had 256 bits of memory -- enough to count the bricks.)  

Due to the display's extremely tall aspect the game's video output is certainly not timed like the Atari's display which is tied to the NTSC color clock.  Therefore, the "pixels" in the Breakout game likely do not correspond to the Atari's color-clock-sized pixels.  Consequently, the best that can be done is an approximation on the Atari.  

Below is a screen capture of video of an emulator implementing Breakout: 

![Game Screen Pixels](Breakoput_bw_startup_overscan_plus_ball.png?raw=true "Game Screen Pixels")

The emulator blurs and blends its pixels to simulate the output of the CRT.  This makes it difficult to determine the real start/end position of a Breakout game "pixels".  Also, the Breakout vertical aspect is very tall; far greater than the Atari's display intended for NTSC color television.  Therefore, all discussion of object sizes in terms of "pixel" dimensions are implicitly qualified with "appears to be" due to the vague nature of Breakout's "pixels" versus the approximation of an Atari NTSC-based pixel.

So, then how to make that approximation?  Designing the graphics assests is simply a matter of measuring the sizes for objects in the Breakout emulator screen grab and scaling this down to fit within the Atari display geometry.

**OVERALL ESTIMATION**:

The screen grab of the emulator video from Youtube is 331 x 480 pixels tall.  

The emulator is duplicating full overscan for the game display.  In a real Breakout game a portion of the top and bottom of the display visible in the screen grab is off the CRT.  

Cropping the screen grab to the vertical size needed for display reduces the image height to 400 pixels:

![Game Screen Pixels](Breakoput_bw_startup_crop_to_underscan.png?raw=true "Game Screen Pixels")

On the Atari we need to define an appropriate vertical size for the game screen.  Contrary to Commodore's marketing information in the 1980s the Atari is not limited to 192 scan lines.  The Atari's display hardware is inherently capable of producing graphics and text up to 240 scan lines -- well into the overscan area off the edges of the screen.  In my experience the typical 13" color television of the 1980s could safely display about 16 scan lines more than the default 192 scan lines before running into the vertical overscan area.

The Atari display is easily variable to best match the aspect for arcade Breakout.  Either 200 or 208 scan lines are easily workable and visible on the majority of NTSC displays.  This should put the math close to 2 to 1 for the Breakout arcade screen grabs vs the scan lines needed for the Atari.  More scan lines means a larger overall display in both dimensions, so this will push to the maximum edges at 208 Atari scan lines. 

Therefore 208 Atari scan lines divided by 400 Breakout (screen grab) scan lines provide a Breakout to Atari scaling factor of 0.52 (or in the other direction 1.92307692308).

However, this scaling factor is correct only for vertical estimation.  The Breakout emulator screen grab pixels are square.  Real Atari pixels are based on the NTSC color clock timing which is not square.  (This aspect ration for the color clock horizontal to scan line vertical size relationship is the same for other systems following NTSC specifications -- Bally Astrocade, Atari 2600, Apple II, Amiga.)  Therefore, an additional scaling factor is needed to determine the real horizontal dimension measured in color clocks per the number of square pixels in the screen grab image. 

The color clock horizontal to vertical ratio is 22 / 13 which is a 1.692307 scaling factor (or 0.5909090909 when multiplying in the other direction.)   (The 22 / 13 ratio is derived from the 11 / 13 aspect ratio published for the Amiga's low resolution/140ns pixels which are 1/2 color clock wide.)

Thus the horizontal color clocks needed for the Breakout screen is 331 Breakout pixels times 0.52 to scale down to the Atari screen size, times 0.5909090909 to convert the horizonal dimensions to color clocks, or 101.7072 color clocks, and so, 101 Atari medium res pixels. (This includes the vertical borders around Bricks' playfield area.) This is well within the Atari's horizontal display dimensions, and is actually smaller than the Atari's narrow screen width.

**BORDERS**:

The game displays a visible Border at the top, left and right sides of the screen which rebound the ball.  The horizontal Border is about 16 lines tall -- converted to Atari dimensions this is 8.32 scan lines, so then 8 scan lines thick.

The left and right Borders work out to two Atari pixels (color clocks) wide.

**BALL**:

The Ball is the smallest, visible, discrete object in Breakout and notably does not appear square -- it appears wider than it is tall.  While it is the smallest "lit" object it does not correspond to the smallest visible signal control for Breakout.  The vertical gaps between Bricks appear smaller than the Ball's width. 

On the screen grab the Ball is about six pixels wide by four pixels tall.  Per the Atari pixel scale it is approximately two scan lines tall.  Horizontally, that is one and a half color clocks wide.  Rounding to one color clock makes the ball appear taller than wide which is the wrong effect.  Rounding to two color clocks makes the ball wider than tall, but noticeably larger than the ball appears in Breakout. 

So, this is where compromise is needed.  The choice is that the ball is displayed as only one color clock, one scan line tall to maintain its visual appearance relative to the dimensions of the screen, or two color clocks, two scan lines tall (four times larger).  The first choice may be too small to see easily.  The second may be too large per the look and feel of the arcade game.

**BRICKS**:

There are eight rows of 14 Bricks each.  (Side bar... 14 is such a weird number.  Considering the discrete electronics nature of the game construction it would seem more sensible for there to be a base 2 number of bricks -- such as 16 bricks, not 14.  I can only theorize that the two missing bricks actually represent the left and right borders.)

The area of the bricks is 63 pixels tall.  Scaled to the Atari dimensions this is 32.76 scan lines.  32 is a good approximation as this is the closest number evenly divisible by the number of Brick Rows.  A row of bricks works out to 3 scan lines of pixels and one blank blank line separating each row.

The area of the Bricks is 318 pixels wide. Scaled to the Atari color clocks this is 97.712 pixels wide which works out to 6.97948 color clocks per brick including one color clock for the gap between bricks.  Rounding up makes 7 color clocks per Brick.  So, a total of 98 pixels, less one for the unneeded gap after the last Brick is 97 color clocks.

**PADDLE**:

The Paddle at its widest is the same width as a Brick -- 6 visible pixels (color clocks).  When the Paddle switches to narrow width it is half the width, or three pixels (color clocks) wide.  The Paddle is visibly thicker than the height of a brick -- definitively four Atari scan lines tall. When the game is over the Paddle is replaced by a solid horizontal Border the width of the screen.  This border acts as a giant Paddle during the game's demo mode keeping the ball rebounding up toward the Bricks. 

**PLAYER, BALL COUNTER, and SCORES**:

The current Player number, the Ball Counter, and the Scores appear in the blank area above the Bricks.  This blank area occupies vertical space approximately equal height to the region of the eight Brick rows on the screen.  The Ball travels through this area and straight through any of the numbers without being deflected.  This maximizes use of the playfield's vertical space to nearly the entire screen height.

These numbers are very large, tall objects on screen. The numbers and the space between them match the width of the bricks below them, so the math is already done -- horizontally, the numbers including the space between them are 7 color clocks wide.  The height of the number area is identical to the size of the bricks -- about 63 pixels tall.  Scaled to the Atari dimensions this is 32.76 scan lines per line of numbers which includes the blank space below each number.  Therefore the vertical size of a number will be 16 scan lines. 

**EXTERNAL LABELS**:

The arcade game has labels painted in yellow on the glass over the display identifying the numbers in the top row.  The number on the left is the "PLAYER NUMBER", and the number on the right is the "BALL IN PLAY" counter.  These real world labels will have to be worked into the game display to provide necessary information to the player.  The best location for placement is the closest object on screen -- within the horizontal top border immediately above the Player number and Ball counter values.

**COLOR**:

The game is output only in black and white video.  However, colored plastic strips placed horizontally on the screen over the Bricks add "color" to the display.  Each pair of Brick rows is provided a different color.  From top to bottom: red, orange, green, yellow.   A blue plastic overlay is provided for the Paddle's row.  The picture below is the color representation from an emulator:

![Game Color Pixels](Breakoput_cl_startup_crop_to_underscan.png?raw=true "Game Color Pixels")

Looking at the screen holistically leads to the conclusion that the game needs six colors on the screen.  (background/black, white, and the four brick colors.)  This is an incorrect point of view relative to the Atari's graphics capabilities and will be discussed later in the implementation section for the entertainment value.

Note from Capt Obvious: Since the plastic overlay covers the width of the screen, the Borders are also colored at those row positions, and the Ball is colored when it passes through those rows.  

=============================================================================

**Back To Beginning**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md )
