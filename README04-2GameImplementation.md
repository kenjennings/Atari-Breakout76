# Atari-Breakout76 GAME SCREEN ATARI PARTS

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Title Screen Atari Parts]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04-1TitleImplementation.md "Title Screen Atari Parts") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") | [Atari Test Screen . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README05TestScreen.md "Atari Test Screen") 

---

**GAME SCREEN ATARI PARTS**

**DEMO/ATTRACT MODE**:

When there is no game in progress the paddle is replaced by a horizontal border and the ball continues to bounce between the borders and the bricks without destroying any bricks.  There is no sound during the attract mode.

**GAME SCREEN**:

Initial estimate is the visible playfield would be 208 scan lines tall. **UPDATE**: Stats collected from owners of real CRTs indicate the majority of displays are capable of showing at least 216 scan lines intact. Therefore the screen will be defined as **216** lines.  This will slightly improve the vertical/horizontal aspect ratio to be closer to the original arcade.

The game screen scaled to the Atari's dimensions fits within the Atari's narrow playfield horizontal width (128 color clocks).  Utilizing ANTIC's narrow width reduces the RAM requirements for graphics.

**TOP BORDER**:

The game displays a visible Border at the top of the screen 8 scan lines thick.  Depending on the vertical Border implementation the top border may need to cover the width of the Bricks (97 color clocks), or up to the width of the Bricks plus the vertical Borders (97 + 4 color clocks = 101).

**Top Border as Player-Missile Graphics**: Player/Missile graphics could cover the same area.   Three Players set for quadruple width can cover 32 color clocks each, or 96 color clocks when lined up next to each other. The remaining color clock for the playfield, plus the four for the vertical borders could be covered by one more Player, or several Missiles.  The actual image of the border requires setting 4 or 8 bytes per player depending on Player/Missile resolution. If Player/Missile graphics are used for other components later on the display, then a Display List interrupt is needed to reset the sizes and reposition the objects' horizontal positions. 

**Top Border as Character Set**: Alternatively, the horizontal border could be drawn with custom character set graphics.  One line of mode 6 text is eight can lines tall.  It would take 16 bytes of memory to specify the line of text characters.  Three custom characters in the character set would be needed to correctly draw the left position of the border, the right end of the border, and then a full block character for everything between. 

**Top Border As Map Graphics**: This needs the ability to draw horizontal lines that can be stacked to 8 scan lines tall.  This is easy with ANTIC map modes 8 through E.  The requirement is fitting within the horizontal limits of 97 to 101 color clocks, and aligning to the proper start/end positions on screen. 

Since multiple colors are not needed, the multi-color modes 8, A, D, and E are overkill.  This leaves the two-color modes, 9, B, and C.  All three can fit within the line position parameters.  All three are evenly divisible into the 8 scan lines needed for the border.  Therefore mode 9 with the lowest memory requirements will be used.  Mode 9 specifications for reference:  

Pixels Per Mode Line (narrow/normal/wide)	| TV Scan Lines per Mode Line	| Bytes per Mode Line (narrow/normal/wide)	| Bits per Pixel	| Colors	| Color Clocks per Pixel
--- |	---	| ---	| ---	| --- |	---
64/80/96 |	4	| 8/10/12	| 1	| 2 |	2

Since the data displayed on each scan line is the same, then this can be done using just 2 lines of mode 9 graphics.  Each line would use LMS to redisplay the same data, so the entire top border line could be displayed using only 8 bytes of screen memory.

**But That's Not All...**:  More consideration is needed in the Top Border.  The next section explains the issue of incorporating the arcade game's external labels into the Top Border region on screen.....  

**EXTERNAL LABELS:**

The arcade game has painted labels on the glass over the display identifying the purpose of the numbers in the top row.  "PLAYER NUMBER" and "BALL IN PLAY". These real world labels will be worked into the game display to provide necessary information to the player.

The labels will compromise the screen geometry if inserted above or below the top border.  Therefore, they must be rendered within the Border area.  This is a visual change, but less intrusive than moving visual components to make space.  To maintain the main game screen appearance as consistently as possible the labels will only appear when there is a ball or player transition.  When the game serves the ball the text would disappear leaving the Top Border a solid, blank barrier during game play.

There are too many letters to implement the text as Player/Missiles.  The labels could be drawn as custom characters in a font.  They could also be drawn in the Border area as graphics.  The next page, [Atari Test Screen]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README05TestScreen.md "Atari Test Screen"), explains the decision to use bitmapped graphics rather than a custom font.

