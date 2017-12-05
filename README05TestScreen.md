# Atari-Breakout76 ATARI TEST SCREEN

**ATARI TEST SCREEN**

The test program, ![br76-test_screen.asm]( https://github.com/kenjennings/Atari-Breakout76/blob/master/br76-test_screen.asm "Test Program 1" ), builds a mock-up of the game screen using only pixels. (Every line is either ANTIC map mode B or C, where each displays pixels one color clock wide, and respectively, two scan lines, and one scan line tall).  The purpose is to verify the calculated size and placement of screen components is as correct as possible for the Atari screen v the original arcade aspect.  This is the result displayed in the Atari800 emulator:

![Test Screen](Breakout_bw_test_screen_cropped_with_border.png?raw=true "Test Screen")

GIMP is used to compare the mock-up to the Arcade original screen by blending the two screens together to see how well they overlay each other.  The screen grab of the Atari emulator is tinted blue, and then composited with the original (emulated) Breakout screen which is tinted red.  The arcade display is in the front and set to 50% transparency.  Where Atari pixels exist without a corresponding arcade pixel a dull blue(ish) shadow appears.  Conversely, red appears where arcade pixels exist without a matching Atari pixel.  Where both appear the pixels are lightest (a light lavender color).  Below is the result:

![Screen Comparison](Breakout_bw_test_screen_merge.png?raw=true "Screen Comparison")

**ASSESSMENT**

Looking pretty good overall.

The Atari screen is wider than the arcade Breakout by the width of approximately one brick, which divided between both halves of the screen is half a brick width extra at the vertical borders.  If the Atari bricks were one color clock smaller then the Atari's screen would be two bricks smaller than the arcade.  So, this demo program presents the best size possible.

The numbers all pretty well line up, though the Atari's are just a little thicker.

The arcade game's Bricks are just a little thicker and wider than the Atari's and the  horizontal and vertical gaps between the arcade game's Bricks are just a little smaller than the Atari's.  So, there is a red halo visible around the bricks, though the Bricks do occupy the same amount of total screen space on both versions.

The Paddle area on the Atari version is about one scan line lower than the arcade game's Paddle.  

**ADDING COLOR**

The second program, ![br76-test_screen_color.asm]( https://github.com/kenjennings/Atari-Breakout76/blob/master/br76-test_screen_color.asm "Test Program 2" ), adds to the original program by implementing display list interrupts to color the bricks and paddle line.  This requires assembly code for the display list interrupt.  The program also uses a vertical blank interrupt to force the display list interrupts to remain in sync with the screen.

In the arcade game there is only a black and white display and plastic overlays change the color at vertical rows on the screen tinting the lit, white pixels to another color.  It is mild irony that the display list interrupt is conceptually similar - this is only a two-color display on the Atari, and the display list interrupts execute at specific rows on the screen to change the color of the lit, white pixels temporarily to another color.  Here is the result:

![Test Screen Color](Breakout_cl_test_screen_cropped_with_border.png?raw=true "Test Screen Color")

**EXTERNAL LABELS**

The yellow text painted on the glass screen over the arcade game's display must be incorporated in the Atari Breakout76 game.  The best position is at in the top border.

The first problem is that the text won't fit on the screen.  "PLAYER NUMBER" and "BALL IN PLAY" occupy 25 characters on screen without any extra spaces.  The Border area rendered on screen is the same width as 24 Mode 4 text characters (plus one extra color clock).

The size problem can be accommodated by showing only one of the labels on screen at the time when that information is most relevant:
- When the player's turn begins then display the "PLAYER NUMBER" prompt for a few seconds.
- When the Ball Counter changes then display the "BALL IN PLAY" prompt for a few seconds.
- When the Ball is served and game play is in progress show only the top Border.

This solves the problem of too much text and not enough screen space.   How should the text be rendered?   

Mode 6 characters are 8 color clocks wide.  A full text character is 8x8 which is overkill and disproportionately large when comparing the painted letters on glass to the playfield screen.  The "PLAYER NUMBER" text won't even fit within the border width using this mode.  Also, the overly wide characters are an ill fit for a screen where other objects and the game aspect itself are very tall.

Mode 4 characters are 4 color clocks wide.  The text will fit, but four color clocks allow individual character to use only three color clocks for display and one as the blank space to separate characters.  This does not allow for good character definition.

The game needs very few characters (about twenty characters rather than the 128 in a complete font).  Rather than 1:1 mapping screen characters to font characters treat the font as a bitmap for graphics and render the text across multiple characters as they fit.  This allows rendering characters proportionally using as many (or as few) horizontal color clocks as needed for the text.  A good middle ground that provides acceptable definition while not growing too large horizontally is five or six color clocks per letter.  (Even less for a character like "I" or "E" that need not be full width.)  This font image treatment allows use of ANTIC Mode 6 text which also reduces the required font space to 64 characters rather than the usual 128 characters.

Since we've made it to the point of treating the text like a bitmap image, why not actually implement the labels straight up as bitmap images and dispense with the character set entirely?  The character set for mode 6 text requires 512 bytes dedicated to it.  Eight lines of ANTIC mode C bitmap graphics for a text label image requires 16 bytes per line or 128 bytes totoal.  Two sets of labels then need 256 bytes which is half the memory needed for a character set.  Also, any blank lines can be replaced by ANTIC blank line instructions eliminating the need for screen data representing blank lines, so the memory requirements for a couple text labels is less than half the memory that must be dedicated to a font.  



================ WIP
  The minimum grid for a usable character glyph is 3x5 pixels.  A happy medium will be used.  Stylistically, the first and last columns of pixels will be doubled.  The text will occupy six scan lines from the top of the font.  The center line (i.e "H, F, E, B, P, A" etc. horizontal bar) will be the third scan line.  The seventh line will be blank, and the 8th will be solid maintaining the bottom of the horizontal border. This will make characters about 6 pixels wide including the blank column to separate letters.  The characters will be rendered non-proportionally, so rather than "P", "L", "A", "Y" glyphs in the characters "P", L", "A" and "Y" respectively, the glyphs will be written into several sequential custom characters placed as a group.. (e.g. the characters "RST" would contain the images for "PLAY".) 
=============== WIP


**SIDEBAR: Irrelevant Minutia** 

The first test program, br76-test_screen.asm, actually executes only one assembly language instruction; a JMP instruction as an infinite loop to prevent the program from returning imediately to the DOS menu.  Everything else about the program capitalizes on the Atari's structured, executable load file format.  The Display List and the screen data are loaded directly into defined locations in memory.  The same mechanism is used to update the Operating System shadow registers for the ANTIC controls for display width and Display List address, as well as the Shadow register for the color.   

If I recall correctly (and I may not), Mac/65 would keep the disk load segments in the order in which they are encountered in the code.  Therefore loads could be defined within the main program loading allowing the load file to set up graphics at specific points during the load.

But, it appears atasm optimizes load file segments by sorting and consolidating address changes into related groups.  Because of this it is remotely possible that register changes setting the display occur out of sync with frame/VBI updates.  This has the potential to cause ANTIC to begin using different memory values for a Display List before the actual Display list loads into memory resulting in a trashed display.  This also has the remote possibility of crashing the Atari.

Use with caution.  Your Mileage Will Definitely Vary.

Therefore, when building with atasm maximum effectiveness of the disk load feature to enable Title screens, animation, music, etc. during program load time requires separate builds of the parts and concatenating the programs together. 

=============================================================================

**PREVIOUS Section 04-2: Game Screen Atari Parts**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04-2GameImplementation.md )


**NEXT Section 06: Game Screen**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README06GameScreen.md )

=============================================================================

**Back To Beginning**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md )
