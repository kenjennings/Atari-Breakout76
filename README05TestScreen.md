# Atari-Breakout76 TEST SCREEN

**TEST SCREEN**

The test program, br76-test_screen.asm, builds a mock-up of the game screen using only pixels. (Every line is either ANTIC map mode B or C, where each displays pixels one color clock wide, and respectively, two scan lines, and one scan line tall).  The purpose is to verify the calculated size and placement of screen components is as correct as possible for the Atari screen v the original arcade aspect.  This is the result displayed in the Atari800 emulator:

![Test Screen](Breakout_bw_test_screen_cropped_with_border.png?raw=true "Test Screen")

GIMP is used to compare the mock-up to the Arcade original screen by blending the two screens together to see how well they overlay each other.  The screen grab of the Atari emulator is tinted blue, and then composited with the original (emulated) Breakout screen which is tinted red.  The arcade display is in the front and set to 50% transparency.  Where Atari pixels exist without a corresponding arcade pixel a dull blue(ish) shadow appears.  Conversely, red appears where arcade pixels exist without a matching Atari pixel.  Where both appear the pixels are lightest (a light lavender color).  Below is the result:

![Screen Comparison](Breakout_bw_test_screen_merge.png?raw=true "Screen Comparison")

**ASSESSMENT**

Looking pretty good overall....

**ADDING COLOR**

The second program, br76-test_screen_color.asm, adds to the original program by implementing display list interrupts to color the bricks and paddle line.  This requires assembly code for the display list interrupt.  The program also uses a vertical blank interrupt to force the display list interrupts to remain in sync with the screen.

In the arcade game there is only a black and white display and plastic overlays change the color at vertical rows on the screen tinting the lit, white pixels to another color.  It is mild irony that the display list interrupt is conceptually similar - this is only a two-color display on the Atari, and the display list interrupts execute at specific rows on the screen to change the color of the lit, white pixels temporarily to another color.  Here is the result:

![Test Screen Color](Breakout_cl_test_screen_cropped_with_border.png?raw=true "Test Screen Color")

**SIDEBAR:** The first test program, br76-test_screen.asm, actually executes only one assembly language instruction; a JMP instruction as an infinite loop to prevent the program from returning imediately to the DOS menu.  Everything else about the program capitalizes on the Atari's structured, executable load file format.  The Display List and the screen data are loaded directly into defined locations in memory.  The same mechanism is used to update the Operating System shadow registers for the ANTIC controls for display width and Display List address, as well as the Shadow register for the color.   

If I recall correctly (and I may not), Mac/65 would keep the disk load segments in the order in which they are encountered in the code.  Therefore loads could be defined within the main program loading allowing the load file to set up graphics at specific points during the load.

But, it appears atasm optimizes load file segments by sorting and consolidating address changes into related groups.  Because of this it is remotely possible that register changes setting the display occur out of sync with frame/VBI updates.  This has the potential to cause ANTIC to begin using different memory values for a Display List before the actual Display list loads into memory resulting in a trashed display.  This also has the remote possibility of crashing the Atari.

Use with caution.  Your Mileage Will Definitely Vary.

Therefore, when building with atasm maximum effectiveness of the disk load feature to enable Title screens, animation, music, etc. during program load time requires separate builds of the parts and concatenating the programs together. 

=============================================================================

**PREVIOUS Section 04: Implementation**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04Implementation.md )


**NEXT Section 06: Game Screen**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README06GameScreen.md )

=============================================================================

**Back To Beginning**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md )
