# Atari-Breakout76 Game Screen Details

**GAME SCREEN DETAILS**

**Player/Missile Graphics**

Single Line resolution Player/Missile Graphics.
- Use 5th player option to color all Missiles using COLPF3.
- Missile0 is Left Border.
- Missile1 is Right Border.
- Missile2 is Ball.
- Player0 is Paddle.
- Paddle/COLPM0 is Blue/$96. 

Single Line Resolution Player/Missile graphics requires dedicating aligned, 2K of memory.

Since the Player/Missile memory map skips 3 pages (768 byte) that reservation automatically creates a block of memory useful for other purposes, such as screen memory or the display list.

Also, the game requires only the bitmaps for Missiles and Player0.  Three other players' bitmaps are unused, so that reserves another 3 pages (768 bytes) of aligned memory.

**Screen Memory**

Top Border, External Label Text, Numbers/Scores, Bricks, and Bottom Border uses ANTIC Modes B or C graphics and only COLPF0.

Each line of bitmapped graphics requires 16 bytes.  The following screen memory resources are referenced by the Display List documented below:
- 1 BORDER_LINE (solid horizontal line for border)
- 7 LABEL_PLAYER_LINE (draw the external label for "Player Number")
- 7 LABEL_BALL_LINE (draw the external label for "Ball In Play")
- 5 PLAYER_AND_BALL_LINE (number "segments" drawn for Player Number and Ball In Play)
- 5 SCORES_LINE (number "segments" drawn for player scores.)
- 8 BRICKS_LINE (rows of bricks displayed on screen)

Total screen memory needed is 33 lines * 16 bytes which is 528 bytes.

Creating this display on typical computers of the 8-bit era would require dedicating a contiguous block of memory providing the bitmap display on every display line.  Assuming a system had the same kind of resolution/color as the Modes used for the Atari display this is 16 bytes times 208 scan lines, 3,328 bytes.  More likely 20 bytes per line, or 4,160 bytes for the full screen.

A fun part of the Atari is the display programmability.  Graphics memory is needed only where graphics are displayed.  Screen memory need not be contiguous and can be addressed beginning almost anywhere in memory for any line.  The only limitation is that a line of graphics cannot cross over a 4K boundary in the middle of a line -- an easy thing to avoid.  Since the Atari can dedicate only the memory it needs to generate the display this works out to only the 528 bytes reported above.  Over half of this is for the bitmaps supporting the external text labels "Player Number", and "Ball In Play" (224 bytes total).  The working game screen needs only 304 bytes of screen memory.

Below is a map of the display screen indicating:

- Red - Unique display line of graphics.
- Grey - Reused/repeated previous graphics
- Black - Empty/blank lines with no graphics/bitmap.

![Screen RAM Use](ScreenMemoryUsage.png?raw=true "Screen RAM Use")

The first red line is the top border.  The seven lines that follow are the same and repeat the same data.

The next two sections with five red lines each make up the numbers at the top of the playfield.  There is only five rows of screen data each displayed three times to create numbers 15 scan lines tall.

The next section are eight lines of bricks with one row of data repeated to make bricks thtee scan lines tall.

At the bottom there is no red line for the bottom border/paddle area.  When visible this repeats the same data used for the top border. 

The vast majority of the display is made of empty scan lines lines displaying no bitmapped graphics at all.


The game will also need other reference data supporting the graphics display, but is not directly displayed, so it need not be in aligned memory:
- a master bitmap of a full brick line for reloading bricks.
- a mask table used for removing an individual brick from the display.
- images and masks for the numbers 0 through 9 for Score, etc at the top of the display.

**Top Border**

============
Top Border Bitmap here
============

**Bricks**

============
Bricks Bitmap here
============

**Numbers**

