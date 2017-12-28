# Atari-Breakout76 GAME SCREEN ATARI PARTS

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Title Screen Atari Parts]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04-1TitleImplementation.md "Title Screen Atari Parts") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") | [Atari Test Screen . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README05TestScreen.md "Atari Test Screen") 

---

**GAME SCREEN ATARI PARTS**

**DEMO MODE**:

The game does have a kind of demo mode.  When there is no game in progress the paddle is replaced by a horizontal border and the ball continues to bounce between the borders and the bricks without destroying any bricks.  This implementation may enhance this to a self-played game where the ball is served and the computer plays without sound or score tracking.

**GAME SCREEN**:

The game screen scaled to the Atari's dimensions fits within the Atari's narrow playfield horizontal width.  Utilizing ANTIC's narrow width reduces the RAM requirements for graphics.

The screen entire visible playfield  will be 208 scan lines.  

**TOP BORDER**:

The game displays a visible Border at the top of the screen 8 scan lines thick.  Depending on the vertical border implementation the top border may need to cover the width of the bricks (97 color clocks), or the width of the bricks plus the vertical borders (97 + 4 color clocks = 101).

**Top Border As Map Graphics**: This is easy to do with ANTIC modes B, C, D or E which each support pixels one color clock wide.  (If this were an even number of color clocks then the mode 9 or mode A lower resolution modes could be used.)

Since multiple colors are not needed, the two-color modes, B or C, could be used.  Since the data displayed on each scan line is the same, and the number of scan lines is an even number, then this can be done using four lines of mode B graphics.  Each line would use LMS to redisplay the same data, so the entire top border line could be displayed using only 16 bytes of screen memory.

**Top Border as Player-Missile Graphics**: Player/Missile graphics could cover the same area.   Three Players set for quadruple width can cover 32 color clocks each, or 96 color clocks when lined up next to each other. The remaining color clock for the playfield, plus the four for the vertical borders could be covered by one more Player, or several Missiles.  The actual image of the border requires setting 4 or 8 bytes per player depending on Player/Missile resolution. If Player/Missile graphics are used for other components later on the display, then a Display List interrupt is needed to reset the sizes and reposition the objects' horizontal positions. 

**Top Border as Character Set**: Alternatively, the horizontal border could be drawn with custom character set graphics.  One line of mode 6 text is eight can lines tall.  It would take 16 bytes of memory to specify the line of text characters.  Three custom characters in the character set would be needed to correctly draw the left position of the border, the right end of the border, and then a full block character for everything between. 

**But That's Not All...**:  If this is all that needed to be considered then the ANTIC mode B graphics would be the easiest solution.  However, there is a real world display issue to consider in the next topic immediately below.....  

**EXTERNAL LABELS:**

The arcade game has painted labels on the glass over the display identifying the purpose of the numbers in the top row.  "PLAYER NUMBER" and "BALL IN PLAY". These real world labels will have to be worked into the game display to provide necessary information to the player.  

If the labels are inserted above or below the top border it will compromise the screen geometry.  Therefore, the labels must be rendered within the border area.  This is a visual change, but less intrusive than moving visual components to make space.  To maintain the main game screen appearance as consistently as possible the labels will only appear when there is a ball or player transition. When the game serves the ball the text would disappear leaving the top border a solid, blank barrier during game play.

There are too many letters to implement the text as Player/Missiles.  The labels could be drawn in the border area as graphics.  They could also be drawn in as custom characters in a font.  The decision on this will be explained in the next section.

**LEFT/RIGHT BORDERS**:

Left and Right Borders extend the entire height of the screen.  Each is two color clocks wide.

Drawn as pixels, the borders require building the entire display of contiguous lines of graphics.  Likewise, if custom characters are used it requires the entire game screen must be built of character set graphics.  

Player/Missile graphics can extend the height of the screen and go into the vertical overscan area.  It would require one Player or even just one Missile for each left and right border.  This would free the playfield for customization and variable graphics modes going down the screen.

**BALL**:

The Ball should be two scan lines tall per scale.  Rounding the width to one color clock makes the ball appear taller than wide which is the wrong effect.  Rounding to two color clocks makes the ball as wide as the vertical borders.  So, this is where compromise is needed.  The Ball may be reduced to only one color clock wide and one scan line tall to maintain the visual appearance.

If the Ball is implemented as a drawn, pixel object, then the entire display must be produced with contiguous lines of graphics to allow placing the ball consistently anywhere on the playfield.

If the Ball is implemented as a Player or Missile it may be positioned wherever needed on the screen without a contiguous graphics mode for the entire display.

**BRICKS**:

There are eight rows of 14 Bricks each determined to be 7 color clocks per brick -- six visible color clocks, and one blank to separate it from the next brick.  There are 4 scan lines per brick, three visible, and one blank to separate it from the next row.

Player/Missile graphics can't be used for bricks.  While they may be able to cover the distance across the screen the width setting necessary makes it impossible to represent the gap between bricks.

Custom characters are not optimal either.  Since character set graphics are 4 or 8 color clocks wide, then drawing and erasing 7 color clock bricks in series adds difficult bit shifting and merging into multiple characters.  Due to geometry character graphics provide no benefits to justify the work.

Bitmapped graphics would be best.  Since the bricks are three scan lines tall with one scan line of gap, the bricks will be drawn in one line of ANTIC Mode B graphics (two scan lines) and one line of ANTIC Mode C (one scan line) followed by one blank scan line.  The two graphics instructions will use the LMS option to display the same data.  

**PADDLE**:

The Paddle at its widest is the same width as a Brick -- 6 visible pixels (color clocks).  When the Paddle switches to narrow width it is about three pixels (color clocks) wide.  The Paddle is visibly thicker than the height of a brick -- four Atari scan lines tall.  The Paddle would likely be implemented as Player/Missile graphics.

When the game is over the Paddle is replaced by a solid horizontal Border the width of the screen.  This border acts as a giant Paddle during the game's demo mode keeping the ball rebounding up toward the Bricks.  The solid Border would be mapped graphics just like the Top Border.

**PLAYER, BALL COUNTER, and SCORES**:

The current Player Number, the Ball Counter, and the Scores appear in the blank area above the Bricks.  This blank area occupies vertical space approximately equal height to the region of the eight Brick rows on the screen.  (32 Atari scan lines)  The Ball travels through this area and straight through any of the numbers without being deflected.

These numbers are very large, tall objects on screen. The numbers and the vertical gap between numbers are the same width as a brick.  So, horizontally, the numbers including the space between them are 7 pixels/color clocks wide.  The height is simple -- 32 scan lines divided by 2 is 16 scan lines for each number which includes one blank scan line to vertically separate the numbers.

The size of a number without spacing is 6 color clocks wide by 15 scan lines tall.  This is actually very convenient.  The minimum grid size needed to display numbers is three horizontal blocks (or segments) by five vertical blocks.  This arrangment also appears to be the basis for Breakout game's number display.  Example number "8" in 3x5 segments:

- :black_medium_small_square::black_medium_small_square::black_medium_small_square:
- :black_medium_small_square::white_medium_small_square::black_medium_small_square:
- :black_medium_small_square::black_medium_small_square::black_medium_small_square:
- :black_medium_small_square::white_medium_small_square::black_medium_small_square:
- :black_medium_small_square::black_medium_small_square::black_medium_small_square:

In the Atari screen rendering the 3x5 segments divide neatly into the available screen geometry.  Each pixel in the example above corresponds to two pixels/color clocks wide, and three scan lines tall, thus a complete number following this pattern is 6 pixels by 15 scan lines which is the exact size available.

A text mode is the instinctive choice for rendering human readable information on screen.   However, the text characters in ANTIC Text Modes 6 and 7 are 8 color clocks wide, not the 7 needed.  This would complicate rendering the numbers across multiple characters.  It is easier to draw the characters on screen using graphics bitmaps.

**COLOR**:

The game is output only in black and white video.  However, colored plastic strips placed horizontally on the screen over the Bricks add "color" to the display.  Each pair of Brick rows is provided a different color.  From top to bottom: red, orange, green, yellow.   A blue plastic overlay is provided for the Paddle's row.  The picture below is the color representation from an emulator:

