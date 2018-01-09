# Atari-Breakout76 Choosing Atari Parts

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Gameplay]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README03Gameplay.md "Gameplay" ) | [. . . README . . .]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README" ) | [Title Screen Atari Parts . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04-1TitleImplementation.md "Title Screen Atari Parts" ) 

---

**IMPLEMENTATION**

The Atari is a highly flexible system and lends itself to creative thinking.  The playfield display is programmable allowing a game to easily mix graphics and text modes and blank lines at any vertical position of the screen without involving the CPU.  The memory for graphics and text on adjacent lines need not be contiguous.  

A desired visual affect can be achieved via multiple methods with pros and cons for each:  Screen objects could be drawn directly as graphics, as text using custom characters, or as Player-Missile graphics.  These choices depend on geometry, animation, and how well the intended solution fits the architecture of the display method.  A choice for one implementation method affects what is chosen for other areas on the screen.

The goal here is to maintain visual presentation and play action as similar as possible to the original arcade game as well as can be done by the Atari computer's capabilities.  Therefore, certain clever features of the Atari may not be the preferred choice if the result does not conform to the original game presentation.  

First, a short discussion on what is not the best use of Atari graphics...

**TO HI-RES OR NOT TO HI-RES**

Since the Breakout arcade game is a simple black and white display the initial impulse is to choose the Atari's high-resolution, "monochrome", mode F graphics.  (320 pixels per normal width line, 1/2 color clock for each pixel).  This turns out to be less visually accurate than using a lower resolution mode.

First, the high resolution graphics mode is not actually "monochrome".  It is a color mode, but it has restrictions on how it applies color to pixels.  This graphics mode provides a background color as a base, with "white" pixels in a different luminance of the base color.

Also, the display hardware is always generating a signal for NTSC with color information.  The graphics mode cannot produce a clean, plainly black and white display at its full resolution, because these high resolution pixels are half the size of a color clock, and the television interprets the 1/2 pixel signal as color information.  

Receiving half the color information in a color clock results in a color distortion effect on the NTSC television display called, "color artifacts".  A different color is presented in the first half of a color clock vs the second half of the color clock.  The television requires two high resolution pixels together to produce the complete information for a whole color clock.

**Sidebar:** Color artifacts is a concern common to any video hardware that generates pixels smaller than the color clock timing.  The degree and amount of color fringing depends on how well the pixel divides into the color clock, and how well the display hardware manages the signal per pixel.  8-bit systems typically have poor color precision at higher resolutions.  These visual behaviors evident on CRT displays are often NOT addressed by modern emulators on high resultion LCD monitors.  Emulators usually present impossibly perfect displays that do not occur in the real world on the original hardware.  Systems like the Atari, Amiga, Apple, etc. that evenly divide pixels into the color clock timing produce consistent color artifacts.  Other systems with oddly timed pixels that disregard the color clock standard produce color artifacts that vary depending on where the pixels occur on the screen (C64, NES, etc.) 

**Side-Sidebar:**  Useless trivia: The ECS and later hardware on the Amiga can generate 35ns pixels (1/8 of a color clock) with accurate control of the color of each pixel.  This allows the Amiga to display fine, smooth color transitions that appear to defy television display resolution limits.  Just one of several reasons why the Amiga dominated video production and titling niches.

The bottom line here is that high resolution pixels on a color NTSC display offer little advantage and plenty of visual defects. The other Atari graphics mode based on color-clock-sized pixels are preferrable.

---

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Gameplay]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README03Gameplay.md "Gameplay" ) | [. . . README . . .]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README" ) | [Title Screen Atari Parts . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04-1TitleImplementation.md "Title Screen Atari Parts" ) 