Numbers and bricks are 7 color clocks wide using six for the image, and one color clock as space between the numbers. The numbers are created as 3x5 segments.  The six color clocks are divided into pairs and each pair is the horizontal dimension of a segment.  The segment vertical dimension is three scan lines accomplished by displaying hte same line of screen memory three times.    The illustration below shows all the horizontal bits/pixels/color clocks.  Each row represents 3 scan lines vertically.  

- :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:

==========

- :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:
- :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:  :white_medium_small_square::white_medium_small_square::white_medium_small_square::white_medium_small_square::black_medium_small_square::black_medium_small_square::white_medium_small_square:

Since screen memory represents a bitmap of 8 pixels/color clocks per byte, the numbers displayed at different positions on the screen are not aligned to the bytes of screen memory and may occupy parts of two bytes in screen memeory.  This complicates drawing numbers on the screen.  Rendering numbers requires masking and shifting number images together with screen memory.  The variations of calculation can be minimized by a lookup table that relates a number position on screen to an offset to screen memory, a mask to isolate the space the number occupies in screen memory, and shift information for the number image.

============
explain lookup table
============




**Vertical Blank Interrupt**

VBI Establishes:
- ANTIC Display Width Narrow + Playfield DMA + Player/Missile DMA.
- GTIA GRACTL control for Player/Missile graphics + 5th Player 
- COLPF3 is white/$0C

**Memory Map**

| Base   | Memory        | Offset        | Notes |
| ---    | ---           | ---           | ---   |
| PMBASE | +$000 - +$0FF |               | Unused Page 0 |
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
|        |               | +$0E0 - +$0EF | PLAYER_AND_BALL_LINE1 |
|        |               | +$0F0 - +$0FF | PLAYER_AND_BALL_LINE2 |
| PMBASE | +$100 - +$1FF |               | Unused Page 1 |
|        |               | +$100 - +$10F | PLAYER_AND_BALL_LINE3 |
|        |               | +$110 - +$11F | PLAYER_AND_BALL_LINE4 |
|        |               | +$120 - +$12F | PLAYER_AND_BALL_LINE5 |
|        |               | +$130 - +$13F | SCORES_LINE1 |
|        |               | +$140 - +$14F | SCORES_LINE2 |
|        |               | +$150 - +$15F | SCORES_LINE3 |
|        |               | +$160 - +$16F | SCORES_LINE4 |
|        |               | +$170 - +$17F | SCORES_LINE5 |
|        |               | +$180 - +$18F | BRICKS_LINE1 |
|        |               | +$190 - +$19F | BRICKS_LINE2 |
|        |               | +$1A0 - +$1AF | BRICKS_LINE3 |
|        |               | +$1B0 - +$1BF | BRICKS_LINE4 |
|        |               | +$1C0 - +$1CF | BRICKS_LINE5 |
|        |               | +$1D0 - +$1DF | BRICKS_LINE6 |
|        |               | +$1E0 - +$1EF | BRICKS_LINE7 |
|        |               | +$1F0 - +$1FF | BRICKS_LINE8 |
| PMBASE | +$200 - +$2FF |               | Unused Page 2 |
|        |               | +$200 - +$20F | BORDER_LINE |
| PMBASE | +$300 - +$3FF |               | Missiles bitmap (Borders, Ball) |
| PMBASE | +$400 - +$4FF |               | Player 0 bitmap (Paddle) |
| PMBASE | +$500 - +$5FF |               | Player 1 bitmap UNUSED |
|        |               | +$500 -       | Main Display List (approx 150 bytes) |
| PMBASE | +$600 - +$6FF |               | Player 2 bitmap UNUSED |
|        |               | +$600 -       | Display List "Subroutines" |
| PMBASE | +$700 - +$7FF |               | Player 3 bitmap UNUSED |
|        |               | +$700 -       | Backup of bricks buffer for other player.  |


**Other Notes**

No Atari text modes are used in the Game Screen, so no character set is needed. The little "text" needed is more efficiently rendered as bitmaps than dedicating a custom font.

