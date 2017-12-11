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
| 8 - 15      |               | $70  |      |  Y  |    X   |        | DLI set COLPF0 to white/$0C or yellow/$1A or black/$00 depending on state of Border or Labels |
| **TOP BORDER**
| JMP |   |   |   |   |   |   | Jump to DISPLAY_LIST_BORDER |
| 16 - 17   | 1 - 2  | $0B | BORDER_LINE |  |  |  | Border |
| 18 - 19   | 3 - 4  | $0B | BORDER_LINE |  |  |  | Border |
| 20 - 21   | 5 - 6  | $0B | BORDER_LINE |  |  |  | Border |
| 22 - 23   | 7 - 8  | $0B | BORDER_LINE |  |  |  | Border |
| JMP       |   |   |   |   |   |   | Jump to RETURN_END_TOP_BORDER |
| **OR EXTERNAL LABELS - PLAYER NUMBER**
| JMP |   |   |   |   |   |   | Jump to DISPLAY_LIST_PLAYER_LABEL |
| 16   | 1   | $0C | LABEL_PLAYER_LINE1 |  |  |  | Player Number  |
| 17   | 2   | $0C | LABEL_PLAYER_LINE2 |  |  |  | Player Number  |
| 18   | 3   | $0C | LABEL_PLAYER_LINE3 |  |  |  | Player Number  |
| 19   | 4   | $0C | LABEL_PLAYER_LINE4 |  |  |  | Player Number  |
| 20   | 5   | $0C | LABEL_PLAYER_LINE5 |  |  |  | Player Number  |
| 21   | 6   | $0C | LABEL_PLAYER_LINE6 |  |  |  | Player Number  |
| 22   | 7   | $0C | LABEL_PLAYER_LINE7 |  |  |  | Player Number  |
| 23   | 8   | $00 |  |  |  |  | Blank Line  |
| JMP       |   |   |   |   |   |   | Jump to RETURN_END_TOP_BORDER |
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
| RETURN_END_TOP_BORDER |
| 24   | 9   | $00 |  |  | X |  | Blank Line - DLI Return COLPF0 to white/$0C |
| **PLAYER AND BALL NUMBERS**
| 25   | 10   | $0C | PLAYER_AND_BALL_LINE1 |  |  |  | Segment 1, Player And Ball Display  |
| 26 - 27   | 11 - 12   | $0B | PLAYER_AND_BALL_LINE1 |  |  |  | Segment 1, Player And Ball Display  |
| 28   | 13   | $0C | PLAYER_AND_BALL_LINE2 |  |  |  | Segment 2, Player And Ball Display  |
| 29 - 30   | 14 - 15   | $0B | PLAYER_AND_BALL_LINE2 |  |  |  | Segment 2, Player And Ball Display  |




 Red           = $42           
 Orange        = $28           
 Green          = $C4           
 Yellow         = $1A           



=============================================================================

**PREVIOUS Section 05: Test Screen**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README05TestScreen.md )


**NEXT Section 07: Title Screen**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md )

=============================================================================

**Back To Beginning**
- ( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md )
