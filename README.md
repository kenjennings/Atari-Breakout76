# Atari-Breakout76
Currently Work In Progress..

This is a Simple Breakout clone approximating the look and feel of the original arcade Breakout released by Atari in 1976.

This version uses only the Atari features necessary to achieve the correct look and behavior with as few extraneous bells and whistles as possible.

Or, you could just get an emulator to play the original game.

======================================================================================================

The real purpose of this is to create a modular framework for working on game projects that I can understand and sustain. (Your Mileage May Vary.)  

I had been in the middle of Breakout-GECE, and the debugging effort in that game required copying and pasting code from different places together into one workable test program.  This was making the code become very monolithic and it was becoming too complicated to keep everything organized.  Demands on my personal time had reduced development thinking to an hour in a week, and that wasn't even enough time to get my brain cells re-wrapped around the game details again.  

Therefore, the idea here is to force a more stringent modularization of the code and data, keeping components entirely separate, so when I need to look at a part of the game, I will know exactly which files and locations to find everything without having to remember what I am looking at.  The first victim of this strategy is to implement a reasonable immitation of the Breakout video game in its original condition.  There will be the fewest bells and whistles used to keep the visuals, sound, and behavior similar to the original.

======================================================================================================

;===============================================================================
; Breakout Arcade -- 1976
; Conceptualized by Nolan Bushnell and Steve Bristow.
; Built by Steve Wozniak.
; https://en.wikipedia.org/wiki/Breakout_(video_game)
;===============================================================================
; Ten thousand Breakout clones written
; by variable quality of programmers over
; the intervening 40 years....
;===============================================================================
; Here is yet another lame clone of Breakout 
; written by an idiot.....
;===============================================================================
; Breakout76 -- 2017
; Written by Ken Jennings
; Build for Atari using eclipse/wudsn/atasm on linux
; Source at:
; Github: https://github.com/kenjennings/Atari-Breakout76
; Google Drive: https://drive.google.com/drive/folders/
;===============================================================================

