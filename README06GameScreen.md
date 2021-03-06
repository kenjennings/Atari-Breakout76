# Atari-Breakout76 Game Screen Details

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Test Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README05TestScreen.md "Test Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") | [Title Screen . . . :arrow_right:](https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md "Title Screen") 
 
---

**GAME SCREEN DETAILS**

**Player/Missile Graphics**

Single Line resolution Player/Missile Graphics.

Player/Missile highest priority above (on top of) Playfield.

Fifth Player grouping Missiles into another Player will not be used.

Priority value  ~0001 will be used for the game placing all Player/Missile colors above the Playfield colors.

Player/Missile | Use                | Color 
---            | ---                | ---
Player 0       | Ball               | COLPM0 is White/$0C
Missile 0      | Left Border        | COLPM0 is White/$0C
Player 1       | Paddle             | COLPM1 is White/$0C, Paddle is Blue/$96
Missile 1      | Right Border       | COLPM1 is White/$0C
Player 2       | First Number Mask  | COLPM2 is Black/$00
Player 3       | Second Number Mask | COLPM3 is Black/$00

Single Line Resolution Player/Missile graphics requires allocating 2K of contiguous memory, aligned to a 2K boundary.

Reserving memory for Player/Missile graphics automatically provides memory useful for other purposes, since the Player/Missile memory map leaves the first 3 pages (768 byte) unused.  This can be used for screen memory or the display list.

The game requires the bitmaps for Missiles and all four Players.  However, the entire bitmap is needed for only the Missiles (Left and Right Borders) and Player 0 (Ball).  Players 1, 2, 3 have limited vertical placement (Paddle, Text mask 1, Text Mask 2). If the horizontal positions of these objects is changed offscreen when there is no data to display, then that portion of the Players' bitmap is free for other purposes.  For this game, the unused parts of the bitmaps for these Players will hold 

---

**Screen Memory**

The game screen will be defined as 216 scan lines tall.  (Equivalent to 27 lines of ANTIC Mode 2 text).

Playfield | Use | Color
--- | --- | ---
Playfield 0 | Numbers, Bricks, Top/Bottom Borders | COLPF0 is White/$0C
Playfield 0 | External Labels (Top Border) | COLPF0 is Yellow/$1A 

Top Border and Bottom border use two lines of ANTIC mode 9 and COLPF0 for color.  External Label Text, Numbers/Scores, and Bricks use ANTIC Modes B and C graphics and COLPF0.

In ANTIC's narrow playfield width bitmapped graphics Mode 8 requires 8 bytes per line.  The following screen memory resources are referenced by the Display List documented below:
- 1 BORDER_LINE (solid horizontal line for border)

In ANTIC's narrow playfield width bitmapped graphics Modes B and C require 16 bytes per line.  The following screen memory resources are referenced by the Display List documented below:
- 7 LABEL_PLAYER_LINE (draw the external label for "Player Number")
- 7 LABEL_BALL_LINE (draw the external label for "Ball In Play")
- 5 PLAYER_AND_BALL_LINE (number "segments" drawn for Player Number and Ball In Play)
- 5 SCORES_LINE (number "segments" drawn for player scores.)
- 8 BRICKS_LINE (rows of bricks displayed on screen)

Total screen memory needed is 1 line * 8 bytes, plus 32 lines * 16 bytes which is 520 bytes.

Creating this display on typical computers of the 8-bit era would require dedicating a contiguous block of memory providing the bitmap display on every display line.  Assuming a system had the same kind of resolution/color as the Atari graphics Modes the display requires 16 bytes times 208 scan lines, 3,328 bytes.  More likely 20 bytes per line, or 4,160 bytes for the full screen.

A fun part of the Atari is the display programmability.  Graphics memory is needed only where graphics are displayed.  Screen memory need not be contiguous and can be addressed beginning almost anywhere in memory for any line.  The only limitation is that a line of graphics cannot cross over a 4K boundary in the middle of a line -- an easy thing to avoid.  Since the Atari can dedicate only the memory it needs to generate the display this works out to only the 520 bytes reported above.  About half of this is for the bitmaps supporting the external text labels "Player Number", and "Ball In Play" (224 bytes total).  The working game screen while the ball is in motion uses only 296 bytes of screen memory.

Below is a map of the display screen indicating:

- Red - Unique display line of graphics.
- Grey - Reused/repeated previous graphics
- Black - Empty/blank lines with no graphics/bitmap.

![Screen RAM Use](ScreenMemoryUsage.png?raw=true "Screen RAM Use")

The first red line is the top border in Mode 9 which is 4 scanlines tall. The next line is also Mode 9 and so repeats the same screen data.

The next two sections with five red lines each make up the numbers at the top of the playfield.  There is only five rows of screen data each displayed three times to create numbers 15 scan lines tall.

The next section are eight lines of bricks with one row of data repeated to make bricks three scan lines tall.

At the bottom there is no red line for the bottom border/paddle area.  When this is visible it repeats the same data used for the top border. 

The vast majority of the display is made of empty scan lines lines displaying no bitmapped graphics at all.

The game will also need other reference data supporting the graphics display, but this is not directly displayed, so it need not be in aligned memory:
- a master bitmap of a full brick line for reloading bricks.
- a mask table used for removing an individual brick from the display.
- images and masks for the numbers 0 through 9 for Score, etc at the top of the display.

---

**Bricks**

The bricks are centered on the screen, 7 bricks to the left, 7 to the right.  Since the last brick does not need a trailing space that makes the line an uneven number of pixels which cannot be centered perfectly.  The center for the game is defined one pixel to the right of true center on the screen.  

```asm
SCREEN_BRICKS ; 14 bricks between left and right borders 
	.byte ~00000000,~00000000 ; Left border
	.byte ~11111101,~11111011,~11110111,~11101111,~11011111,~10111111
	; Center of display
	.byte ~01111110,~11111101,~11111011,~11110111,~11101111,~11011111, 
	.byte ~10000000,~00000000, ; Last brick pixel
 ```
 