The game needs backup of each Player's screen/bricks image when switching between players.  So, the game could simply copy the 8 lines of BRICKS_LINE data to equivalent backup buffers (another 128 bytes for backup.) This is not directly displayed, so it need not be precisely aligned.

To "Flash" external labels simply toggle COLPF0 in the DLI between black/$00 and yellow/$1A

To "Flash" Scores, Player Number, or Ball counter the image must be drawn and erased, since each shares the same line with another value that may not be flashing.

The Scores, Ball counter, and Player number are conceptually 3x5 "segments".  Each "segment" is vertically 3 scanlines tall. This is accomplished by one Mode C (1 scan line) and one Mode B (2 scan lines) instruction using LMS to reuse the same graphics memory for each mode line.

**Main Display List**

| Scan Lines | Display Lines | Mode | LMS                   | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ----                  | --- | ------ | ------ | ----- |
| **TOP SPACING**  
| 0 - 7      |               | $70  |                       |     |        |        | Necessary Spacing | 
| 8 - 15     |               | $70  |                       |  Y  |    X   |        | DLI set COLPF0 to White/$0C or Yellow/$1A or black/$00 depending on state of Border or Labels |
| **TOP BORDER**
| 16 - 23    | 1 - 8         | JMP  |                       |     |        |        | Jump to DISPLAY_LIST_BORDER |
| **OR EXTERNAL LABELS - PLAYER NUMBER**
| 16 - 23    | 1 - 8         | JMP  |                       |     |        |        | Jump to DISPLAY_LIST_PLAYER_LABEL |
| **OR EXTERNAL LABELS - BALL IN PLAY**
| 16 - 23    | 1 - 8         | JMP  |                       |     |        |        | Jump to DISPLAY_LIST_BALL_LABEL |
| **RETURN_END_TOP_BORDER** 
|            |               |      |                       |     |        |        | RETURN_END_TOP_BORDER |
| 24         | 9             | $00  |                       |     | X      |        | Blank Line - DLI Return COLPF0 to White/$0C |
| **PLAYER AND BALL NUMBERS**
| 25         | 10            | $0C  | PLAYER_AND_BALL_LINE1 |     |        |        | Segment 1, Player And Ball Display  |
| 26 - 27    | 11 - 12       | $0B  | PLAYER_AND_BALL_LINE1 |     |        |        | Segment 1, Player And Ball Display  |
| 28         | 13            | $0C  | PLAYER_AND_BALL_LINE2 |     |        |        | Segment 2, Player And Ball Display  |
| 29 - 30    | 14 - 15       | $0B  | PLAYER_AND_BALL_LINE2 |     |        |        | Segment 2, Player And Ball Display  |
| 31         | 16            | $0C  | PLAYER_AND_BALL_LINE3 |     |        |        | Segment 3, Player And Ball Display  |
| 32 - 33    | 17 - 18       | $0B  | PLAYER_AND_BALL_LINE3 |     |        |        | Segment 3, Player And Ball Display  |
| 34         | 19            | $0C  | PLAYER_AND_BALL_LINE4 |     |        |        | Segment 4, Player And Ball Display  |
| 35 - 36    | 20 - 21       | $0B  | PLAYER_AND_BALL_LINE4 |     |        |        | Segment 4, Player And Ball Display  |
| 37         | 22            | $0C  | PLAYER_AND_BALL_LINE5 |     |        |        | Segment 5, Player And Ball Display  |
| 38 - 39    | 23 - 24       | $0B  | PLAYER_AND_BALL_LINE5 |     |        |        | Segment 5, Player And Ball Display  |
| 40         | 25            | $00  |                       |     |        |        | Blank Line  |
| **SCORES**
| 41         | 26            | $0C  | SCORES_LINE1          |     |        |        | Segment 1, Scores Display  |
| 42 - 43    | 27 - 28       | $0B  | SCORES_LINE1          |     |        |        | Segment 1, Scores Display  |
| 44         | 29            | $0C  | SCORES_LINE2          |     |        |        | Segment 2, Scores Display  |
| 45 - 46    | 30 - 31       | $0B  | SCORES_LINE2          |     |        |        | Segment 2, Scores Display  |
| 47         | 32            | $0C  | SCORES_LINE3          |     |        |        | Segment 3, Scores Display  |
| 48 - 49    | 33 - 34       | $0B  | SCORES_LINE3          |     |        |        | Segment 3, Scores Display  |
| 50         | 35            | $0C  | SCORES_LINE4          |     |        |        | Segment 4, Scores Display  |
| 51 - 52    | 36 - 37       | $0B  | SCORES_LINE4          |     |        |        | Segment 4, Scores Display  |
| 53         | 38            | $0C  | SCORES_LINE5          |     |        |        | Segment 5, Scores Display  |
| 54 - 55    | 39 - 40       | $0B  | SCORES_LINE5          |     |        |        | Segment 5, Scores Display  |
| 56 - 57    | 41 - 42       | $10  |                       |  Y  | X      | X      | 2 Blank Lines - DLI Set COLPF0, COLPF3 to Red/$42 |
| **BRICKS**
| 58         | 43            | $0C  | BRICKS_LINE1          |     |        |        | Red Bricks row 1  |
| 59 - 60    | 44 - 45       | $0B  | BRICKS_LINE1          |     |        |        | Red Bricks row 1  |
| 61         | 46            | $00  |                       |     |        |        | Blank Line  |
| 62         | 47            | $0C  | BRICKS_LINE2          |     |        |        | Red Bricks row 2  |
| 63 - 64    | 48 - 49       | $0B  | BRICKS_LINE2          |     |        |        | Red Bricks row 2  |
| 65         | 50            | $00  |                       |  Y  |  X     |  X     | Blank Line - DLI Set COLPF0, COLPF3 to Orange/$28  |
| 66         | 51            | $0C  | BRICKS_LINE3          |     |        |        | Orange Bricks row 1  |
| 67 - 68    | 52 - 53       | $0B  | BRICKS_LINE3          |     |        |        | Orange Bricks row 1  |
| 69         | 54            | $00  |                       |     |        |        | Blank Line  |
| 70         | 55            | $0C  | BRICKS_LINE4          |     |        |        | Orange Bricks row 2  |
| 71 - 72    | 56 - 57       | $0B  | BRICKS_LINE4          |     |        |        | Orange Bricks row 2  |
| 73         | 58            | $00  |                       |  Y  |  X     |  X     | Blank Line - DLI Set COLPF0, COLPF3 to Green/$C4  |
| 74         | 59            | $0C  | BRICKS_LINE5          |     |        |        | Green Bricks row 1  |
| 75 - 76    | 60 - 61       | $0B  | BRICKS_LINE5          |     |        |        | Green Bricks row 1  |
| 77         | 62            | $00  |                       |     |        |        | Blank Line  |
| 78         | 63            | $0C  | BRICKS_LINE6          |     |        |        | Green Bricks row 2  |
| 79 - 80    | 64 - 65       | $0B  | BRICKS_LINE6          |     |        |        | Green Bricks row 2  |
| 81         | 66            | $00  |                       |  Y  |  X     |  X     | Blank Line - DLI Set COLPF0, COLPF3 to Yellow/$1A  |
| 82         | 67            | $0C  | BRICKS_LINE7          |     |        |        | Yellow Bricks row 1  |
| 83 - 84    | 68 - 69       | $0B  | BRICKS_LINE7          |     |        |        | Yellow Bricks row 1  |
| 85         | 70            | $00  |                       |     |        |        | Blank Line  |
| 86         | 71            | $0C  | BRICKS_LINE8          |     |        |        | Yellow Bricks row 2  |
| 87 - 88    | 72 - 73       | $0B  | BRICKS_LINE8          |  Y  | X      | X      | Yellow Bricks row 2 - DLI Set COLPF0, COLPF3 to White/$0C |
| **EMPTY PLAYFIELD**
| 89 - 96    | 74 - 81       | $70  |                       |     |        |        | 8 Blank Lines -- 123 total  |
| 97 - 104   | 82 - 89       | $70  |                       |     |        |        | 8 Blank Lines  |
| 105 - 112  | 90 - 97       | $70  |                       |     |        |        | 8 Blank Lines  |
| 113 - 120  | 98 - 105      | $70  |                       |     |        |        | 8 Blank Lines  |
| 121 - 128  | 106 - 113     | $70  |                       |     |        |        | 8 Blank Lines  |
| 129 - 136  | 114 - 121     | $70  |                       |     |        |        | 8 Blank Lines  |
| 137 - 144  | 122 - 129     | $70  |                       |     |        |        | 8 Blank Lines  |
| 145 - 152  | 130 - 137     | $70  |                       |     |        |        | 8 Blank Lines  |
| 153 - 160  | 138 - 145     | $70  |                       |     |        |        | 8 Blank Lines  |
| 161 - 168  | 146 - 153     | $70  |                       |     |        |        | 8 Blank Lines  |
| 169 - 176  | 154 - 161     | $70  |                       |     |        |        | 8 Blank Lines  |
| 177 - 184  | 162 - 169     | $70  |                       |     |        |        | 8 Blank Lines  |
| 185 - 192  | 170 - 177     | $70  |                       |     |        |        | 8 Blank Lines  |
| 193 - 200  | 178 - 185     | $70  |                       |     |        |        | 8 Blank Lines  |
| 201 - 208  | 186 - 193     | $70  |                       |     |        |        | 8 Blank Lines  |
| 209 - 211  | 194 - 196     | $20  |                       | Y   |     X  |     X  | 3 Blank Lines -- 123 total - DLI Set COLPF0, COLPF3 to Blue/$96 |
| **PADDLE-BOTTOM BORDER**
| 212 - 219  |  197 - 204    | JMP  |                       |     |        |        | Jump to DISPLAY_LIST_BOTTOM_BORDER |
| **OR NO BOTTOM BORDER**
| 212 - 219  | 197 - 204     | JMP  |                       |     |        |        | Jump to DISPLAY_LIST_BOTTOM_NO_BORDER |
| **RETURN_END_BOTTOM_BORDER** 
|            |               |      |                       |     |        |        | RETURN_END_BOTTOM_BORDER |
| **THE END**
| 220 - 223  | 205 - 208     | $30  |                       |     |        |        | 4 Blank Lines |
|            |               | JVB  |                       |     |        |        | Jump Vertical Blank |

