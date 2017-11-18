# Atari-Breakout76
Currently Work In Progress..

=============================================================================

This is a simple Breakout clone for Atari 8-bit computers approximating the look and feel of the original arcade Breakout released by Atari in 1976 (without the bugs).

The overarching goal here is to maintain visual presentation and play action as similar as possible to the original arcade game as well as can be done by the Atari computer's capabilities. Therefore, certain clever features of the Atari may not be the preferred choice if the result does not conform to the original game presentation.  This version uses only the Atari computer features necessary to mimic the correct look and behavior with as few extraneous bells and whistles as possible.

Or, you could just get an emulator to play the original game.

=============================================================================

The real purpose of this is to create a modular framework for working on game projects that I can understand and sustain. (Your Mileage May Vary.)  

I had been in the middle of Breakout-GECE, and the debugging effort in that game required copying and pasting code from different places together into one workable test program.  This makes the test program very monolithic and complicated to keep everything organized.  This was workable when I had time to focus on the program every day, but recent demands on my personal time have reduced the development thinking opportunities -- sometimes to only an hour in a week which is not enough time to re-wrap  my brain cells around the game details.  

Therefore, the idea here is to force a more stringent modularization of the code and data, keeping visual components entirely separate, so when I need to look at a part of the game, I will know exactly which files and locations to find everything without having to remember what I am looking at.  The first victim to test this strategy is an attempt to make reasonable immitation of the original arcade Breakout video game.  The scope of Atari's bells and whistles will be primarily limited to implementing the visuals, sound, and behavior as similar as possible to the original game.

=============================================================================

**Section 00: Introduction**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README00Intro.md )

**Section 01: Display Asset Estimation**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README01AssetEstimation.md )

**Section 02: Audio**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README02Audio.md )

**Section 03: Gameplay**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README03Gameplay.md )

**Section 04: Implementation**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04Implementation.md )