Drawing bricks to the screen requires no exceptional behavior.  There is no need to add bricks to the display individually.  New Bricks are always added when the game refreshes the entire screen with a complete set of 8 rows of Bricks. This is easy to do by copying from a master reference (as defined above) to the screen memory for each row.

Removing bricks is a different problem.  This must be done on an individual, brick-by-brick basis.  Observe the third brick in the row defined here:

```asm
	11111101 11111011 11110111 11101111 11011111 10111111
	         ------^^ ^^^^----
 ```
 
The indicated Brick overlaps two separate bytes and the two bytes also include the data for other Bricks. Removing the brick from the screen requires manipulating two bytes of memory and altering only the bits for ythe target Brick without disturbing the bits belonging to the other Bricks.  The Bricks are in various positions within the bitmaps and require different masks.

So, given a mask to remove the six bits of one brick: ~00000011   Each brick position needs a shift value to move the mask left or right depending on its position within each byte.  Any excess bits shifted into the mask that are not to be removed must be shifted in as "1" bits.  The 6502 does not have variable distance bit shifting, or 16-bit shifting, so this mask calculation activity will be time consuming to work out the correct alignment of two different masks.

To improve the table and simplify the supporting logic, rather than listing the mask shift directions for each Brick, pre-calculate the final mask values and use these for the table.

Given Brick identification (i.e. the number of the Brick in the horizontal row) these are the variables: 
- First byte offset from the beginning of the row.  
- Pre-calculated mask to remove the target brick from the byte.
- Optional mask to remove the target brick from the second byte.

Given a target brick number (0 to 13) a table can be created with the entries:

| Brick | Offset | Mask 1    | Mask 2 |
| ----- | ------ | ------    | ------ | 
| 0     | +2     | ~00000011 | ~11111111 |
| 1     | +2     | ~11111110 | ~00000111 |
| 2     | +3     | ~11111100 | ~00001111 |
| 3     | +4     | ~11111000 | ~00011111 |
| 4     | +5     | ~11110000 | ~00111111 |
| 5     | +6     | ~11100000 | ~01111111 |
| 6     | +7     | ~11000000 | ~11111111 |
| 7     | +8     | ~10000001 | ~11111111 |
| 8     | +9     | ~00000011 | ~11111111 |
| 9     | +9     | ~11111110 | ~00000111 |
| 10    | +10    | ~11111100 | ~00001111 |
| 11    | +11    | ~11111000 | ~00011111 |
| 12    | +12    | ~11110000 | ~00111111 |
| 13    | +13    | ~11100000 | ~01111111 |

OR as 6502 code declarations:

```asm
BRICK_MASKS
	.byte 2,~00000011,~11111111,2,~11111110,~00000111,3,~11111100,~00001111,4,~11111000,~00011111
	.byte 5,~11110000,~00111111,6,~11100000,~01111111,7,~11000000,~11111111,8,~10000001,~11111111
	.byte 9,~00000011,~11111111,9,~11111110,~00000111,10,~11111100,~00001111,11,~11111000,~00011111
	.byte 12,~11110000,~00111111,13,~11100000,~01111111
```

Bricks 0, 6, 7, 8 fit completely within the first byte of screen memory, therefore the mask for the second byte turns off no bits.  The value of that mask ($FF) may be used as the trigger to skip masking the second byte.  Or if the same algorithm applies to all conditions the $FF mask value insures no change occurs to the second byte in screen memory.

Solving one issue causes another. Each array entry is three bytes, so the brick number has to be multiplied by 3 to acquire the correct offset to the array entry for the row.  This is complicated by the fact the 6502 does not have an explicit multiplication instruction.  In this case, it takes only a few steps to multiply by 3, so it is a reasonable amount of code to do this directly.  If this were a value such as 42, then a larger, slower, more generalized routine would be better.  Multiplication by 3 can be done by adding to itself:

```asm
; Assume brick number is in Accumulator
; . . .
	clc
	sta TEMP_3 ; Save A elsewhere.
	adc TEMP_3 ; A = A + A or it's now 2 * A
	adc TEMP_3 ; A = A + A + A or now 3 * A
; . . .
``` 

Depending on the location of TEMP_3 in page 0 or outside of page 0, the size of this code is 7 or 10 bytes.

This code saves the Brick number to a temporary location, then adds it again to the accumulator.  This is the same as mulitplying times 2.  Then it adds the value again which is the same as multiplying by 3.  Since the starting value expected for bricks is small (0 to 13), there would be no carry to manage from the ADC instructions.

Alternatively, multiplication times 3 could be done like the code below which is 6 or 9 bytes (depending on the address location for TEMP_3):

```asm
; Assume brick number is in Accumulator
; . . .
	clc
	sta TEMP_3 ; Save A elsewhere.
	asl A      ; A = A * 2  or the same as A = A + A 
	adc TEMP_3 ; A = ( A * 2 ) + A or now 3 * A
; . . .
``` 

ASL, Arithmetic Shift Left, shifts all the bits in the Accumulator left one position which effectively multiplies the value of the accumulator by 2.  Adding the original value (saved in TEMP_3) to the shifted result then is the same as multiplying times 3.  Again, like the previous example carry would not be an issue for the ASL or the ADC in this code.

There is always a different way to get from point A to point B. Because the Brick values are small, contiguous, and begin at 0, the fastest possible conversion from Brick number to array index can be done by direct lookup from another array:

```asm
; Assume brick number is in Accumulator
; . . .
	tax  ; Save A in X register.
	lda TIMES_3,X  ; A = TIMES_3[X]
; . . .
TIMES_3
	.byte 0,3,6,9,12,15,18,21,24,27,30,33,36,39
``` 

