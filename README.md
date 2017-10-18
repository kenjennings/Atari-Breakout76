# Atari-Breakout76
Currently Work In Progress..

;=============================================================================

This is a simple Breakout clone approximating the look and feel of the original arcade Breakout released by Atari in 1976.

This version uses only the Atari features necessary to achieve the correct look and behavior with as few extraneous bells and whistles as possible.

Or, you could just get an emulator to play the original game.

;=============================================================================

The real purpose of this is to create a modular framework for working on game projects that I can understand and sustain. (Your Mileage May Vary.)  

I had been in the middle of Breakout-GECE, and the debugging effort in that game required copying and pasting code from different places together into one workable test program.  This makes the test program very monolithic and complicated to keep everything organized.  This was workable when I had time to focus on the program every day, but recent demands on my personal time have reduced the development thinking opportunities -- sometimes to only an hour in a week which is not enough time to re-wrap  my brain cells around the game details.  

Therefore, the idea here is to force a more stringent modularization of the code and data, keeping visual components entirely separate, so when I need to look at a part of the game, I will know exactly which files and locations to find everything without having to remember what I am looking at.  The first victim to test this strategy is an attempt to make reasonable immitation of the original arcade Breakout video game. The  scope of Atari's bells and whistles will be primarily limited to implementing the visuals, sound, and behavior as similar as possible to the original game.

;=============================================================================

According to Wikipedia ( https://en.wikipedia.org/wiki/Breakout_(video_game)), the Breakout arcade game was conceived at Atari by Nolan Bushnell and Steve Bristow.  A working prototype was built by Steve Wozniak. (Steve Job's role was to steal Wozniak's fair share of the bonus for reducing the design's chip count.)  Atari was unable to use Wozniak's design.  The game Steve Wozniak built worked, so it should not have been difficult to duplicate wiring and chips.  Therefore, I would infer that Atari wanted to make some kind of design change and they didn't have anyone on hand clever enough to understand Wozniak's design. So, Atari went with their own design using a lot more chips.  Per Steve Wozniak the final game appeared to work the same as his design.

An important fact here is that Breakout is a very early arcade game made of a collection of digital logic chips.  There is no CPU, no program executing, so no source code.  Therefore any programmable system is only simualting the behaviors.  I have no Breakout system of my own, and even if I did I have no electronics background myself, so I can not dissect the electronics.  This limits me to guesses from watching how the game behaves in pictures and videos on the internet.

One of these behaviors is how the graphics work.  The screen display is black and white.  I have not determined if the screen is a plain, black-and white TV, or a dedicated monitor.  A TV has a lot of unnecessary parts such as a tuner, so I suspect it is a simple monitor.  Either way this means it exhibits CRT behavior -- "Pixels" are drawn in horizontal scan lines, and a number of scan lines stacked vertically to create the display.  "Pixels" may be stretching what the Breakout hardware actually does as the modern use of the word implies a memory value resulting in a predictable dot on a display. The dedicated digital logic does not implement memory in this sense and "pixels" are signals triggered by logic conditions.  

It is unlikely the game's video output is timed in the same way as the Atari's compliance with the NTSC color clock, so the "pixels" in the Breakout game probably do not correspond to the Atari's color-clock-sized pixels.  Therefore, the best that can be done is an approximation on the Atari.  Below is a screen capture of video of an emulator implementing Breakout.  On this screengrab I simulate an Atari pixel one color clock wide by two scan lines tall (ANTIC map mode B or D) and overlay it around the Breakout game's graphics objects to gauge the sizes.....

![Game Screen Pixels](breakout_bw_pixels.jpg?raw=true "Game Screen Pixels")

The emulator blurs and blends its pixels to simulate the output of a CRT.  The red dots are 3x3 pixels meant to approximate the Atari pixel at one color clock wide, two scan lines tall.  This works out nicely as the graphics objects on screen fit well using this measurement.

There are eight rows of 14 bricks each.  The bricks are horizontally and vertically separated from each other by a small gap.  The Atari pixel scale measures a brick at approximately 7 pixels wide, and two pixels tall (or seven color clocks by four scan lines).  The vertical gaps work out fairly close to one pixel (one color clock) wide, and the horizontal gaps appear close to one pixel (two scan lines) tall. Including the pixel required for the gap to one side of a brick, and the gap between bricks puts the dimension of a brick at 8 pixels (color clocks) wide and three pixels (six scan lines) tall.  

The fourteen bricks then require 111 pixels/color clocks of screen width on the Atari. That's seven color clocks of bricks plus one more for the gap times 14 bricks and minus one pixel for the unneeded gap at the end of the line.  This is a little less than the Atari narrow screen width. 

The eight rows of bricks require 46 scan lines of screen height.  That's four scan lines for each brick row, plus two more for the gap between rows and minus two scan lines for the unneeded gap after the bricks.  Not quite the height of six lines of ANTIC mode 2 text, and roughly a quarter of the screen height.

The score and ball counters are large, tall numbers.  The numbers and the space between them are the same with as a brick.  So, horizontally, the numbers are 8 pixels/color clocks wide.

WIP....

