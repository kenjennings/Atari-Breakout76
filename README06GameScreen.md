# Atari-Breakout76 Game Screen

**GAME SCREEN**

The details of Game Screen arrangment:

Single Line resolution Player/Missile Graphics.
Use 5th player option to color all Missiles using COLPF3.
Missile0 is Left Border.
Missile1 is Right Border.
Missile2 is Ball.
Player0 is Paddle.

Top Border, External Label Text, Numbers/Scores, Bricks, and Bottom Border uses ANTIC Modes B or C graphics and only COLPF0.

Paddle/COLPM0 is Blue/$96. 

VBI Establishes:
ANTIC Display Width Narrow + Playfield DMA + Player/Missile DMA.
GTIA GRACTL control for Player/Missile graphics.
COLPF3 is white/$0C

To "Flash" external labels simply set COLPF0 in the DLI to black/$00.

To "Flash" Scores, Player Number, or Ball counter the image must be drawn and erased, since each shares the same line with another value that may not be flashing.

The Scores, Ball counter, and Player number are actually 3x5 "segments".  Each "segment" is vertically 3 scanlines tall. This is accomplished by one Mode C and one mode B instructions using LMS to reference the same graphics memeory.


| Scan Lines | Display Lines | Mode | LMS  | DLI | COLPF0 | COLPF3 | Notes |
| ---------- | ------------- | ---- | ---- | --- | ------ | ------ | ----- |
| **TOP SPACING**  |
| 0 - 7      |               | $70  |      |     |        |        | Necessary Spacing | 
| 8 - 15     |               | $70  |      |  Y  |    X   |        | DLI set COLPF0 to White/$0C or Yellow/$1A or black/$00 depending on state of Border or Labels |
| **TOP BORDER**
| JMP |   |   |   |   |   |   | Jump to DISPLAY_LIST_BORDER |
| 16 - 17   | 1 - 2  | $0B | BORDER_LINE |  |  |  | Top Border |
| 18 - 19   | 3 - 4  | $0B | BORDER_LINE |  |  |  | Top Border |
| 20 - 21   | 5 - 6  | $0B | BORDER_LINE |  |  |  | Top Border |
| 22 - 23   | 7 - 8  | $0B | BORDER_LINE |  |  |  | Top Border |
| JMP       |   |   |   |   |   |   | Jump to RETURN_END_TOP_BORDER |
| **OR EXTERNAL LABELS - PLAYER NUMBER**
| JMP  |   |   |   |   |   |   | Jump to DISPLAY_LIST_PLAYER_LABEL |
| 16   | 1   | $0C | LABEL_PLAYER_LINE1 |  |  |  | Player Number  |
| 17   | 2   | $0C | LABEL_PLAYER_LINE2 |  |  |  | Player Number  |
| 18   | 3   | $0C | LABEL_PLAYER_LINE3 |  |  |  | Player Number  |
| 19   | 4   | $0C | LABEL_PLAYER_LINE4 |  |  |  | Player Number  |
| 20   | 5   | $0C | LABEL_PLAYER_LINE5 |  |  |  | Player Number  |
| 21   | 6   | $0C | LABEL_PLAYER_LINE6 |  |  |  | Player Number  |
| 22   | 7   | $0C | LABEL_PLAYER_LINE7 |  |  |  | Player Number  |
| 23   | 8   | $00 |  |  |  |  | Blank Line  |
| JMP  |   |   |   |   |   |   | Jump to RETURN_END_TOP_BORDER |
| **OR EXTERNAL LABELS - BALL IN PLAY**
| JMP |   |   |   |   |   |   | Jump to DISPLAY_LIST_BALL_LABEL |
| 16   | 1   | $0C | LABEL_BALL_LINE1 |  |  |  | Ball Number  |
| 17   | 2   | $0C | LABEL_BALL_LINE2 |  |  |  | Ball Number  |
| 18   | 3   | $0C | LABEL_BALL_LINE3 |  |  |  | Ball Number  |
| 19   | 4   | $0C | LABEL_BALL_LINE4 |  |  |  | Ball Number  |
| 20   | 5   | $0C | LABEL_BALL_LINE5 |  |  |  | Ball Number  |
| 21   | 6   | $0C | LABEL_BALL_LINE6 |  |  |  | Ball Number  |
| 22   | 7   | $0C | LABEL_BALL_LINE7 |  |  |  | Ball Number  |
| 23   | 8   | $00 |  |  |  |  | Blank Line  |
| JMP       |   |   |   |   |   |   | Jump to RETURN_END_TOP_BORDER |
| **RETURN_END_TOP_BORDER** |
| 24   | 9   | $00 |  |  | X |  | Blank Line - DLI Return COLPF0 to White/$0C |
| **PLAYER AND BALL NUMBERS**
| 25       | 10      | $0C | PLAYER_AND_BALL_LINE1 |  |  |  | Segment 1, Player And Ball Display  |
| 26 - 27  | 11 - 12 | $0B | PLAYER_AND_BALL_LINE1 |  |  |  | Segment 1, Player And Ball Display  |
| 28       | 13      | $0C | PLAYER_AND_BALL_LINE2 |  |  |  | Segment 2, Player And Ball Display  |
| 29 - 30  | 14 - 15 | $0B | PLAYER_AND_BALL_LINE2 |  |  |  | Segment 2, Player And Ball Display  |
| 31       | 16      | $0C | PLAYER_AND_BALL_LINE3 |  |  |  | Segment 3, Player And Ball Display  |
| 32 - 33  | 17 - 18 | $0B | PLAYER_AND_BALL_LINE3 |  |  |  | Segment 3, Player And Ball Display  |
| 34       | 19      | $0C | PLAYER_AND_BALL_LINE4 |  |  |  | Segment 4, Player And Ball Display  |
| 35 - 36  | 20 - 21 | $0B | PLAYER_AND_BALL_LINE4 |  |  |  | Segment 4, Player And Ball Display  |
| 37       | 22      | $0C | PLAYER_AND_BALL_LINE5 |  |  |  | Segment 5, Player And Ball Display  |
| 38 - 39  | 23 - 24 | $0B | PLAYER_AND_BALL_LINE5 |  |  |  | Segment 5, Player And Ball Display  |
| 40       | 25      | $00 |  |  |  |  | Blank Line  |
| **SCORES**
| 41       | 26      | $0C | SCORES_LINE1 |  |  |  | Segment 1, Scores Display  |
| 42 - 43  | 27 - 28 | $0B | SCORES_LINE1 |  |  |  | Segment 1, Scores Display  |
| 44       | 29      | $0C | SCORES_LINE2 |  |  |  | Segment 2, Scores Display  |
| 45 - 46  | 30 - 31 | $0B | SCORES_LINE2 |  |  |  | Segment 2, Scores Display  |
| 47       | 32      | $0C | SCORES_LINE3 |  |  |  | Segment 3, Scores Display  |
| 48 - 49  | 33 - 34 | $0B | SCORES_LINE3 |  |  |  | Segment 3, Scores Display  |
| 50       | 35      | $0C | SCORES_LINE4 |  |  |  | Segment 4, Scores Display  |
| 51 - 52  | 36 - 37 | $0B | SCORES_LINE4 |  |  |  | Segment 4, Scores Display  |
| 53       | 38      | $0C | SCORES_LINE5 |  |  |  | Segment 5, Scores Display  |
| 54 - 55  | 39 - 40 | $0B | SCORES_LINE5 |  |  |  | Segment 5, Scores Display  |
| 56 - 57  | 41 - 42 | $10 |  | Y | X | X | 2 Blank Lines - DLI Set COLPF0, COLPF3 to Red/$42 |
| **BRICKS**
| 58       | 43      | $0C | BRICKS_LINE1 |  |  |  | Red Bricks row 1  |
| 59 - 60  | 44 - 45 | $0B | BRICKS_LINE1 |  |  |  | Red Bricks row 1  |
| 61       | 46      | $00 |     |     |     |     | Blank Line  |
| 62       | 47      | $0C | BRICKS_LINE2 |  |  |  | Red Bricks row 2  |
| 63 - 64  | 48 - 49 | $0B | BRICKS_LINE2 |  |  |  | Red Bricks row 2  |
| 65       | 50      | $00 |     |  Y  |  X  |  X  | Blank Line - DLI Set COLPF0, COLPF3 to Orange/$28  |
| 66       | 51      | $0C | BRICKS_LINE3 |  |  |  | Orange Bricks row 1  |
| 67 - 68  | 52 - 53 | $0B | BRICKS_LINE3 |  |  |  | Orange Bricks row 1  |
| 69       | 54      | $00 |     |     |     |     | Blank Line  |
| 70       | 55      | $0C | BRICKS_LINE4 |  |  |  | Orange Bricks row 2  |
| 71 - 72  | 56 - 57 | $0B | BRICKS_LINE5 |  |  |  | Orange Bricks row 2  |
| 73       | 58      | $00 |     |  Y  |  X  |  X  | Blank Line - DLI Set COLPF0, COLPF3 to Green/$C4  |
| 74       | 59      | $0C | BRICKS_LINE5 |  |  |  | Green Bricks row 1  |
| 75 - 76  | 60 - 61 | $0B | BRICKS_LINE5 |  |  |  | Green Bricks row 1  |
| 77       | 62      | $00 |     |     |     |     | Blank Line  |
| 78       | 63      | $0C | BRICKS_LINE6 |  |  |  | Green Bricks row 2  |
| 79 - 80  | 64 - 65 | $0B | BRICKS_LINE6 |  |  |  | Green Bricks row 2  |
| 81       | 66      | $00 |     |  Y  |  X  |  X  | Blank Line - DLI Set COLPF0, COLPF3 to Yellow/$1A  |
| 82       | 67      | $0C | BRICKS_LINE7 |  |  |  | Yellow Bricks row 1  |
| 83 - 84  | 68 - 69 | $0B | BRICKS_LINE7 |  |  |  | Yellow Bricks row 1  |
| 85       | 70      | $00 |     |     |     |     | Blank Line  |
| 86       | 71      | $0C | BRICKS_LINE8 |  |  |  | Yellow Bricks row 2  |
| 87 - 88  | 72 - 73 | $0B | BRICKS_LINE8 | Y | X | X | Yellow Bricks row 2 - DLI Set COLPF0, COLPF3 to White/$0C |
| **EMPTY PLAYFIELD**
| 89 - 96    | 74 - 81   | $70 |     |    |     |     | 8 Blank Lines -- 123 total  |
| 97 - 104   | 82 - 89   | $70 |     |    |     |     | 8 Blank Lines  |
| 105 - 112  | 90 - 97   | $70 |     |    |     |     | 8 Blank Lines  |
| 113 - 120  | 98 - 105  | $70 |     |    |     |     | 8 Blank Lines  |
| 121 - 128  | 106 - 113 | $70 |     |    |     |     | 8 Blank Lines  |
| 129 - 136  | 114 - 121 | $70 |     |    |     |     | 8 Blank Lines  |
| 137 - 144  | 122 - 129 | $70 |     |    |     |     | 8 Blank Lines  |
| 145 - 152  | 130 - 137 | $70 |     |    |     |     | 8 Blank Lines  |
| 153 - 160  | 138 - 145 | $70 |     |    |     |     | 8 Blank Lines  |
| 161 - 168  | 146 - 153 | $70 |     |    |     |     | 8 Blank Lines  |
| 169 - 176  | 154 - 161 | $70 |     |    |     |     | 8 Blank Lines  |
| 177 - 184  | 162 - 169 | $70 |     |    |     |     | 8 Blank Lines  |
| 185 - 192  | 170 - 177 | $70 |     |    |     |     | 8 Blank Lines  |
| 193 - 200  | 178 - 185 | $70 |     |    |     |     | 8 Blank Lines  |
| 201 - 208  | 186 - 193 | $70 |     |    |     |     | 8 Blank Lines  |
| 209 - 211  | 194 - 196 | $20 |     | Y  |  X  |  X  | 8 Blank Lines -- 123 total - DLI Set COLPF0, COLPF3 to Blue/$96 |
| **PADDLE-BOTTOM BORDER**
| JMP |   |   |   |   |   |   | Jump to DISPLAY_LIST_BOTTOM_BORDER |
| 212 - 213   | 197 - 198  | $0B | BORDER_LINE |  |  |  | Bottom Border |
| 214 - 215   | 199 - 200  | $0B | BORDER_LINE |  |  |  | Bottom Border |
| 216 - 217   | 201 - 202  | $0B | BORDER_LINE |  |  |  | Bottom Border |
| 218 - 219   | 203 - 204  | $0B | BORDER_LINE | Y | X | X | Bottom Border - DLI Return COLPF0, COLPF3 to White/$0C |
| JMP         |   |   |   |   |   |   | Jump to RETURN_END_BOTOM_BORDER |
| **OR NO BORDER**
| JMP         |   |   |   |   |   |   | Jump to DISPLAY_LIST_BOTTOM_NO_BORDER |
| 212 - 219   | 197 - 204  | $70 | BORDER_LINE | Y | X | X | 8 Blank Lines - DLI Return COLPF0, COLPF3 to White/$0C |
| JMP         |   |   |   |   |   |   | Jump to RETURN_END_BOTOM_BORDER |
| **RETURN_END_BOTTOM_BORDER** |
| **THE END**
| 220 - 223  | 205 - 208   | $30 |  |  |  |  | 4 Blank Lines |
| JVB        |   |   |   |   |   |   | Jump Vertical Blank |


=============================================================================

**PREVIOUS Section 05: Test Screen**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README05TestScreen.md )


**NEXT Section 07: Title Screen**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md )

=============================================================================

**Back To Beginning**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md )