**DISPLAY LIST "SUBROUTINES"**

**TOP BORDER (or External Labels)**

| Scan Lines | Display Lines | Mode | LMS         | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ----        | --- | ------ | ------ | ----- |
|            |               |      |             |     |        |        | DISPLAY_LIST_BORDER |
| 16 - 17    | 1 - 2         | $0B  | BORDER_LINE |     |        |        | Top Border |
| 18 - 19    | 3 - 4         | $0B  | BORDER_LINE |     |        |        | Top Border |
| 20 - 21    | 5 - 6         | $0B  | BORDER_LINE |     |        |        | Top Border |
| 22 - 23    | 7 - 8         | $0B  | BORDER_LINE |     |        |        | Top Border |
|            |               | JMP  |             |     |        |        | Jump to RETURN_END_TOP_BORDER |

 **TOP EXTERNAL LABELS - PLAYER NUMBER**
 
| Scan Lines | Display Lines | Mode | LMS                | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ----               | --- | ------ | ------ | ----- |
|            |               |      |                    |     |        |        |  DISPLAY_LIST_PLAYER_LABEL |
| 16         | 1             | $0C  | LABEL_PLAYER_LINE1 |     |        |        | "Player Number"  |
| 17         | 2             | $0C  | LABEL_PLAYER_LINE2 |     |        |        | "Player Number"  |
| 18         | 3             | $0C  | LABEL_PLAYER_LINE3 |     |        |        | "Player Number"  |
| 19         | 4             | $0C  | LABEL_PLAYER_LINE4 |     |        |        | "Player Number"  |
| 20         | 5             | $0C  | LABEL_PLAYER_LINE5 |     |        |        | "Player Number"  |
| 21         | 6             | $0C  | LABEL_PLAYER_LINE6 |     |        |        | "Player Number"  |
| 22         | 7             | $0C  | LABEL_PLAYER_LINE7 |     |        |        | "Player Number"  |
| 23         | 8             | $00  |                    |     |        |        | Blank Line  |
|            |               | JMP  |                    |     |        |        | Jump to RETURN_END_TOP_BORDER |