The executable code is 3 or 4 bytes depending on the memory location of the TIMES_3 lookup table. (Though it would be rather wasteful to occupy so much space in page 0 with this table.)  This makes it the smallest, fastest code for execution.  However, the lookup table is 14 bytes, so at a total 17 or 18 bytes, this requires the most memory.  Complicated examples requiring more code would benefit from a greater execution v memory ratio using the table lookup method.

The next question is how does the code go from a screen coordinate -- effectively a pixel number in the row -- to the identification of a specific brick?  A nearly usable formula for this is:

(PIXEL_COORDINATE - LEFT_EDGE_OF_PLAYFIELD) / 7

Almost, but not quite. There is an empty pixel between each Brick which should not be counted as a Brick.  In order to distinguish Brick from blank space the actual pixel position must be tested and if a pixel is present then it can be treated as a Brick number.  The master data for a filled-in row of Bricks is exactly the data needed for this test.

However, this line of thinking is going down a rabbit trail that leads to suffering.  Since Bricks are not aligned to bytes then converting horizontal coordinates to a byte offset in screen memory isn't accomplishing much more than adding confusion.  The conversion from horizontal coordinates to a Brick number is easiest to solve and understand by simply creating a lookup table that provides the Brick number at each horizontal coordinate or a flag value for the blank spaces to indicate it is not a Brick. 

On the surface this would seem to require a table with an entry for every possible screen coordinate (0 to 127) for pixels.   However, the game screen aspect skips the first two bytes (16 pixels) of screen memory and since those coordinates will never be used, then they need not appear in the lookup table.

Additionally, in the game's implementation the coordinate lookup is based on the position of Player/Missile graphics (the position of the ball).  This differs from pixel coordinates, but the same rule applies as for the screen memory horizontal coordinates -- there is a fixed, minimum coordinate for the left side of the screen.  Positions further left cannot be used, and so this position can be treated as the base or zero value to normalize the coordinates.  This base will is referred to as "LEFT_EDGE_OF_PLAYFIELD".  Subtracting this from the current coordinate (of the ball) converts the coordinate to match the screen dimensions where the base is the left edge coordinate.

Therefore, the code to convert a horizontal coordinate to a Brick number is this (almost the same as the lookup code for multiplying times 3):

```asm
; Assume horizontal coordinate is in Accumulator
; . . .
	sec                           ; Manage carry for subtraction
	sbc #LEFT_EDGE_OF_PLAYFIELD   ; Normalize to base position as 0 
	tax                           ; Save A in X register.
	lda POS_TO_BRICK,X            ; A = POS_TO_BRICK[X]
; . . .
POS_TO_BRICK
	.byte 0,0,0,0,0,0,$FF
	.byte 1,1,1,1,1,1,$FF
	.byte 2,2,2,2,2,2,$FF
	. . .
	.byte 12,12,12,12,12,12,$FF
	.byte 13,13,13,13,13,13
``` 
At the end the Accumulator contains a Brick number 0 through 13, or the value $FF indicating the pixel is not a brick value. This implementation will be large(ish) requiring one byte for each pixel coordinate on screen (97 bytes).  However, the alternative is logic performing fourteen sequential tests for the coordinates...   It would be the equivalent of doing this comparison for each of the 14 Bricks:

```asm
	IF X >= BRICK_X_START AND X <= BRICK_X_START+5 THEN ... this is a Brick.
```

This looks simple in pseudo-BASIC, but in 6502 assembly it requires several comparison instruction and branch instructions.  Depending on how this is actually done it is roughly 10 bytes of code to evaluate if coordinates are in a specific brick.  Reversing the logic to exclude a coordinate from consideration as a brick rather than checking for inclusion saves comparisons, since "Less Than OR Equal To" requires two comparison instructions. The statement above with reversed logic would be:   
```asm
	IF X < BRICK_X_START AND X > BRICK_X_START+5 THEN ... this is NOT a Brick.
```

The same in 6502 assembly:

```asm
; Assume horizontal coordinate is in Accumulator.
; Test for Brick 2 which has coordinates from 14 to 19.
; . . .
	cmp #14
	bcc NOT_BRICK_2 ; Less than 14, so not brick 2.
	cmp #20         ; Note, 20 not 19.  If 19 was used then another comparison is needed for equality.
	bcs NOT_BRICK_2 ; Greater than or equal to 20, so not brick 2.
	lda #2          ; Tell caller it is brick 2.
	jmp SOMEPLACE_USEFUL
; . . .
NOT_BRICK_2
	lda #$FF       ; Tell caller this is not a brick.
	jmp SOMEPLACE_USEFUL
```

By comparison, the lookup table method uses 7 bytes of data for each brick.  A single round of comparisons for one brick would be tough to fit inside seven bytes.  Explicit code testing each range of Brick positions is unavoidably slower than the direct lookup method.

The comparison tests could be more memory efficient by reducing the test to a subroutine using different inputs per each brick. The tests would be driven by a table with less data per Brick than the direct lookup method. But in the end, this would still be far more execution time than the direct lookup method, and this routine is needed repeatedly per TV frame to evaluate Ball v Brick pixel collisions.

---

**Top Borders**

The Top Border is a  solid line of pixels across the screen from the Left border to Right Border.  This is built from two lines of ANTIC Mode 9 graphics which has pixels two color clocks wide by four scan lines tall.

```asm
SCREEN_BORDER ; Solid horizontal border between left and right vertical borders. 
	.byte ~00000000 ; Left border
	.byte ~11111111,~11111111,~11111111
	; Center of display
	.byte ~11111111,~11111111,~11111111
	.byte ~10000000 ; Last brick pixel 
 ```

