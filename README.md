# Atari-Breakout76
Currently Work In Progress..

;=============================================================================

This is a simple Breakout clone approximating the look and feel of the original arcade Breakout released by Atari in 1976.

This version uses only the Atari features necessary to achieve the correct look and behavior with as few extraneous bells and whistles as possible.

Or, you could just get an emulator to play the original game.

;=============================================================================

The real purpose of this is to create a modular framework for working on game projects that I can understand and sustain. (Your Mileage May Vary.)  

I had been in the middle of Breakout-GECE, and the debugging effort in that game required copying and pasting code from different places together into one workable test program.  This makes the test program very monolithic and complicated to keep everything organized.  This was workable when I had time to focus on the program every day, but recent demands on my personal time have reduced the development thinking opportunities -- sometimes to only an hour in a week.  This isn't even enough time to get my brain cells re-wrapped around the game details again.  

Therefore, the idea here is to force a more stringent modularization of the code and data, keeping visual components entirely separate, so when I need to look at a part of the game, I will know exactly which files and locations to find everything without having to remember what I am looking at.  The first victim of this strategy is to implement a reasonable immitation of the Breakout video game in its original condition.  There will be the fewest bells and whistles used to keep the visuals, sound, and behavior similar to the original.

;=============================================================================

According to Wikipedia ( https://en.wikipedia.org/wiki/Breakout_(video_game)), the Breakout arcade game was conceived at Atari by Nolan Bushnell and Steve Bristow.  A working prototype was built by Steve Wozniak. (Steve Job's role was to steal Wozniak's fair share of the bonus for reducing the design's chip count.)  Atari was unable to use Wozniak's design.  The game Steve Wozniak built worked, so it should not have been difficult to duplicate wiring and chips.  Therefore, I would infer that Atari wanted to make some kind of design change and they didn't have anyone on hand clever enough to understand Wozniak's design. So, Atari went with their own design using a lot more chips.  Per Steve Wozniak the final game appeared to work the same as his design.

An important fact here is that Breakout is a very early arcade game made of a collection of digital chips.  There is no CPU, no program executing, so no source code.  Therefore any programmable system is only simualting the behaviors.  I have no Breakout system of my own, and even if I did I have no electronics background myself, so I can only guess at how everything behaves by looking at the pictures and videos on the internet.

One of these behaviors is how the graphics worked.  The output to the screen is black and white.  I think it unlikely that the graphics output hardware is timed to NTSC frequency, so I suspect the pixels are not the same size as color clocks......

WIP.