**TOP EXTERNAL LABELS - BALL IN PLAY**

| Scan Lines | Display Lines | Mode | LMS              | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ----             | --- | ------ | ------ | ----- |
|            |               |      |                  |     |        |        | DISPLAY_LIST_BALL_LABEL |
| 16         | 1             | $0C  | LABEL_BALL_LINE1 |     |        |        | "Ball In Play"  |
| 17         | 2             | $0C  | LABEL_BALL_LINE2 |     |        |        | "Ball In Play"  |
| 18         | 3             | $0C  | LABEL_BALL_LINE3 |     |        |        | "Ball In Play"  |
| 19         | 4             | $0C  | LABEL_BALL_LINE4 |     |        |        | "Ball In Play"  |
| 20         | 5             | $0C  | LABEL_BALL_LINE5 |     |        |        | "Ball In Play"  |
| 21         | 6             | $0C  | LABEL_BALL_LINE6 |     |        |        | "Ball In Play"  |
| 22         | 7             | $0C  | LABEL_BALL_LINE7 |     |        |        | "Ball In Play"  |
| 23         | 8             | $00  |                  |     |        |        | Blank Line  |
|            |               | JMP  |                  |     |        |        | Jump to RETURN_END_TOP_BORDER |

**BOTTOM BORDER (or Paddle - No Bottom Border)**