The area of the top Border also presents the external labels for "PLAYER NUMBER" and "BALL IN PLAY".  These are pre-determined bit-mapped images.  Display List "subroutines" display the image(s) for the three states of the Top Border.  This is done with a JMP instruction in the main Display List pointing to one of the other three Display Lists.  (Located in the Main Display List at JMP_TOP_BORDER (+2).) Simply changing the low byte in the main Display List to point to one of the three Border image Display Lists "subroutines" causes the next frame to display the intended image.  Only the low byte changes in the Display List, so there can never be a partial/incorrect address in the Main Display List.  Therefore there is no need to synchronize the change to ANTIC's current beam position.

| State         | MAIN LMS                  | DLI COLPF0 | DLI COLPF0 Flash |
| ------------- | ------------------------- | ---------- | ---------------- |
| Border        | DISPLAY_LIST_BORDER       | White/$0C  | N/A |
| Player Number | DISPLAY_LIST_PLAYER_LABEL | Yellow/$1A | Black/$00 |
| Ball In Play  | DISPLAY_LIST_BALL_LABEL   | Yellow/$1A | Black/$00 |

---

**Numbers**

Numbers are sized like bricks -- 7 color clocks wide using six for the image, and one as space between the numbers. The numbers are created as 3x5 segments.  The six color clocks are divided into pairs and each pair is the horizontal dimension of a segment.  The segment vertical dimension is three scan lines accomplished by displaying hte same line of screen memory three times.    The illustration below shows all the horizontal bits/pixels/color clocks.  Each row represents 3 scan lines vertically.  

- :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:

===

- :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:

(Yes, that's abusing github's emoji to display a simulated bitmap.)

Unlike Bricks, the Numbers have the problem of individually drawing AND removing them from the screen where Bricks only need to be removed.  Since screen memory represents a bitmap of 8 pixels/color clocks per byte, the numbers displayed at different positions on the screen are not aligned to the bytes of screen memory and may occupy parts of two bytes in screen memeory.  Like the problem with removing Bricks, this arrangement complicates drawing numbers on the screen.  Rendering numbers requires masking and shifting number images together with screen memory.  

The numbers are conveniently aligned to Brick positions, which allows reusing significant parts of the Brick masking logic for the numbers:

![Numbers](Breakout_bw_startup_crop_number_area.png?raw=true "Numbers")

The "Player Number" value is in Brick position 0.  The "Ball In Play" value is in Brick position 8.  Interestingly, (and conveniently), both positions use the same mask values in the Bricks' mask table. 

The Player One score on the left uses Brick positions 0, 1, 2 and 3.   The positions 1, 2, and 3 display default to "0".  The arcade game uses position 0 when the score overflows past 999 points.  It is not possible for the arcade version to exceed 9,999 points due to a bug.  The Atari computer version will allow the game to continue as long as there are balls left, so it will be possible to exceed 9,999.  In this case the displayed score will roll over to 000.

The Player Two score on the left uses Brick positions 8, 9, 10, and 11.   Like Player One, the positions 9, 10, and 11 display default  "0".  The arcade game uses position 8 when the score overflows past 999 points.  Score handling and roll over is the same as Player One.

Given the number "4" image in a series of bytes:
```asm
	11001100 
	11001100
	11111100
	00001100
	00001100
```

Aligning the number to the third Brick position on screen requires shifting the image across two bytes:
```asm
	11111101 11111011 11110111 11101111 11011111 10111111
	         ------^^ ^^^^----
	               11 001100 
	               11 001100
	               11 111100
	               00 001100
	               00 001100
```

In this case the value is shifted 6 bits right for the first byte, and the same image shifted shifted left two bits for the second byte.

Also note that the "image" is actually only the first 6 bits of the 8 bit byte.  The last two zeros would be masked out when writing in screen memory, so they do not overwrite other Number images in screen memeory.

Drawing a number requires managing the following information relative to a target position on the screen:
- First byte offset from the beginning of the row of screen memory.  
- Pre-calculated mask to remove the target number from the byte.
- Optional mask to remove the target number from the second byte.
- Number of bits to Right Shift the number bitmap image in the first byte. 
- Number of bits to Left Shift the number bitmap image in the second byte.

| Position | Offset | Mask 1    | Mask 2    | First Byte Right Shift | Second Byte Left Shift |
| -------- | ------ | ------    | --------- | ---------------------- | ---------------------- |
| 0        | +2     | ~00000011 | ~11111111 | 0                      | $FF  (N/A)             |
| 1        | +2     | ~11111110 | ~00000111 | 7                      | 1                      |
| 2        | +3     | ~11111100 | ~00001111 | 6                      | 2                      |
| 3        | +4     | ~11111000 | ~00011111 | 5                      | 3                      |
| . . . |  |     |  |  |  |
| 8        | +9     | ~00000011 | ~11111111 | 0                      | $FF  (N/A)             |
| 9        | +9     | ~11111110 | ~00000111 | 7                      | 1                      |
| 10       | +10    | ~11111100 | ~00001111 | 6                      | 2                      |
| 11       | +11    | ~11111000 | ~00011111 | 5                      | 3                      |

Conveniently, the masks and shifting for positions 0, 1, 2, and 3 are identical to the data for positions 8, 9, 10, and 11 which provides an opportunity for optimization.

Writing a number is then:

SCREEN MEMORY:
```asm
	11111101 11111011 11110111 11101111 11011111 10111111
```

AND MASK
```asm
	         11111100 00001111
```

RESULT
```asm
	11111101 11111000 00000111 11101111 11011111 10111111
```

NUMBER SHIFTED
```asm
	               11 001100 
```

OR SCREEN MEMORY, RESULT
```asm
	11111101 11111011 00110111 11101111 11011111 10111111
```

Removing the shifting work would require creating pre-shifted images of all the numbers for direct lookup.  Ten numbers, times 5 bytes of screen data per number, times two possible shifted byte results for each original byte, times the four shifted positions needed is a total of 400 bytes for a direct lookup table.  This is more than a full page, so the table would need to be subdivided and/or more calculation needed to find the appropriate elements which negates some of the execution efficiency.

