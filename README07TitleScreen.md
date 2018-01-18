# Atari-Breakout76 Title Screen

**PREVIOUS SECTION** | **Back To START** 
:--- | :---: 
[:arrow_left: . . . Game Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README06GameScreen.md "Game Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") 
 
---

**TITLE SCREEN**

I am so tempted to embellish this to stupid extremes, but that is the intention for Breakout-GECE.  (Control!  You must learn control!  -Yoda)

The Title Screen is just a simple place to park for managing simple configuration settings, and provide a tolerably minimum amount of credits and directions.

A reasonably simple display list.  Just a title line in Mode 7.  Prompts in Mode 6.

The title "B R E A K O U T" will be written in the four game colors.  (Yellow, green, orange, red.)   The colors will rotate twice per second to animate the display.

Prompts/directions:

- USE PADDLE OR BUTTONS
- OPTION CHOOSES TOPIC
- SELECT CHOOSES VALUE
- START TO BEGIN GAME

Prompts/Input need different colors from the title.

- The titles of keys "OPTION", "SELECT", and "START" needs designated light orange color.
- Other text is darker orange.
- Selectable values not chosen are grey.
- Current value is hilighted white.

Paddle input is also allowed for the options.  The heirarchical menu will be flattened into a list where rotation of the paddle will focus on each item in the list.   The Paddle button will select the option (and turn off any other mutually exclusive option that was already on.  The first and last options on the list will indicate start the game allowing the paddle triugger to begin the game.

No custom character set.

The screen needs a couple interrupts for management.  The Vertical Blank Interrupt will manage the title animation (color cycling).  A Display List interrupt will switch colors between the title area, and the user interface area.

---

**PREVIOUS SECTION** | **Back To START** 
:--- | :---: 
[:arrow_left: . . . Game Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README06GameScreen.md "Game Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") 
 