![Game Color Pixels](Breakout_cl_startup_crop_to_underscan.png?raw=true "Game Color Pixels")

Clearly, the emulator's color levels are highly saturated beyond reasonable.  Nobody viewing the arcade game in real-life would experience colors so deep.  The plastic strips merely provide a tint of color to the display.  So, again, this will require approximation and compromise.

The Atari cannot saturate color to this degree.  So, the goal is to realistically capture the same hue, not the intensity level. 

I captured the averaged color in each area from the color screen grab of the Breakout emulator game (above).  I then compared each Breakout color to the closest apparent equivalent in the Atari palette.  For the Atari palette I used an image grabbed from a program running in the Atari800 emulator which shows all the colors available to the Atari in one screen.  Atari800 is the same emulator being used to develop Breakout76, so the colors in the final result will match (in the emulator).

Between the GIMP eyedropper tool, a reference picture of the entire Atari pallette, and my eyeballs the final result is the best matching colors I can determine from the Atari's color palette: 

| Object     | Breakout RGB | Atari RGB  | Atari Palette |
| ---------- | ------------ | ---------- | ------------- |
| Borders    | cccccc       | c5c5c5     | $0C           |
| Paddle     | 026f9d       | 1b6ad8     | $96           |
| Red        | 94200f       | 5b161d     | $42           |
| Orange     | c28712       | bf6d04     | $28           |
| Green      | 0a8334       | 0e5b16     | $C4           |
| Yellow     | c1c23d       | b7c95c     | $1A           |

(**Notes from Capt Obvious**: Since the plastic overlay covers the width of the screen, the Borders are also colored at those row positions, and the Ball is colored when it passes through those rows.) 

Looking at the screen holistically leads to the conclusion that the game needs seven colors on the screen.  (background/black, white, the four brick colors, and the paddle.)  This is an incorrect point of view relative to the Atari's graphics capabilities.

GTIA pixel modes may be able to supply the necessary seven colors, but the GTIA pixel dimensions are too large to accommodate the smaller details such as the vertical gaps between bricks.

ANTIC text modes 4, 5, 6, and 7 allow five colors (including the background) -- nearly the seven colors needed.  Modes 5 and 7 character glyphs use pixel sizes that will not fit the brick dimensions, leaving only Modes 4, and 6 workable.  One line of either mode can accurately represent two lines of Bricks.  The Brick colors are applied in pairs of lines which conveniently fits these text mode geometries.  The default capabilities of these text modes provide four foreground colors, enough for the Bricks. However, this uses all the available playfield registers, so something else needs to be done about the white horizontal top border, and the blue horizontal bottom border displayed when the game is over.  In this case a couple of display list interrupts will be needed to re-use color registers twice on the screen.

A problem with using a character set is that the Brick width does not match the character width.  Therefore several custom characters will be required to represent bricks at different horizontal positions on the screen, and to represent bricks removed between other bricks.  And these characters must be defined separately for each color.  This is not unworkable, but it introduces an unpleasant degree of complexity.

Up to now it has looked like the preferred method to render the Bricks is direct pixel bitmapped graphics.  However, the best mode available allows only 3 playfield colors not including the background.  Character graphics are complicated and bitmaps do not provide enough color.  What to do?  

Observe the screen in detail.  Only one color is needed on any horizontal line.  Therefore the game does not need a graphics mode displaying all seven colors at a time.  It only needs one color register for display, and then the color effect would be implemented by multiple Display List Interrupts that change the color register parameters at different vertical locations on the screen.  The Display List Interrupts will change the Bricks, Borders, and Ball colors at the same time to appear convincing.  (And then also do the same lower on the screen to set the Paddle, Borders, and Ball colors.) 

Conceptually, the display list interrupts function similar to the plastic strips - they temporarily change the appearance of the only playfield color register at specific rows on the screen.

---

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Title Screen Atari Parts]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04-1TitleImplementation.md "Title Screen Atari Parts") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") | [Atari Test Screen . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README05TestScreen.md "Atari Test Screen") 
 