The hybrid algorithmic solution with some lookup tables is a reasonable amount of memory use combined with code.

The Numbers for Player Number and Ball In Play need to flash on and off.  Since the objects need to flash at different times and both reside on the same lines of the display, the game cannot use the usual, lowest-weight methods -- altering color register values, or altering the display list.  The next choice would be to repeatedly draw the images on screen and erase them.  This could be simplified further by coping the images to a buffer, removing them from the screen, and then copying them back from the buffer.

There is always another way to solve a problem on the Atari.  The third choice is to use Player/Missile graphics.  At maximum horizontal width a Player can cover 32 color clocks.  This is sufficient to cover any of the Numbers, even the score which is four digits wide.  A Player object set to the same color as the background could cover the drawn images on screen provided the priority of the Players is above the playfield.  Turning "off" the Numbers on screen is as simple as changing one horizontal position register for a Player to cover the numbers in screen.  Turning it on is just a matter of moving the obscuring Player object to a horizontal position off the screen. 

Priority value  ~0001 will be used for the game.

Priority Bits | 0 0 0 1 | 0 0 1 0 | 0 1 0 0 | 1 0 0 0 | 0 0 0 0
---           | ---     | ---     | ---     | ---     | ---
Top           | PM0     | PM0     | P5/PF0  | P5/PF0  | PM0
.             | PM1     | PM1     | PF1     | PF1     | PM1
.             | PM2     | P5/PF0  | PF2     | PM0     | P5/PF0
.             | PM3     | PF1     | PF3     | PM1     | PF1
.             | P5/PF0  | PF2     | PM0     | PM2     | PM2
.             | PF1     | PF3     | PM1     | PM3     | PM3
.             | PF2     | PM2     | PM2     | PF2     | PF2
.             | PF3     | PM3     | PM3     | PF3     | PF3
Bottom        | COLBK   | COLBK   | COLBK   | COLBK   | COLBK

---

**Bottom Border**

The Bottom Border is identical to the Top Border and uses the same screen data:

```asm
SCREEN_BORDER ; Solid horizontal border between left and right vertical borders. 
	.byte ~00000000 ; Left border
	.byte ~11111111,~11111111,~11111111
	; Center of display
	.byte ~11111111,~11111111,~11111111
	.byte ~10000000 ; Last brick pixel 
 ```

The Bottom Border has two states, visible, or not visible.  When the Bottom Border is not visible the Paddle is visible.  When the border is visible there is no need to change any display character istics of the  Paddle.  The Paddle and the border are the same color, so they cover (blend in) with each other.

The states could be managed by changing the color of the Bottom border using Blue/$96 when visible, and Black/$00 when not.  Provided Player/Missile priorities put Player/Missile graphics above Playfield pixels this would work successfully. 

The game will use the same management for the Bottom Border as the Top Border.  Display List "subroutines" exist for each state of the Bottom Border, and the main Display List points to one of the routines (address at JMP_BOTTOM_BORDER (+2)).

Again, since only the low byte changes in the Display List, there can never be a partial/incorrect address in the Main Display List which means it is not necessary to synchronize the change to ANTIC's current beam position.

| State         | MAIN LMS                      | DLI COLPF0 | 
| ------------- | ----------------------------- | ---------- | 
| Border        | DISPLAY_LIST_BOTTOM_BORDER    | Blue/$96  | 
| No Border     | DISPLAY_LIST_NO_BOTTOM_BORDER | N/A | 

---

**Vertical Blank Interrupt**

- GTIA GRACTL control for Player/Missile graphics

OS Shadow Establishes:
- ANTIC Display Width Narrow + Playfield DMA + Player/Missile DMA.
- GTIA PRIOR value ~0001
- COLPF0 is White/$0C
- COLPM0 is 

VBI Establishes:


---

**Display Memory Map**

The Atari game only needs to use the Missiles and Player 0 in the Player/Missile memory map.  Most of the memory map, six pages, or 1.5K is unused.  These conveniently reserved pages of memory house the playfield memory assets:

| Base   | Memory        | Offset        | Notes |
| ---    | ---           | ---           | ---   |
| PMBASE | +$000 - +$0FF |               | Unused Page 0, Player/Missile base address |
|        |               | +$000 - +$00F | LABEL_PLAYER_LINE1 |
|        |               | +$010 - +$01F | LABEL_PLAYER_LINE2 |
|        |               | +$020 - +$02F | LABEL_PLAYER_LINE3 |
|        |               | +$030 - +$03F | LABEL_PLAYER_LINE4 |
|        |               | +$040 - +$04F | LABEL_PLAYER_LINE5 |
|        |               | +$050 - +$05F | LABEL_PLAYER_LINE6 |
|        |               | +$060 - +$06F | LABEL_PLAYER_LINE7 |
|        |               | +$070 - +$07F | LABEL_BALL_LINE1 |
|        |               | +$080 - +$08F | LABEL_BALL_LINE2 |
|        |               | +$090 - +$09F | LABEL_BALL_LINE3 |
|        |               | +$0A0 - +$0AF | LABEL_BALL_LINE4 |
|        |               | +$0B0 - +$0BF | LABEL_BALL_LINE5 |
|        |               | +$0C0 - +$0CF | LABEL_BALL_LINE6 |
|        |               | +$0D0 - +$0DF | LABEL_BALL_LINE7 |
|        |               | +$0E0 - +$0E7 | BORDER_LINE |
|        |               | +$0E8 - +$0FF | Unused 24 bytes|
| PMBASE | +$100 - +$1FF |               | Unused Page 1 |
|        |               | +$100 - +$10F | PLAYER_AND_BALL_LINE1 |
|        |               | +$110 - +$11F | PLAYER_AND_BALL_LINE2 |
|        |               | +$120 - +$12F | PLAYER_AND_BALL_LINE3 |
|        |               | +$130 - +$13F | PLAYER_AND_BALL_LINE4 |
|        |               | +$140 - +$14F | PLAYER_AND_BALL_LINE5 |
|        |               | +$150 - +$15F | SCORES_LINE1 |
|        |               | +$160 - +$16F | SCORES_LINE2 |
|        |               | +$170 - +$17F | SCORES_LINE3 |
|        |               | +$180 - +$18F | SCORES_LINE4 |
|        |               | +$190 - +$19F | SCORES_LINE5 |
|        |               | +$1A0 - +$1FF | Unused 96 bytes |
| PMBASE | +$200 - +$2FF |               | Unused Page 2 |
|        |               | +$200 - +$20F | BRICKS_LINE1 |
|        |               | +$210 - +$21F | BRICKS_LINE2 |
|        |               | +$220 - +$22F | BRICKS_LINE3 |
|        |               | +$230 - +$23F | BRICKS_LINE4 |
|        |               | +$240 - +$24F | BRICKS_LINE5 |
|        |               | +$250 - +$25F | BRICKS_LINE6 |
|        |               | +$260 - +$26F | BRICKS_LINE7 |
|        |               | +$270 - +$27F | BRICKS_LINE8 |
|        |               | +$280 - +$2FF | Backup of bricks buffer for other player. |
| PMBASE | +$300 - +$3FF |               | Missiles bitmap (Left/Right Borders) |
| PMBASE | +$400 - +$4FF |               | Player 0 bitmap (Ball) |
| PMBASE | +$500 - +$5FF |               | Player 1 bitmap (Paddle) **SHARED...** |
|        |               | +$500 - $591  | Main Display List (146/$92 bytes) |
| PMBASE | +$600 - +$6FF |               | Player 2 bitmap (Text Mask 1) **SHARED...** |
|        |               | +$600 -       | Display List "Subroutines" |
| PMBASE | +$700 - +$7FF |               | Player 3 bitmap (Text Mask 2) |


Related lines of screen data occur within the same page in memory.  Code moving between adjacent rows of screen memeory only need to alter the low byte of addesses to reference the next row. 

---

**Other Notes**

No Atari text modes are used in the Game Screen, so no character set is needed. The little "text" needed is more efficiently rendered as bitmaps than dedicating a custom font.

The game needs backup of each Player's screen/bricks image when switching between players.  So, the game could simply copy the 8 lines of BRICKS_LINE data to equivalent backup buffers (another 128 bytes for backup.) This is not directly displayed, so it need not be precisely aligned.

Flashing the external labels can be done simply by toggling COLPF0 in the DLI between Black/$00 and Yellow/$1A

Flashing the Scores, Player Number, and Ball counter will be done using Players 2 and 3 to cover the numbers.  The Players will use a bitmap displayed in the background black color and will move to obscure the numbers to "erase" them from the screen.  This reduces flashing to a few register updates to "remove" the Numbers from the screen, rather than using an additional bitmap masking exercise.

---

**Main Display List -- 216 Display Lines**