**LEFT/RIGHT BORDERS**:

Left and Right Borders extend the entire height of the screen.  Each is two color clocks wide.

Drawn as pixels, the borders require building the entire display of contiguous lines of graphics.  Likewise, if custom characters are used it requires the entire game screen must be built of character set graphics.  

Player/Missile graphics can be the height of the screen and conveniently extend into the vertical overscan area.  One Missile object will be used as the left Border and one Missile for the Right Border.  This frees the playfield for customization and variable graphics modes going down the screen.

**BALL**:

The Ball should be two scan lines tall per scale.  Rounding the width to one color clock makes the ball appear taller than wide which is the wrong effect.  Rounding to two color clocks makes the ball as wide as the vertical borders.  So, this is where compromise is needed.  The Ball may be reduced to only one color clock wide and one scan line tall to maintain the visual appearance.

If the Ball is implemented as a drawn, pixel object, then the entire display must be produced with contiguous lines of graphics to allow placing the ball consistently anywhere on the playfield.

The Ball will be implemented as a Player or Missile, since it can be positioned wherever needed on the screen without a contiguous graphics mode for the entire display.

**BRICKS**:

There are eight rows of 14 Bricks each determined to be 7 color clocks per brick -- six visible color clocks, and one blank to separate it from the next brick.  There are 4 scan lines per brick, three visible, and one blank to separate it from the next row.

Player/Missile graphics can't be used for bricks.  While Player/Missile objects at maximum width may be able to cover the distance across the screen the width setting necessary makes it impossible to represent the gap between bricks.

Custom characters are not optimal either.  Since character set graphics are 4 or 8 color clocks wide, then drawing and erasing 7 color clock bricks in series adds difficult bit shifting and merging into multiple characters.  Due to geometry character graphics provide no benefits to justify the work.

Bitmapped graphics would be best.  Since the bricks are three scan lines tall with one scan line of gap, the bricks will be drawn in one line of ANTIC Mode B graphics (two scan lines) and one line of ANTIC Mode C (one scan line) followed by one blank scan line.  The two graphics instructions will use the LMS option to display the same data.  

**PADDLE**:

The Paddle at its widest is the same width as a Brick -- 6 visible pixels (color clocks).  When the Paddle switches to narrow width it is about three pixels (color clocks) wide.  The Paddle is visibly thicker than the height of a brick -- four Atari scan lines tall.  The Paddle will be implemented as a Player.

When the game is over a solid horizontal Border the width of the screen replaces the Paddle.  This border acts as a giant Paddle during the game's demo/attract mode keeping the ball rebounding up toward the Bricks.  The solid Border will be the same mapped graphics as the Top Border.

**PLAYER, BALL COUNTER, and SCORES**:

The current Player Number, the Ball Counter, and the Scores appear in the blank area above the Bricks.  This blank area occupies vertical space approximately equal height to the region of the eight Brick rows on the screen.  (32 Atari scan lines)  The Ball travels through this area and straight through any of the numbers without being deflected.

These numbers are very large, tall objects on screen. The numbers and the vertical gap between numbers are the same width as a brick.  So, horizontally, the numbers including the space between them are 7 pixels/color clocks wide.  The height is simple -- 32 scan lines divided by 2 is 16 scan lines for each number which includes one blank scan line to vertically separate the numbers.

The size of a number without spacing is 6 color clocks wide by 15 scan lines tall.  This dimensions are actually very convenient.  The minimum grid size needed to display numbers is three horizontal blocks (or segments) by five vertical blocks.  This arrangement also appears to be the basis for the real Breakout arcade game's number display.  Example number "9" in 3x5 segments:

- :black_medium_small_square::black_medium_small_square::black_medium_small_square:
- :black_medium_small_square::white_medium_small_square::black_medium_small_square:
- :black_medium_small_square::black_medium_small_square::black_medium_small_square:
- :white_medium_small_square::white_medium_small_square::black_medium_small_square:
- :white_medium_small_square::white_medium_small_square::black_medium_small_square:

Rendering the 3x5 segments neatly divides into the Atari's screen geometry for the number area. Each pixel in the example above corresponds to two pixels/color clocks wide, and three scan lines tall, thus a complete number following this pattern is 6 pixels by 15 scan lines which is the exact size available.

A text mode is the instinctive choice for rendering human-readable information on screen.   However, the text characters in ANTIC Text Modes 6 and 7 are 8 color clocks wide, not the 7 needed.  This would complicate rendering the numbers across multiple characters.  It is easier to draw the characters on screen using graphics bitmaps.