| Scan Lines | Display Lines | Mode | LMS         | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ----        | --- | ------ | ------ | ----- |
|            |               |      |             |     |        |        | DISPLAY_LIST_BOTTOM_BORDER |
| 212 - 213  | 197 - 198     | $0B  | BORDER_LINE |     |        |        | Bottom Border |
| 214 - 215  | 199 - 200     | $0B  | BORDER_LINE |     |        |        | Bottom Border |
| 216 - 217  | 201 - 202     | $0B  | BORDER_LINE |     |        |        | Bottom Border |
| 218 - 219  | 203 - 204     | $0B  | BORDER_LINE | Y   | X      | X      | Bottom Border - DLI Return COLPF0, COLPF3 to White/$0C |
|            |               | JMP  |             |     |        |        | Jump to RETURN_END_BOTTOM_BORDER |

**OR NO BOTTOM BORDER (Paddle)**

| Scan Lines | Display Lines | Mode | LMS  | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ---- | --- | ------ | ------ | ----- |
|            |               |      |      |     |        |        | DISPLAY_LIST_BOTTOM_NO_BORDER |
| 212 - 219  | 197 - 204     | $70  |      | Y   | X      | X      | 8 Blank Lines - DLI Return COLPF0, COLPF3 to White/$0C |
|            |               | JMP  |      |     |        |        | Jump to RETURN_END_BOTOM_BORDER |


=============================================================================

**PREVIOUS Section 05: Test Screen**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README05TestScreen.md )


**NEXT Section 07: Title Screen**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md )

=============================================================================

**Back To Beginning**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md )
