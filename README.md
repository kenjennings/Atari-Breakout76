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

According to Wikipedia ( https://en.wikipedia.org/wiki/Breakout_(video_game)), the Breakout arcade game was conceived at Atari by Nolan Bushnell and Steve Bristow.  A working prototype was built by Steve Wozniak. (Steve Job's role was to steal Wozniak's fair share of the bonus for reducing the design's chip count.)  Atari was unable to use Wozniak's design.  The game Steve Wozniak built worked, so it should not have been difficult to duplicate wiring and chips.  Therefore, I would infer that Atari wanted to make some kind of design change and they didn't have anyone on hand clever enough to understand Wozniak's design. So, Atari went with their own design using a lot more chips.  Per Steve Wozniak the final game appeared to work the same as his design.

An important fact here is that Breakout is a very early arcade game made of a collection of digital logic chips.  There is no CPU, no program executing, so no source code.  Therefore any programmable system is only simualting the behaviors.  I have no Breakout system of my own, and even if I did I have no electronics background myself, so I can not dissect the electronics.  This limits me to guesses from watching how the game behaves in pictures and videos on the internet.

=============================================================================

**GRAPHICS**:
The screen display is black and white, but is not an ordinary black and white television.  It is a specialized, dedicated monitor with a very tall aspect.  The display exhibits the expected CRT behavior just like a TV -- "Pixels" are drawn in horizontal scan lines, and a number of scan lines stacked vertically to create the display.  "Pixels" may be stretching what the Breakout hardware actually does as the modern use of the word implies a memory value directly related to each dot on the display. The dedicated digital logic does not implement memory-mapped pixels in this sense.  "Pixels" are signals triggered by logic conditions.  (I saw a video of Woz discussing the game wherein he reveals the game had 256 bits of memory -- enough to count the bricks.)  

Due to the display's extremely tall aspect it is unlikely the game's video output is timed to the NTSC color clock in the same way as the Atari computer, so the "pixels" in the Breakout game likely do not correspond to the Atari's color-clock-sized pixels.  Therefore, the best that can be done is an approximation on the Atari.  

Below is a screen capture of video of an emulator implementing Breakout.  The horizontal red line near the bottom is from the YouTube video player and is not part of the game.  On this screengrab the red dots simulate an Atari pixel overlaid on the Breakout game's graphics objects to gauge the sizes: 

![Game Screen Pixels](breakout_bw_pixels.jpg?raw=true "Game Screen Pixels")

The emulator blurs and blends its pixels to simulate the output of the CRT.  This makes it difficult to determine the real start/end position of a Breakout game "pixels".  The red dots on the captured images are 3x3 graphics pixels meant to approximate one Atari pixel at one color clock wide, two scan lines tall -- the equivalent of ANTIC map mode B or D.  Therefore, all discussion of object sizes in terms of "pixel" dimensions are implicitly qualified with "appears to be" due to the vague nature of Breakout's "pixels" versus the approximation of an Atari NTSC-based pixel.

**OVERALL**:
The entire screen is very tall.  If the simulated Atari pixels are to be believed then there are around 400 scan lines displayed on the screen.  (So, then it is entirely possible there are fewer lines -- given the huge vertical scale it could actually be 200 scan lines.  Still researching this.)  Since the Atari displays approximately half this number of scan lines, then approximations and sacrifices will be needed.  

**BORDERS**:
The game displays a visible Border at the top, left and right sides of the screen which rebound the ball.  The horizontal Border is about four pixels (eight scan lines) thick.  This will likely be displayed as regular graphics.

The left and right Borders are two pixels (color clocks) wide.  If the vertical Borders are implemented using mapped graphics it would require the entire screen be drawn in the same graphics mode.  Alternatively, the vertical Borders could be drawn with Player/Missile graphics which also provide the ability to draw beyond the top and bottom edge of the playfield which is how they appear in the Breakout game.  Using Player/Missile graphics for the borders would also make it easier to use the best graphics or text mode fit for the different sections of the display.

**BALL**:
The Ball is the smallest, visible, discrete object in Breakout and notably not a square -- it appears wider than it is tall.  Per the Atari pixel scale it is approximately one pixel tall, and two pixels wide, (or two scan lines high, and two pixels (color clocks) wide) making it horizontally rectangular.  While it is the smallest "lit" object it does not correspond to the smallest visible signal control for Breakout.  The vertical gaps between Bricks are smaller than the Ball's width.  

The Ball will be implemented as a Player or Missile.  This allows the ball to move whereever needed on the screen without a contiguous graphics mode for the entire display.

**BRICKS**:
There are eight rows of 14 Bricks each.  (Side bar... 14 is such a weird number.  Considering the discrete electronics nature of the game construction it would seem more sensible for there to be a base 2 number of bricks -- such as 16 bricks, not 14.  I can only theorize that the two missing bricks actually represent the left and right borders.)

The Bricks are horizontally and vertically separated from each other by a small gap.  The Atari pixel scale measures a Brick at approximately 7 pixels wide, and two pixels tall (or seven color clocks by four scan lines).  The vertical gaps work out fairly close to one pixel (one color clock) wide, and the horizontal gaps appear close to one pixel (two scan lines) tall.  Including the pixel required for the gap to one side of a Brick, and the gap between rows puts the dimension of a Brick at 8 pixels (color clocks) wide and three pixels (six scan lines) tall.

The fourteen Bricks then require 111 pixels/color clocks of screen width on the Atari. (Eight color clocks of Brick and gap, minus one pixel for the unneeded gap at the end of the line.)  This is less than ANTIC narrow screen width.  For the purpose of simulating a more correct aspect the horizontal dimension could be cut down further. 

The eight rows of Bricks require 46 scan lines of screen height.  That's four scan lines for each brick row, plus two more for the gap between rows and minus two scan lines for the unneeded gap after the Bricks.  Not quite the height of six lines of ANTIC mode 2 text, which is roughly a quarter of the Atari screen height. This is a significantly larger portion of the screen's vertical real estate on the Atari computer than the real game.  The scale aspect may be sacrificed by using only one blank scan line between rows.  This shortens the Brick area to 39 scan lines.  If the Bricks themselves are reduced to three scan lines this shortens the Brick area to 31 scan lines, about 4 lines of ANTIC mode 2 text.

**PADDLE**:
The Paddle at its widest is the same width as a Brick -- 7 visible pixels (color clocks).  When the Paddle switches to narrow width it is about four pixels (color clocks) wide, or only twice the width of the Ball.  The Paddle is visibly thicker then the height of a brick -- definitively three pixels (six scan lines) tall.  When the game is over the Paddle is replaced by a solid horizontal Border the width of the screen.  This border acts as a giant Paddle during the game's demo mode keeping the ball rebounding up toward the Bricks.  The Paddle would likely be implemented as Player/Missile graphics.  The solid Border would be mapped graphics.  

**PLAYER, BALL COUNTER, and SCORES**:
The current Player number, the Ball Counter, and the Scores appear in the blank area above the Bricks.  This blank area occupies vertical space approximately equal height to the region of the eight Brick rows on the screen.  The Ball travels through this area and straight through any of the numbers without being deflected.

These numbers are very large, tall objects on screen. The numbers and the space between them are the same width as a brick.  So, horizontally, the numbers including the space between them are 8 pixels/color clocks wide.  The height approaches 10 pixels (or 20 scan lines) tall which is taller than any font on the Atari.  ANTIC Mode 7 text is the nearest match at 16 scan lines tall.  The loss of a few scan lines should be acceptable with a custom font modeled after the appearance of the arcade Breakout numbers.  Alternatively, the score could be drawn as graphics.

Note that in the arcade game there are labels painted in yellow on the glass over the display indicating which value is the Player number, and the Ball Counter.  This should be duplicated in the game as graphics/text on the screen to meaningfully label the numbers. 

**COLOR**:
The game is output only in black and white video.  However, colored plastic strips placed horizontally on the screen over the Bricks add "color" to the display.  Each pair of Brick rows is provided a different color.  From top to bottom: red, orange, green, yellow.   A blue plastic overlay is provided for the Paddle's row.  The picture below is the color representation from an emulator.  The horizontal red line near the bottom of the screen is from the YouTube video player and is not part of the game:

![Game Color Pixels](breakout_color.jpg?raw=true "Game Color Pixels")

I captured the dominant color in each area from the color screen grab of the Breakout emulator game (above).  I then compared those colors to the closest apparent matching RGB equivalent in the Atari palette, and then report the final result as one of the Atari's 128 color.  Here are the best guesses for the object colors: 

| Object     | Emulator RGB | Atari RGB  | Atari Palette |
| ---------- | ------------ | ---------- | ------------- |
| Borders    | cccccc       | c5c5c5     | $0C           |
| Paddle     | 026f9d       | 1b6ad8     | $96           |
| Red        | 94200f       | 931302     | $34           |
| Orange     | c28712       | bf6d04     | $28           |
| Green      | 0a8334       | 006b25     | $B4           |
| Yellow     | c1c23d       | bfb200     | $FA           |

(Notes from Capt Obvious: Since the plastic overlay covers the width of the screen, the Borders are also colored at those row positions, and the Ball is colored when it passes through those rows.  duh')  

The color effect would be duplicated by a set of Display List Interrupts that change the color register parameters at different vertical locations on the screen.  To be convincing it will need to change the Bricks, Borders, and Ball colors at the same time.  (and lower on the screen set the Paddle, Borders, and Ball color.)

=============================================================================

AUDIO:

So far three aparent sounds ....

| Object | Sound Pitch |
| ------ | ----------- |
| Paddle | High | 
| Borders | Medium | 
| Bricks | Low | 

It doesn't seem to be impact to a brick that triggers the sound.  Rather, it is the score counter increment that initiates sound.  One strike on a Yellow Brick cause one tone for one point added to the score.  One strike on a Red Brick causes 7 tones as the game adds 7 individual points to the score.

=============================================================================

GAMEPLAY:

This is a brutal game.  It is deviously difficult.  Conceived at a time when most "arcade" games were electromechanical tests of skill this game is designed to suction a quarter out of your pocket as fast as the player's feeble skills permit.

It is not expected that a typical player can finish one screen, much less two, so the real game hardware only lasts through the second screen, and then glitches out after that.  The game begins at a difficulty level any child could handle and quickly progresses to a speed only the twitchiest paddle jockey can survive.  But, oddly, people just never learn and still love to play this game and be humiliated by it.  This is a good indicator that the game is nicely balanced between game play vs difficulty progression.  An easy game becomes boring.  A game that is too hard discourages players, so they give up on it.

 
=============================================================================

WIP....