**COLOR**:

The arcade game is output only in black and white video.  However, colored plastic strips placed horizontally on the screen over the Bricks add "color" to the display.  Each pair of Brick rows is provided a different color.  From top to bottom: red, orange, green, yellow. A blue plastic overlay is provided for the Paddle's row. The picture below is the color representation from an emulator:

![Game Color Pixels](Breakout_cl_startup_crop_to_underscan.png?raw=true "Game Color Pixels")

Clearly, the emulator's color levels are highly saturated beyond reasonable.  Nobody viewing the arcade game in real-life would experience colors so deep.  The plastic strips merely provide a tint of color to the display.  So, again, this will require approximation and compromise.

NTSC cannot saturate color to this degree.  So, the goal is to realistically capture the same hue, not the intensity level. 

I captured the averaged color in each area from the color screen grab of the Breakout emulator game (above).  I then compared each Breakout color to the closest apparent equivalent in the Atari palette.  For the Atari palette I used an image grabbed from a program running in the Atari800 emulator which shows all the Atari's colors on one screen.  Atari800 is the same emulator being used to develop Breakout76, so the colors in the final game will match the test.  (Matching colors for NTSC in general has all of the precision of cat herding, but at least it will match in the emulator.)

Between the GIMP eyedropper tool, a reference picture of the entire Atari pallette, and my eyeballs the final result is the best matching colors I can determine from the Atari's color palette: 

Object | Breakout RGB | Atari RGB  | Atari Palette 
--- | --- | --- | --- 
Borders    | cccccc       | c5c5c5     | $0C           
Paddle     | 026f9d       | 1b6ad8     | $96           
Red        | 94200f       | 5b161d     | $42           
Orange     | c28712       | bf6d04     | $28           
Green      | 0a8334       | 0e5b16     | $C4           
Yellow     | c1c23d       | b7c95c     | $1A           

(**Notes from Capt Obvious**: Since the plastic overlay covers the width of the screen, the Borders are also colored at those row positions, and the Ball is colored when it passes through those rows.) 

Looking at the screen holistically leads to the conclusion that the game needs seven colors on the screen.  (background/black, white, the four brick colors, and the paddle.)  This is an incorrect point of view relative to the Atari's graphics capabilities.

GTIA color interpretation modes may be able to supply the necessary seven colors, but the GTIA pixel dimensions are too large to accommodate the smaller details such as the vertical gaps between bricks.

ANTIC text modes 4, 5, 6, and 7 allow five colors (including the background) -- nearly the seven colors needed.  Modes 5 and 7 character glyphs use pixel sizes that will not fit the brick dimensions, leaving only Modes 4, and 6 workable.  One line of either mode can accurately represent two lines of Bricks.  The Brick colors are applied in pairs of lines which conveniently fits these text mode geometries.  The default capabilities of these text modes provide four foreground colors, enough for the Bricks. However, this uses all the available playfield registers, so something else needs to be done about the white horizontal top border, and the blue horizontal bottom border displayed when the game is over.  In this case a couple of Display List Interrupts would re-use color registers twice on the screen.

However, a problem with using a character set is that the Brick width does not match the character width.  Therefore several custom characters will be required to represent bricks at different horizontal positions on the screen, and to represent bricks removed between other bricks.  And these characters must be defined separately for each color.  This is not unworkable, but it introduces an unpleasant degree of complexity.

Up to now it has looked like the preferred method to render the Bricks is direct pixel bitmapped graphics.  However, the best mode available allows only 3 playfield colors not including the background.  Character graphics are complicated and bitmaps do not provide enough color.  What to do?  

Observe the screen in detail.  Only one color is needed on any horizontal line.  Therefore the game does not need a graphics mode displaying all seven colors at a time.  It only needs one color register for display, and then the color effect would be implemented by multiple Display List Interrupts that change the color register parameters at different vertical locations on the screen.  The Display List Interrupts will change the Bricks, Borders, and Ball colors at the same time to appear convincing.  (And then also do the same lower on the screen to set the Paddle, Borders, and Ball colors.) 

Conceptually, the Display List Interrupts function similar to the plastic strips - they temporarily change the appearance of the  playfield color  at specific rows on the screen.

---

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Title Screen Atari Parts]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04-1TitleImplementation.md "Title Screen Atari Parts") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") | [Atari Test Screen . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README05TestScreen.md "Atari Test Screen") 
 