| Scan Lines | Display Lines | Mode | LMS                   | DLI | COLPF0 | COLPM0/COLPM1 | Notes |
| ---------- | ------------- | ---- | ----                  | --- | ------ | ------ | ----- |
| **TOP SPACING**
| 0 - 7      |               | $70  |                       |     |        |        | Necessary Spacing | 
| 8 - 11     |               | $30  |                       |  Y  |    X   |        | DLI set COLPF0 to White/$0C or Yellow/$1A or Black/$00 depending on state of Border or Labels |
|            |               |      |                       |     |        |        | JMP_TOP_BORDER (+2) |
| **TOP BORDER**
| 12 - 19    | 1 - 8         | JMP  |                       |     |        |        | Jump to DISPLAY_LIST_BORDER |
| **OR EXTERNAL LABELS - PLAYER NUMBER**
| 12 - 19    | 1 - 8         | JMP  |                       |     |        |        | Jump to DISPLAY_LIST_PLAYER_LABEL |
| **OR EXTERNAL LABELS - BALL IN PLAY**
| 12 - 19    | 1 - 8         | JMP  |                       |     |        |        | Jump to DISPLAY_LIST_BALL_LABEL |
| **RETURN_END_TOP_BORDER** 
|            |               |      |                       |     |        |        | RETURN_END_TOP_BORDER |
| 20         | 9             | $00  |                       |     | X      |        | Blank Line - DLI Return COLPF0 to White/$0C |
| **PLAYER AND BALL NUMBERS**
| 21         | 10            | $0C  | PLAYER_AND_BALL_LINE1 |     |        |        | Segment 1, Player And Ball Display  |
| 22 - 23    | 11 - 12       | $0B  | PLAYER_AND_BALL_LINE1 |     |        |        | Segment 1, Player And Ball Display  |
| 24         | 13            | $0C  | PLAYER_AND_BALL_LINE2 |     |        |        | Segment 2, Player And Ball Display  |
| 25 - 26    | 14 - 15       | $0B  | PLAYER_AND_BALL_LINE2 |     |        |        | Segment 2, Player And Ball Display  |
| 27         | 16            | $0C  | PLAYER_AND_BALL_LINE3 |     |        |        | Segment 3, Player And Ball Display  |
| 28 - 29    | 17 - 18       | $0B  | PLAYER_AND_BALL_LINE3 |     |        |        | Segment 3, Player And Ball Display  |
| 30         | 19            | $0C  | PLAYER_AND_BALL_LINE4 |     |        |        | Segment 4, Player And Ball Display  |
| 31 - 32    | 20 - 21       | $0B  | PLAYER_AND_BALL_LINE4 |     |        |        | Segment 4, Player And Ball Display  |
| 33         | 22            | $0C  | PLAYER_AND_BALL_LINE5 |     |        |        | Segment 5, Player And Ball Display  |
| 33 - 35    | 23 - 24       | $0B  | PLAYER_AND_BALL_LINE5 |     |        |        | Segment 5, Player And Ball Display  |
| 36         | 25            | $00  |                       |     |        |        | Blank Line  |
| **SCORES**
| 37         | 26            | $0C  | SCORES_LINE1          |     |        |        | Segment 1, Scores Display  |
| 38 - 39    | 27 - 28       | $0B  | SCORES_LINE1          |     |        |        | Segment 1, Scores Display  |
| 40         | 29            | $0C  | SCORES_LINE2          |     |        |        | Segment 2, Scores Display  |
| 41 - 42    | 30 - 31       | $0B  | SCORES_LINE2          |     |        |        | Segment 2, Scores Display  |
| 43         | 32            | $0C  | SCORES_LINE3          |     |        |        | Segment 3, Scores Display  |
| 44 - 45    | 33 - 34       | $0B  | SCORES_LINE3          |     |        |        | Segment 3, Scores Display  |
| 46         | 35            | $0C  | SCORES_LINE4          |     |        |        | Segment 4, Scores Display  |
| 47 - 48    | 36 - 37       | $0B  | SCORES_LINE4          |     |        |        | Segment 4, Scores Display  |
| 49         | 38            | $0C  | SCORES_LINE5          |     |        |        | Segment 5, Scores Display  |
| 50 - 51    | 39 - 40       | $0B  | SCORES_LINE5          |     |        |        | Segment 5, Scores Display  |
| 52 - 53    | 41 - 42       | $10  |                       |  Y  | X      | X      | 2 Blank Lines - DLI Set COLPF0, COLPF3 to Red/$42 |
| **BRICKS**
| 54         | 43            | $0C  | BRICKS_LINE1          |     |        |        | Red Bricks row 1  |
| 55 - 56    | 44 - 45       | $0B  | BRICKS_LINE1          |     |        |        | Red Bricks row 1  |
| 57         | 46            | $00  |                       |     |        |        | Blank Line  |
| 58         | 47            | $0C  | BRICKS_LINE2          |     |        |        | Red Bricks row 2  |
| 59 - 60    | 48 - 49       | $0B  | BRICKS_LINE2          |     |        |        | Red Bricks row 2  |
| 61         | 50            | $00  |                       |  Y  |  X     |  X     | Blank Line - DLI Set COLPF0, COLPF3 to Orange/$28  |
| 62         | 51            | $0C  | BRICKS_LINE3          |     |        |        | Orange Bricks row 1  |
| 63 - 64    | 52 - 53       | $0B  | BRICKS_LINE3          |     |        |        | Orange Bricks row 1  |
| 65         | 54            | $00  |                       |     |        |        | Blank Line  |
| 66         | 55            | $0C  | BRICKS_LINE4          |     |        |        | Orange Bricks row 2  |
| 67 - 68    | 56 - 57       | $0B  | BRICKS_LINE4          |     |        |        | Orange Bricks row 2  |
| 69         | 58            | $00  |                       |  Y  |  X     |  X     | Blank Line - DLI Set COLPF0, COLPF3 to Green/$C4  |
| 70         | 59            | $0C  | BRICKS_LINE5          |     |        |        | Green Bricks row 1  |
| 71 - 72    | 60 - 61       | $0B  | BRICKS_LINE5          |     |        |        | Green Bricks row 1  |
| 73         | 62            | $00  |                       |     |        |        | Blank Line  |
| 74         | 63            | $0C  | BRICKS_LINE6          |     |        |        | Green Bricks row 2  |
| 75 - 76    | 64 - 65       | $0B  | BRICKS_LINE6          |     |        |        | Green Bricks row 2  |
| 77         | 66            | $00  |                       |  Y  |  X     |  X     | Blank Line - DLI Set COLPF0, COLPF3 to Yellow/$1A  |
| 78         | 67            | $0C  | BRICKS_LINE7          |     |        |        | Yellow Bricks row 1  |
| 79 - 80    | 68 - 69       | $0B  | BRICKS_LINE7          |     |        |        | Yellow Bricks row 1  |
| 81         | 70            | $00  |                       |     |        |        | Blank Line  |
| 82         | 71            | $0C  | BRICKS_LINE8          |     |        |        | Yellow Bricks row 2  |
| 83 - 84    | 72 - 73       | $0B  | BRICKS_LINE8          |  Y  | X      | X      | Yellow Bricks row 2 - DLI Set COLPF0, COLPF3 to White/$0C |
| **EMPTY PLAYFIELD**
| 85 - 92    | 74 - 81       | $70  |                       |     |        |        | 8 Blank Lines -- 123 total  |
| 93 - 100   | 82 - 89       | $70  |                       |     |        |        | 8 Blank Lines  |
| 101 - 108  | 90 - 97       | $70  |                       |     |        |        | 8 Blank Lines  |
| 109 - 116  | 98 - 105      | $70  |                       |     |        |        | 8 Blank Lines  |
| 117 - 124  | 106 - 113     | $70  |                       |     |        |        | 8 Blank Lines  |
| 125 - 132  | 114 - 121     | $70  |                       |     |        |        | 8 Blank Lines  |
| 133 - 140  | 122 - 129     | $70  |                       |     |        |        | 8 Blank Lines  |
| 141 - 148  | 130 - 137     | $70  |                       |     |        |        | 8 Blank Lines  |
| 149 - 156  | 138 - 145     | $70  |                       |     |        |        | 8 Blank Lines  |
| 157 - 164  | 146 - 153     | $70  |                       |     |        |        | 8 Blank Lines  |
| 165 - 172  | 154 - 161     | $70  |                       |     |        |        | 8 Blank Lines  |
| 173 - 180  | 162 - 169     | $70  |                       |     |        |        | 8 Blank Lines  |
| 181 - 188  | 170 - 177     | $70  |                       |     |        |        | 8 Blank Lines  |
| 189 - 196  | 178 - 185     | $70  |                       |     |        |        | 8 Blank Lines  |
| 197 - 204  | 186 - 193     | $70  |                       |     |        |        | 8 Blank Lines  |
| 205 - 212  | 194 - 201     | $70  |                       |     |        |        | 8 Blank Lines  extra for 216 |
| 213 - 215  | 202 - 204     | $20  |                       | Y   |     X  |     X  | 3 Blank Lines -- 123 total - DLI Set COLPF0, COLPF3 to Blue/$96 |
|            |               |      |                       |     |        |        | JMP_BOTTOM_BORDER (+2) |
| **PADDLE-BOTTOM BORDER**
| 216 - 223  | 205 - 212     | JMP  |                       |     |        |        | Jump to DISPLAY_LIST_BOTTOM_BORDER |
| **OR NO BOTTOM BORDER**
| 216 - 223  | 205 - 212     | JMP  |                       |     |        |        | Jump to DISPLAY_LIST_BOTTOM_NO_BORDER |
| **RETURN_END_BOTTOM_BORDER** 
|            |               |      |                       |     |        |        | RETURN_END_BOTTOM_BORDER |
| **THE END**
| 224 - 227  | 213 - 216     | $30  |                       |     |        |        | 4 Blank Lines |
|            |               | JVB  |                       |     |        |        | Jump Vertical Blank |

