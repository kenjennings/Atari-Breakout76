# Atari-Breakout76 IMPLEMENTATION

**IMPLEMENTATION**

The Atari is a highly flexible system and lends itself to creative thinking.  The playfield display is completely programmable allowing a game to mix graphics and text modes and blank lines at any vertical position of the screen.  Graphics and text on adjacent lines need not be contiguous in memory.  

A desired visual affect can be achieved via multiple methods with pros and cons for each:  Screen objects could be drawn directly as graphics, as text using custom characters, or as Player-Missile graphics depending on geometry, animation, and how well the intended solution fits the architecture of the display method.  A choice for one implementation method can affect what is chosen for other areas on the screen.  

**TITLE SCREEN**:

The Breakout arcade game does not have a title screen.  The "splash screen" or title graphics are the box cabinet.  The number of players, and game initiation are managed with buttons.

However, the Atari computer immitation of Breakout can add some configurability to game parameters. This needs a minimal user interface and directions in place of the arcade button controls and should appear separately from the main game screen. 

**GAME SCREEN**:

The game screen scaled to the Atari's dimensions fit within the horizontal width for ANTIC's narrow playfield.  The game screen can utilize ANTIC's narrow width, reducing the RAM requirements where pixel graphics are needed.

The screen entire visible playfield  will be 208 scan lines.  

**TOP BORDER**:

The game displays a visible Border at the top of the screen 8 scan lines thick.  Depending on the vertical border implementation the top border may need to cover the width of the bricks (97 color clocks), or the width of the bricks plus the vertical borders (97 + 4 color clocks = 101).

This is easy to do with ANTIC modes B, C, D or E which each support pixels one color clock wide.  (If this were an even number of color clocks then the mode 9 or mode A lower resolution modes could be used.)  

Since multiple colors are not needed, the two-color modes, B or C, could be used.  Since the data displayed on each scan line is the same, and the number of scan lines is an even number, then this can be done using four lines of mode B graphics.  Each line would use LMS to redisplay the same data, so the entire top border line could be displayed using only 16 bytes of screen memory.

Player/Missile graphics could cover the same area.   Three Players set for quadrouple width can cover 32 color clocks each, or 96 color clocks when lined up next to each other. The remaining color clock for the playfield, plus the four for the vertical borders could be covered by one more Player, or several Missiles.  The border would require setting 4 or 8 bytes per player depending on Player/Missile resolution. If Player/Missile graphics are used for other components later on the display, then a Display List interrupt is needed to reset the sizes and reposition the objects' horizontal positions. 

Alternatively, the horizontal border could be drawn with custom character set graphics.  One line of mode 6 text is eight can lines tall.  It would take 16 bytes of memory to specify the line of text characters.  Three custom characters in the character set would be needed to correctly draw the left position of the border, the right end of the border, and then a full block character for everything between. 

**LEFT/RIGHT BORDERS**:

Left and Right Borders extend the entire height of the screen.  Each is two color clocks wide.

Drawn as pixels, the borders require building the entire display of contiguous lines of graphics.  Likewise, if custom characters are used it requires the entire game screen must be character set graphics.  

Player/Missile graphics can extend the height of the screen and go into the vertical overscan area.  It would require one Player or even just a Missile for each left and right border.  This would free the playfield for customization and variable graphics modes going down the screen.

**BALL**:

Rounding to one color clock makes the ball appear taller than wide which is the wrong effect.  Rounding to two color clocks makes the ball as wide as the vertical borders.  So, this is where compromise is needed.  The Ball may be reduced to only one color clock wide and one scan line tall to maintain the visual appearance.

If the Ball is implemented as a drawn, pixel object, then the entire display must be produced with contiguous lines of graphics, so the ball can be consistently positioned anywhere on the plafield.

If the Ball is implemented as a Player or Missile it may be positioned wherever needed on the screen without a contiguous graphics mode for the entire display.

**BRICKS**:

There are eight rows of 14 Bricks each determined to be 7 color clocks per brick -- six visible color clocks, and one blank to separate it from the next brick.  There are 4 scan lines per brick, three visible, and one blank to separate it from the next row.

Player/Missile graphics can't be used for bricks.  While they may be able to cover the distance across the screen the width setting necessary makes it impossible to represent the gap between bricks.

Custom characters are not optimal either.  As character set graphics are 4 or 8 color clocks wide, s are 

**PADDLE**:

The Paddle at its widest is the same width as a Brick -- 7 visible pixels (color clocks).  When the Paddle switches to narrow width it is about four pixels (color clocks) wide, or only twice the width of the Ball.  The Paddle is visibly thicker then the height of a brick -- definitively three pixels (six scan lines) tall.  When the game is over the Paddle is replaced by a solid horizontal Border the width of the screen.  This border acts as a giant Paddle during the game's demo mode keeping the ball rebounding up toward the Bricks.  The Paddle would likely be implemented as Player/Missile graphics.  The solid Border would be mapped graphics.  

**PLAYER, BALL COUNTER, and SCORES**:

The current Player number, the Ball Counter, and the Scores appear in the blank area above the Bricks.  This blank area occupies vertical space approximately equal height to the region of the eight Brick rows on the screen.  The Ball travels through this area and straight through any of the numbers without being deflected.

These numbers are very large, tall objects on screen. The numbers and the space between them are the same width as a brick.  So, horizontally, the numbers including the space between them are 8 pixels/color clocks wide.  The height approaches 10 pixels (or 20 scan lines) tall which is taller than any font on the Atari.  ANTIC Mode 7 text is the nearest match at 16 scan lines tall.  The loss of a few scan lines should be acceptable with a custom font modeled after the appearance of the arcade Breakout numbers.  Alternatively, the score could be drawn as graphics.

Note that in the arcade game there are labels painted in yellow on the glass over the display indicating which value is the Player number, and the Ball Counter.  This should be duplicated in the game as graphics/text on the screen to meaningfully label the numbers. 

**COLOR**:

The game is output only in black and white video.  However, colored plastic strips placed horizontally on the screen over the Bricks add "color" to the display.  Each pair of Brick rows is provided a different color.  From top to bottom: red, orange, green, yellow.   A blue plastic overlay is provided for the Paddle's row.  The picture below is the color representation from an emulator:

![Game Color Pixels](Breakoput_cl_startup_crop_to_underscan.png?raw=true "Game Color Pixels")

I captured the averaged color in each area from the color screen grab of the Breakout emulator game (above).  I then compared each Breakout color to the closest apparent matching RGB equivalent in the Atari palette.  (Using the GIMP eyedropper tool, a reference picture grabbed from an Atari emulator of the entire pallette, and my eyeballs.)  The final result is the best matching color from the  Atari's 128 color palette: 

| Object     | Breakout RGB | Atari RGB  | Atari Palette |
| ---------- | ------------ | ---------- | ------------- |
| Borders    | cccccc       | c5c5c5     | $0C           |
| Paddle     | 026f9d       | 1b6ad8     | $96           |
| Red        | 94200f       | 931302     | $34           |
| Orange     | c28712       | bf6d04     | $28           |
| Green      | 0a8334       | 006b25     | $B4           |
| Yellow     | c1c23d       | bfb200     | $FA           |

(Notes from Capt Obvious: Since the plastic overlay covers the width of the screen, the Borders are also colored at those row positions, and the Ball is colored when it passes through those rows.)  

The color effect would be duplicated by a set of Display List Interrupts that change the color register parameters at different vertical locations on the screen.  To be convincing it will need to change the Bricks, Borders, and Ball colors at the same time.  (and lower on the screen set the Paddle, Borders, and Ball color.)

