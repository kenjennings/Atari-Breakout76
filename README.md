# Atari-Breakout76
Currently Work In Progress..

=============================================================================

This is a simple Breakout clone for Atari 8-bit computers approximating the look and feel of the original arcade Breakout released by Atari in 1976 (without the bugs).

This version uses only the Atari computer features necessary to mimic the correct look and behavior with as few extraneous bells and whistles as possible.

Or, you could just get an emulator to play the original game.

=============================================================================

The real purpose of this is to create a modular framework for working on game projects that I can understand and sustain. (Your Mileage May Vary.)  

I had been in the middle of Breakout-GECE, and the debugging effort in that game required copying and pasting code from different places together into one workable test program.  This makes the test program very monolithic and complicated to keep everything organized.  This was workable when I had time to focus on the program every day, but recent demands on my personal time have reduced the development thinking opportunities -- sometimes to only an hour in a week which is not enough time to re-wrap  my brain cells around the game details.  

Therefore, the idea here is to force a more stringent modularization of the code and data, keeping visual components entirely separate, so when I need to look at a part of the game, I will know exactly which files and locations to find everything without having to remember what I am looking at.  The first victim to test this strategy is an attempt to make reasonable immitation of the original arcade Breakout video game.  The scope of Atari's bells and whistles will be primarily limited to implementing the visuals, sound, and behavior as similar as possible to the original game.

=============================================================================