**DISPLAY LIST "SUBROUTINES"**

**TOP BORDER (or External Labels)**

| Scan Lines | Display Lines | Mode | LMS         | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ----        | --- | ------ | ------ | ----- |
|            |               |      |             |     |        |        | DISPLAY_LIST_BORDER |
| 12 - 15    | 1 - 4         | $09  | BORDER_LINE |     |        |        | Top Border |
| 26 - 19    | 5 - 8         | $09  | BORDER_LINE |     |        |        | Top Border |
|            |               | JMP  |             |     |        |        | Jump to RETURN_END_TOP_BORDER |

 **TOP EXTERNAL LABELS - PLAYER NUMBER**
 
| Scan Lines | Display Lines | Mode | LMS                | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ----               | --- | ------ | ------ | ----- |
|            |               |      |                    |     |        |        |  DISPLAY_LIST_PLAYER_LABEL |
| 12         | 1             | $0C  | LABEL_PLAYER_LINE1 |     |        |        | "Player Number"  |
| 13         | 2             | $0C  | LABEL_PLAYER_LINE2 |     |        |        | "Player Number"  |
| 14         | 3             | $0C  | LABEL_PLAYER_LINE3 |     |        |        | "Player Number"  |
| 15         | 4             | $0C  | LABEL_PLAYER_LINE4 |     |        |        | "Player Number"  |
| 16         | 5             | $0C  | LABEL_PLAYER_LINE5 |     |        |        | "Player Number"  |
| 17         | 6             | $0C  | LABEL_PLAYER_LINE6 |     |        |        | "Player Number"  |
| 18         | 7             | $0C  | LABEL_PLAYER_LINE7 |     |        |        | "Player Number"  |
| 19         | 8             | $00  |                    |     |        |        | Blank Line  |
|            |               | JMP  |                    |     |        |        | Jump to RETURN_END_TOP_BORDER |

**TOP EXTERNAL LABELS - BALL IN PLAY**

| Scan Lines | Display Lines | Mode | LMS              | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ----             | --- | ------ | ------ | ----- |
|            |               |      |                  |     |        |        | DISPLAY_LIST_BALL_LABEL |
| 12         | 1             | $0C  | LABEL_BALL_LINE1 |     |        |        | "Ball In Play"  |
| 13         | 2             | $0C  | LABEL_BALL_LINE2 |     |        |        | "Ball In Play"  |
| 14         | 3             | $0C  | LABEL_BALL_LINE3 |     |        |        | "Ball In Play"  |
| 15         | 4             | $0C  | LABEL_BALL_LINE4 |     |        |        | "Ball In Play"  |
| 16         | 5             | $0C  | LABEL_BALL_LINE5 |     |        |        | "Ball In Play"  |
| 17         | 6             | $0C  | LABEL_BALL_LINE6 |     |        |        | "Ball In Play"  |
| 18         | 7             | $0C  | LABEL_BALL_LINE7 |     |        |        | "Ball In Play"  |
| 19         | 8             | $00  |                  |     |        |        | Blank Line  |
|            |               | JMP  |                  |     |        |        | Jump to RETURN_END_TOP_BORDER |

**BOTTOM BORDER (or Paddle - No Bottom Border)**

| Scan Lines | Display Lines | Mode | LMS         | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ----        | --- | ------ | ------ | ----- |
|            |               |      |             |     |        |        | DISPLAY_LIST_BOTTOM_BORDER |
| 216 - 219  | 205 - 208     | $09  | BORDER_LINE |     |        |        | Bottom Border |
| 220 - 223  | 209 - 212     | $09  | BORDER_LINE | Y   | X      | X      | Bottom Border - DLI Return COLPF0, COLPF3 to White/$0C |
|            |               | JMP  |             |     |        |        | Jump to RETURN_END_BOTTOM_BORDER |

**OR NO BOTTOM BORDER (Paddle)**

| Scan Lines | Display Lines | Mode | LMS  | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ---- | --- | ------ | ------ | ----- |
|            |               |      |      |     |        |        | DISPLAY_LIST_BOTTOM_NO_BORDER |
| 216 - 223  | 205 - 212     | $70  |      | Y   | X      | X      | 8 Blank Lines - DLI Return COLPF0, COLPF3 to White/$0C |
|            |               | JMP  |      |     |        |        | Jump to RETURN_END_BOTOM_BORDER |

---

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Test Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README05TestScreen.md "Test Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") | [Title Screen . . . :arrow_right:](https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md "Title Screen") 
 
