# Atari-Breakout76 IMPLEMENTATION

**IMPLEMENTATION**

The Atari is a highly flexible system and lends itself to creative thinking.  The playfield display is completely programmable allowing a game to easily mix graphics and text modes and blank lines at any vertical position of the screen.  Graphics and text on adjacent lines need not be contiguous in memory.  

A desired visual affect can be achieved via multiple methods with pros and cons for each:  Screen objects could be drawn directly as graphics, as text using custom characters, or as Player-Missile graphics.  These choices depend on geometry, animation, and how well the intended solution fits the architecture of the display method.  A choice for one implementation method can affect what is chosen for other areas on the screen.

The overarching goal here is to maintain visual presentation and play action as similar as possible to the original arcade game as well as can be done by the Atari computer's capabilities.  Therefore, certain clever features of the Atari may not be the preferred choice if the result does not conform to the original game presentation.  

First, a short discussion on what is not the best use of Atari graphics...

**TO HI-RES OR NOT TO HI-RES**

Since the Breakout arcade game is a simple black and white display the initial impulse is to choose the Atari's high-resolution, "monochrome", mode F graphics.  (320 pixels per normal width line, 1/2 color clock for each pixel).  This turns out to be less visually accurate than using a lower resolution mode.

First, the high resolution graphics mode is not actually "monochrome".  It is a color mode, but it has restrictions on how colors are chosen, and how color applies to its pixels.  This graphics mode provides a background color as a base, with "white" pixels in a different luminance of the same base color.

Also, the display hardware is generating a signal for NTSC with color information.  The graphics mode cannot produce a clean, plainly black and white display at its full resolution, because these high resolution pixels are half the size of a color clock, and the television interprets the pixel presentation as color information.  The NTSC television displays a different color for pixels presented in the first half of a color clock vs the second half in an effect called "color artifacts".  Two high resolution pixels together produce the complete information for a "white" color clock, but there will still be some small degree of color fringing before and after the paired pixels in the color clock.  

**Sidebar:** Color artifacts at resolutions greater than the television color clock is actually a concern and visual defect common to all systems which generate pixels smaller than the color clock timing.  The degree and amount of color fringing depends on how well the pixel divides into the color clock.  These visual behaviors seen on CRT displays are often NOT addressed by modern emulators on high resultion LCD monitors.  Emulators usually present unreasonably perfect displays that do not occur in the real world of the original hardware.  Systems like the Atari, Amiga, Apple, etc. that evenly divide pixels into the color clock timing produce consistent color artifacts.  Other systems with oddly timed pixels that disregard the color clock standard produce color artifacts that vary depending on where the pixels occur on the screen (C64, NES, etc.)

=============================================================================

**PREVIOUS Section 03: Gameplay**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README03Gameplay.md )

**NEXT Section 04-1: Title Screen Iplementation**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04-1TitleImplementation.md )

=============================================================================

**Back To Beginning**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md )
