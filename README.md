# Atari-Breakout76
Currently Work In Progress..

=============================================================================

This is a simple Breakout clone for Atari 8-bit computers approximating the look and feel of the original arcade Breakout released by Atari in 1976 (without the bugs).

This version uses only the Atari computer features necessary to mimic the correct look and behavior with as few extraneous bells and whistles as possible.

Or, you could just get an emulator to play the original game.

=============================================================================

The real purpose of this is to create a modular framework for working on game projects that I can understand and sustain. (Your Mileage May Vary.)  

I had been in the middle of Breakout-GECE, and the debugging effort in that game required copying and pasting code from different places together into one workable test program.  This makes the test program very monolithic and complicated to keep everything organized.  This was workable when I had time to focus on the program every day, but recent demands on my personal time have reduced the development thinking opportunities -- sometimes to only an hour in a week which is not enough time to re-wrap  my brain cells around the game details.  

Therefore, the idea here is to force a more stringent modularization of the code and data, keeping visual components entirely separate, so when I need to look at a part of the game, I will know exactly which files and locations to find everything without having to remember what I am looking at.  The first victim to test this strategy is an attempt to make reasonable immitation of the original arcade Breakout video game. The  scope of Atari's bells and whistles will be primarily limited to implementing the visuals, sound, and behavior as similar as possible to the original game.

=============================================================================

According to Wikipedia ( https://en.wikipedia.org/wiki/Breakout_(video_game)), the Breakout arcade game was conceived at Atari by Nolan Bushnell and Steve Bristow.  A working prototype was built by Steve Wozniak. (Steve Job's role was to steal Wozniak's fair share of the bonus for reducing the design's chip count.)  Atari was unable to use Wozniak's design.  The game Steve Wozniak built worked, so it should not have been difficult to duplicate wiring and chips.  Therefore, I would infer that Atari wanted to make some kind of design change and they didn't have anyone on hand clever enough to understand Wozniak's design. So, Atari went with their own design using a lot more chips.  Per Steve Wozniak the final game appeared to work the same as his design.

An important fact here is that Breakout is a very early arcade game made of a collection of digital logic chips.  There is no CPU, no program executing, so no source code.  Therefore any programmable system is only simualting the behaviors.  I have no Breakout system of my own, and even if I did I have no electronics background myself, so I can not dissect the electronics.  This limits me to guesses from watching how the game behaves in pictures and videos on the internet.

=============================================================================

GRAPHICS:
The screen display is black and white, but is not an ordinary black and white television.  It is a specialized, dedicated monitor with a very tall aspect.  Like a TV, it exhibits CRT behavior -- "Pixels" are drawn in horizontal scan lines, and a number of scan lines stacked vertically to create the display.  "Pixels" may be stretching what the Breakout hardware actually does as the modern use of the word implies a memory value directly related to each dot on the display. The dedicated digital logic does not implement memory directly related to pixels in this sense.  "Pixels" are signals triggered by logic conditions.  (I saw a video of Woz discussing the game wherein he reveals the game had 256 bits of memory -- enough to count the bricks.)  

Due to the display's extremely tall aspect it is unlikely the game's video output is timed in the same way as the Atari's compliance with the NTSC color clock, so the "pixels" in the Breakout game probably do not correspond to the Atari's color-clock-sized pixels.  Therefore, the best that can be done is an approximation on the Atari.  Below is a screen capture of video of an emulator implementing Breakout.  On this screengrab I simulate an Atari pixel and overlay it around the Breakout game's graphics objects to gauge the sizes.   (----- reedit --- one color clock wide by two scan lines tall (ANTIC map mode B or D) .....)

![Game Screen Pixels](breakout_bw_pixels.jpg?raw=true "Game Screen Pixels")

The emulator blurs and blends its pixels to simulate the output of the CRT.  The red dots on the captured images are 3x3 pixels meant to approximate the Atari pixel at one color clock wide, two scan lines tall.  This appears to work out nicely as the graphics objects on screen fit well using this measurement.  As we will see later, appearances are not always correct.

BRICKS:
There are eight rows of 14 bricks each.  The bricks are horizontally and vertically separated from each other by a small gap.  The Atari pixel scale measures a brick at approximately 7 pixels wide, and two pixels tall (or seven color clocks by four scan lines).  The vertical gaps work out fairly close to one pixel (one color clock) wide, and the horizontal gaps appear close to one pixel (two scan lines) tall. Including the pixel required for the gap to one side of a brick, and the gap between bricks puts the dimension of a brick at 8 pixels (color clocks) wide and three pixels (six scan lines) tall.  

The fourteen bricks then require 111 pixels/color clocks of screen width on the Atari. That's seven color clocks of bricks plus one more for the gap times 14 bricks and minus one pixel for the unneeded gap at the end of the line.  This is a little less than ANTIC narrow screen width. 

The eight rows of bricks require 46 scan lines of screen height.  That's four scan lines for each brick row, plus two more for the gap between rows and minus two scan lines for the unneeded gap after the bricks.  Not quite the height of six lines of ANTIC mode 2 text, and roughly a quarter of the screen height.

SCORE:
The score and ball counters are large, tall numbers.  The numbers and the space between them are the same with as a brick.  So, horizontally, the numbers are 8 pixels/color clocks wide. The height approaches 10 pixels (or 20 scan lines) tall which is taller than any font on the Atari.  ANTIC Mode 7 text is the nearest match at 16 scan lines tall.  The loss of a few scan lines should be acceptable with a custom font modeled after the appearance of the arcade Breakout numbers.  Alternatively, the score could be drawn as graphics.

BORDERS:
The game displays a visible border at the top, left and right sides of the screen which rebound the ball.  The horizontal border is about four pixels (eight scan lines) thick.  This will likely be displayed as regular graphics.  The left and right borders are two pixels (color clocks) wide.  Using mapped graphics requires most of the screen be drawn in the same graphics mode.  Alternatively, the vertical borders could be drawn with Player/Missile graphics which also provide the ability to draw beyond the top and bottom edge of the playfield which is how they appear in this game. 

BALL:
Interestingly, the ball appears wider than it is tall.  It is approximately two scan lines high, and two pixels (color clocks) wide making it horizontally rectangular.  The ball will be implemented as a Player or Missile.  This allows the ball to move where needed on the screen without a corresponding graphics mode.

PADDLE:
The paddle at its widest is the same width as a brick -- 7 visible pixels (color clocks).  When the paddle switches to narrow width it is about four pixels (color clocks) wide only twice the width of the ball. The paddle is three pixels (six scan lines) tall.  When the game is over the paddle is replaced by a solid horizontal border the width of the screen.  This border acts as a giant paddle during the game's demo mode keeping the ball rebounding up to the bricks.  The paddle will probably be implemented as Player/Missile graphics. The solid border would be mapped graphics.  

COLOR:
The game is output only as  black and white.  Colored plastic strips placed horizontally on the screen add "color" to the display.  Every pair of rows is provided a different color.  From top to bottom: red, orange, yellow, green.   A blue plastic overlay is provided for the paddle's row.  (Notes from Capt: Obvious: Since the plastic overlay covers the width of the screen, the borders are also colored at those row positions, and the ball is colored when it passes through those rows.  duh') This could be duplicated by a set of Display List Interrupts that change the color register parameters at different vertical locations on the screen.

=============================================================================

AUDIO:

=============================================================================

GAMEPLAY:

=============================================================================

WIP....