According to Wikipedia ( https://en.wikipedia.org/wiki/Breakout_(video_game)), the Breakout arcade game was conceived at Atari by Nolan Bushnell and Steve Bristow.  A working prototype was built by Steve Wozniak. (Steve Job's role was to steal Wozniak's fair share of the bonus for reducing the design's chip count.)  Steve Wozniak's highly optimal design was clever to the point that Atari was unable to modify it to add the coin slot control needed for an arcade game.  So, Atari went with their own design using more chips.  Per Steve Wozniak the final game appeared to work the same as his design.

An important fact here is that Breakout is a very early arcade game built from digital logic chips.  There is no CPU, no program executing, so no source code.  Therefore any programmable system is only simualting the behaviors.  I have no Breakout system of my own, and even if I did I have no electronics background myself, so I can not dissect the electronics.  This limits me to guesses from watching how the game behaves in pictures and videos on the internet.

=============================================================================

**GRAPHICS**:

The screen display is black and white, but is not an ordinary black and white television.  It is a specialized, dedicated monitor with a very tall aspect.  The display exhibits the expected CRT behavior just like a TV -- "Pixels" are drawn in horizontal scan lines, and a number of scan lines stacked vertically to create the display.  "Pixels" may be stretching what the Breakout hardware actually does as the modern use of the word implies a memory value directly related to each dot on the display. The dedicated digital logic does not implement memory-mapped pixels in this sense.  "Pixels" are signals triggered by logic conditions.  (I saw a video of Woz discussing the game wherein he reveals the game had 256 bits of memory -- enough to count the bricks.)  

Due to the display's extremely tall aspect the game's video output is certainly not timed like the Atari's display which is tied to the NTSC color clock.  Therefore, the "pixels" in the Breakout game likely do not correspond to the Atari's color-clock-sized pixels.  Consequently, the best that can be done is an approximation on the Atari.  

Below is a screen capture of video of an emulator implementing Breakout: 

![Game Screen Pixels](Breakoput_bw_startup_overscan_plus_ball.png?raw=true "Game Screen Pixels")

The emulator blurs and blends its pixels to simulate the output of the CRT.  This makes it difficult to determine the real start/end position of a Breakout game "pixels".  Therefore, all discussion of object sizes in terms of "pixel" dimensions are implicitly qualified with "appears to be" due to the vague nature of Breakout's "pixels" versus the approximation of an Atari NTSC-based pixel.

So, then how to make that approximation?  The Breakout vertical aspect is very tall; far greater than the Atari's display originally intended for NTSC color televition.  If the simulated Atari pixels are to be believed then there are around 400 scan lines displayed on the screen.  Therefore, everything will be estimated based on how to scale the Breakout screen to the height of the Atari screen.

**OVERALL ESTIMATION**:

The screen grab of the emulator video from Youtube is 331 x 480 pixels tall.  

The emulator is duplicating full overscan for the game display.  In a real Breakout game a portion of the top and bottom of the display visible in the screen grab is off the CRT.  

Cropping the screen grab to the vertical size needed for display reduces the image height to 400 pixels:

![Game Screen Pixels](Breakoput_bw_startup_crop_to_underscan.png?raw=true "Game Screen Pixels")

On the Atari we need to define an appropriate vertical size for the game screen.  Contrary to Commodore's marketing information in the 1980s the Atari is not limited to 192 scan lines.  The Atari's display hardware is inherently capable of producing graphics and text up to 240 scan lines -- well into the overscan area off the edges of the screen.  In my experience the typical 13" color television of the 1980s could safely display about 16 scan lines more than the default 192 scan lines before running into the overscan area.

Therefore the Atari display for Breakout is easily variable to best match the aspect.  Either 200 or 208 scan lines are easily workable and visible on the majority of NTSC displays.  This should put the math close to 2 to 1 for the Breakout arcade screen grabs vs the scan lines needed for the Atari.

Therefore 208 Atari scan lines divided by 400 Breakout scan lines provide a Breakout to Atari scaling factor of 0.52 (or in the other direction 1.92307692308).

However, this scaling factor is correct only for vertical estimation.  The Breakout emulator screen grab pixels are square.  Real Atari pixels are based on the NTSC color clock timing which is not square.  (The color clock horizontal to scan line vertical size relationship is the same for other systems following NTSC specifications -- Bally Astrocade, Atari 2600, Apple II, Amiga.)  Therefore, an additional scaling factor is needed to adjust the horizontal size to fit within color clock dimensions.  

The color clock horizontal to vertical ratio is 22 / 13 which is a 1.692307 scaling factor (or 0.5909090909 when multiplying in the other direction.)   (The 22 / 13 ratio is from the 11 / 13 aspect ratio published for the Amiga's low resolution/140ns pixels which is 1/2 color clock wide.)

Thus the horizontal color clocks needed for the Breakout screen is 331 Breakout pixels times 0.52 to scale down to the Atari screen size, times 0.5909090909 to convert the horizonal dimensions to color clocks, or 101.7072 color clocks, and so, 101 Atari medium res pixels. (This includes the vertical borders around Bricks' playfield area.) This is well within the Atari's horizontal display dimensions, and is actually smaller than the Atari's narrow screen width.

**BORDERS**:

The game displays a visible Border at the top, left and right sides of the screen which rebound the ball.  The horizontal Border is about 16 lines tall -- converted to Atari dimensions this is 8.32 scan lines, so then 8 scan lines thick.  This will likely be displayed as regular graphics.

The left and right Borders work out to two Atari pixels (color clocks) wide.  If the vertical Borders are implemented using mapped graphics it would require the entire screen be drawn in the same graphics mode.  Alternatively, the vertical Borders could be drawn with Player/Missile graphics which also provide the ability to draw beyond the top and bottom edge of the playfield which is how they appear in the Breakout game.  Using Player/Missile graphics for the borders would also make it easier to use the best graphics or text mode fit for the different sections of the display.

**BALL**:

The Ball is the smallest, visible, discrete object in Breakout and notably does not appear square -- it appears wider than it is tall.  While it is the smallest "lit" object it does not correspond to the smallest visible signal control for Breakout.  The vertical gaps between Bricks are smaller than the Ball's width. 

On the screen grab the Ball is about six pixels wide by four pixels tall.  Per the Atari pixel scale it is approximately two  scan lines tall.  Horizontally, it is one and a half color clocks wide.  Rounding to one color clock makes the ball appear taller than wide which is the wrong effect.  Rounding to two color clocks makes the ball as wide as the vertical borders.  So, this is where compromise is needed.  The Ball may be reduced to only one color clock wide and one scan line tall to maintain the visual appearance.

The Ball will be implemented as a Player or Missile.  This will allow the ball to move wherever needed on the screen without a contiguous graphics mode for the entire display.

**BRICKS**:

There are eight rows of 14 Bricks each.  (Side bar... 14 is such a weird number.  Considering the discrete electronics nature of the game construction it would seem more sensible for there to be a base 2 number of bricks -- such as 16 bricks, not 14.  I can only theorize that the two missing bricks actually represent the left and right borders.)

The area of the bricks is 63 pixels tall.  Scaled to the Atari dimensions this is 32.76 scan lines.  32 is a good approximation as this is even divisible by the number of lines.  A row of bricks works out to 3 scan lines of pixels and one blank blank line separating each row.

The area of the Bricks is 318 pixels wide. Scaled to the Atari color clocks this is 97.712 pixels wide which works out to 6.97948 color clocks per brick including one color clock for the gap between bricks.  Rounding up makes 7 color clocks per Brick.  So, a total of 98 pixels, less one for the unneeded gap after the last Brick is 97 color clocks.  This is less than ANTIC narrow screen width.

**PADDLE**:

The Paddle at its widest is the same width as a Brick -- 7 visible pixels (color clocks).  When the Paddle switches to narrow width it is about four pixels (color clocks) wide, or only twice the width of the Ball.  The Paddle is visibly thicker then the height of a brick -- definitively three pixels (six scan lines) tall.  When the game is over the Paddle is replaced by a solid horizontal Border the width of the screen.  This border acts as a giant Paddle during the game's demo mode keeping the ball rebounding up toward the Bricks.  The Paddle would likely be implemented as Player/Missile graphics.  The solid Border would be mapped graphics.  

**PLAYER, BALL COUNTER, and SCORES**:

The current Player number, the Ball Counter, and the Scores appear in the blank area above the Bricks.  This blank area occupies vertical space approximately equal height to the region of the eight Brick rows on the screen.  The Ball travels through this area and straight through any of the numbers without being deflected.

These numbers are very large, tall objects on screen. The numbers and the space between them are the same width as a brick.  So, horizontally, the numbers including the space between them are 8 pixels/color clocks wide.  The height approaches 10 pixels (or 20 scan lines) tall which is taller than any font on the Atari.  ANTIC Mode 7 text is the nearest match at 16 scan lines tall.  The loss of a few scan lines should be acceptable with a custom font modeled after the appearance of the arcade Breakout numbers.  Alternatively, the score could be drawn as graphics.

Note that in the arcade game there are labels painted in yellow on the glass over the display indicating which value is the Player number, and the Ball Counter.  This should be duplicated in the game as graphics/text on the screen to meaningfully label the numbers. 

**COLOR**:

The game is output only in black and white video.  However, colored plastic strips placed horizontally on the screen over the Bricks add "color" to the display.  Each pair of Brick rows is provided a different color.  From top to bottom: red, orange, green, yellow.   A blue plastic overlay is provided for the Paddle's row.  The picture below is the color representation from an emulator:

![Game Color Pixels](Breakoput_cl_startup_crop_to_underscan.png?raw=true "Game Color Pixels")

I captured the averaged color in each area from the color screen grab of the Breakout emulator game (above).  I then compared each Breakout color to the closest apparent matching RGB equivalent in the Atari palette.  (Using the GIMP eyedropper tool, a reference picture grabbed from an Atari emulator of the entire pallette, and my eyeballs.)  The final result is the best matching color from the  Atari's 128 color palette: 

| Object     | Breakout RGB | Atari RGB  | Atari Palette |
| ---------- | ------------ | ---------- | ------------- |
| Borders    | cccccc       | c5c5c5     | $0C           |
| Paddle     | 026f9d       | 1b6ad8     | $96           |
| Red        | 94200f       | 931302     | $34           |
| Orange     | c28712       | bf6d04     | $28           |
| Green      | 0a8334       | 006b25     | $B4           |
| Yellow     | c1c23d       | bfb200     | $FA           |

(Notes from Capt Obvious: Since the plastic overlay covers the width of the screen, the Borders are also colored at those row positions, and the Ball is colored when it passes through those rows.)  

The color effect would be duplicated by a set of Display List Interrupts that change the color register parameters at different vertical locations on the screen.  To be convincing it will need to change the Bricks, Borders, and Ball colors at the same time.  (and lower on the screen set the Paddle, Borders, and Ball color.)

=============================================================================

**AUDIO**:

So far three apparent sounds ....

| Object | Sound Pitch |
| ------ | ----------- |
| Paddle | High | 
| Borders | Medium | 
| Bricks | Low | 

It doesn't seem to be impact to a brick that triggers the sound.  Rather, it is the score counter increment that initiates sound.  One strike on a Yellow Brick cause one tone for one point added to the score.  One strike on a Red Brick causes 7 tones as the game adds 7 individual points to the score.

=============================================================================

**GAMEPLAY**:

**OVERVIEW**:

This is a brutal game.  It is simple in concept and unforgiving in execution.  Conceived at a time when most "arcade" games were electromechanical tests of skill this game is designed to suction a quarter out of your pocket as fast as the player's feeble skills permit.  A typical player is not expected to clear all the bricks from one screen, much less two. In fact, the real game hardware only lasts through the second screen and then glitches out after that.

The game begins at a difficulty level any child could handle and quickly progresses to a speed only the twitchiest paddle jockey can survive.  But, oddly, people still love to play this game and to be humiliated by it.  This is a good indicator that the game play is nicely balanced between human play time vs difficulty progression.  An easy game becomes boring.  An impossible game or a game that feels like it cheats the player discourages repeat play.  Many games with poor play planning simply overwhelm the player with enemies to the point where it is literally impossible to progress or win by either a human or a computer.  However, the mechanics of Breakout make it feel like it is the player's responsibility for losing the game, not that the game robbed the player.  The player can clearly see the ball, but doesn't turn the Paddle controller in time to hit the Ball.  The player is trying to hit the Ball on the edge of the Paddle to change the Ball's direction and misses.  The only one to blame is the player.

Breakout is frequently immitated, because the game concept is so simple.  For decades the Breakout concept has been a frequent rite of passage for thousands of programmers from beginners learning programming to experienced programmers learning a new language, to commercial game production houses looking to squeeze more money from a concept that refuses to die.  But, as often as not, the result is poor or clumsy compared to the original Breakout.  Programmers often over-think the game play and implement behavior that is not in the game.  Simple alterations in the game play can make the game too easy to be interesting.  Sloppy play handling and inconsistent collision detection can make the game too difficult to be playable.  The playability topics are visited below. . .  

**SERVE**:


**BRICKS, POINTS**:


**PADDLE**


**REBOUNDs, COLLISIONS**:

=============================================================================

**IMPLEMENTATION**


**TITLE SCREEN**:


**GAME SCREEN**:


WIP....
