; --------------------------------------------------------------------
; 6502 assembly on Atari.
; Built with eclipse/wudsn/atasm.

; Create a test screen simulating the proposed Breakout76 screen 
; geometry.  Everything in drawn using map mode graphics rather
; than any special bells and whistles proposed for the actual 
; game implementation. 
; --------------------------------------------------------------------

;===============================================================================
;   ATARI SYSTEM INCLUDES
;===============================================================================
; Various Include files that provide equates defining 
; registers and the values used for the registers:
;
	.include "ANTIC.asm" 
	.include "GTIA.asm"
	.include "POKEY.asm"
	.include "PIA.asm"
	.include "OS.asm"
	.include "DOS.asm" ; This provides the LOMEM, start, and run addresses.

	.include "macros.asm"
	
; --------------------------------------------------------------------
; LOMEM_DOS_DUP = $3308 ; First usable memory after DOS and DUP 

	*=LOMEM_DOS_DUP ; Start "program" after DOS and DUP 


; ***************** DISPLAY LIST *****************

; Forcing start to a boundary guarantees there is no problem 
; graphics or display list alignment.
; Even the most convoluted display list will not exceed 1K.

	mAlign 1024

DISPLAY_LIST

; Overscan 0 - 15
	.byte DL_BLANK_8
	.byte DL_BLANK_8

; Start screen, 8 lines of top border.
; Map mode B is 2 scan lines.
; screen Lines 0 to 7.
	mDL_LMS DL_MAP_B, SCREEN_BORDER
	mDL_LMS DL_MAP_B, SCREEN_BORDER
	mDL_LMS DL_MAP_B, SCREEN_BORDER
	mDL_LMS DL_MAP_B, SCREEN_BORDER

; Squeeze in one playfield line as separator.
; Map Mode C is one scan line. 
; Line 8
	mDL_LMS DL_MAP_C, SCREEN_PLAYFIELD

; 15 lines of "Zero" text.  
; i.e 3x5 matrix.  Each "pixel" is 3 scanlines tall.
; lines 9 - 23
; "three" is one line of 1 scanlines and 1 line of 2 scanlines
	mDL_LMS DL_MAP_C, SCREEN_TOP_ZERO1
	mDL_LMS DL_MAP_B, SCREEN_TOP_ZERO1

	mDL_LMS DL_MAP_C, SCREEN_TOP_ZERO2
	mDL_LMS DL_MAP_B, SCREEN_TOP_ZERO2

	mDL_LMS DL_MAP_C, SCREEN_TOP_ZERO2
	mDL_LMS DL_MAP_B, SCREEN_TOP_ZERO2

	mDL_LMS DL_MAP_C, SCREEN_TOP_ZERO2
	mDL_LMS DL_MAP_B, SCREEN_TOP_ZERO2

	mDL_LMS DL_MAP_C, SCREEN_TOP_ZERO1
	mDL_LMS DL_MAP_B, SCREEN_TOP_ZERO1

; Squeeze in one playfield line as separator.
; Map Mode C is one scan line. 
; Line 24
	mDL_LMS DL_MAP_C, SCREEN_PLAYFIELD

; 15 lines of "Score" text.  
; i.e 3x5 matrix.  Each "pixel" is 3 scanlines tall.
; lines 25 - 38
; "three" is one line of 1 scanlines and 1 line of 2 scanlines
	mDL_LMS DL_MAP_C, SCREEN_SCORE_ZERO1
	mDL_LMS DL_MAP_B, SCREEN_SCORE_ZERO1

	mDL_LMS DL_MAP_C, SCREEN_SCORE_ZERO2
	mDL_LMS DL_MAP_B, SCREEN_SCORE_ZERO2

	mDL_LMS DL_MAP_C, SCREEN_SCORE_ZERO2
	mDL_LMS DL_MAP_B, SCREEN_SCORE_ZERO2

	mDL_LMS DL_MAP_C, SCREEN_SCORE_ZERO2
	mDL_LMS DL_MAP_B, SCREEN_SCORE_ZERO2

	mDL_LMS DL_MAP_C, SCREEN_SCORE_ZERO1
	mDL_LMS DL_MAP_B, SCREEN_SCORE_ZERO1

; Squeeze in one playfield line as separator.
; Map Mode C is one scan line. 
; Line 39
	mDL_LMS DL_MAP_C, SCREEN_PLAYFIELD

; Eight lines of bricks.  
; Bricks are 3 scan lines + 1 scan line separator
; Lines 40 - 70

; 1, Lines 40 - 43
	mDL_LMS DL_MAP_C, SCREEN_BRICKS
	mDL_LMS DL_MAP_B, SCREEN_BRICKS
	mDL_LMS DL_MAP_C, SCREEN_PLAYFIELD

; 2, Lines 44 - 47
	mDL_LMS DL_MAP_C, SCREEN_BRICKS
	mDL_LMS DL_MAP_B, SCREEN_BRICKS
	mDL_LMS DL_MAP_C, SCREEN_PLAYFIELD

; 3, Lines 48 - 51
	mDL_LMS DL_MAP_C, SCREEN_BRICKS
	mDL_LMS DL_MAP_B, SCREEN_BRICKS
	mDL_LMS DL_MAP_C, SCREEN_PLAYFIELD

; 4, Lines 52 - 55
	mDL_LMS DL_MAP_C, SCREEN_BRICKS
	mDL_LMS DL_MAP_B, SCREEN_BRICKS
	mDL_LMS DL_MAP_C, SCREEN_PLAYFIELD

; 5, Lines 56 - 59
	mDL_LMS DL_MAP_C, SCREEN_BRICKS
	mDL_LMS DL_MAP_B, SCREEN_BRICKS
	mDL_LMS DL_MAP_C, SCREEN_PLAYFIELD

; 6, Lines 61 - 64
	mDL_LMS DL_MAP_C, SCREEN_BRICKS
	mDL_LMS DL_MAP_B, SCREEN_BRICKS
	mDL_LMS DL_MAP_C, SCREEN_PLAYFIELD

; 7, Lines 65 - 68
	mDL_LMS DL_MAP_C, SCREEN_BRICKS
	mDL_LMS DL_MAP_B, SCREEN_BRICKS
	mDL_LMS DL_MAP_C, SCREEN_PLAYFIELD
	
; 8, Lines 69 - 71
	mDL_LMS DL_MAP_C, SCREEN_BRICKS
	mDL_LMS DL_MAP_B, SCREEN_BRICKS
	
; Many lines of blank playfield.  
; If the borders were Player/Missiles then map modes
; would not even be needed.  These could be done by 
; blank lines.

; Lines 72 to 197
	.rept 62 ;; repeat 62 times
	mDL_LMS DL_MAP_B, SCREEN_PLAYFIELD
	.endr

; Drawn another border area the paddle.
; This one six scan lines tall.
; Lines 198 - 203
	mDL_LMS DL_MAP_B, SCREEN_BORDER
	mDL_LMS DL_MAP_B, SCREEN_BORDER
	mDL_LMS DL_MAP_B, SCREEN_BORDER

; Last four lines under paddle
; Lines 204 - 207
	mDL_LMS DL_MAP_B, SCREEN_PLAYFIELD
	mDL_LMS DL_MAP_B, SCREEN_PLAYFIELD

; Display List End
	.byte DL_JUMP_VB
	.word DISPLAY_LIST
	
; ***************** SCREEN DATA *****************

; Force to start of next page.  Since narrow screen width is 
; used the lines are multiples of base 2 numbers (16 actual bytes) 
; and will not cross a 4K boundary.

	mAlign 256

SCREEN_EMPTY_LINE
	.dc 16 ~00000000

SCREEN_BORDER ; Solid horizontal border between left and right borders. 
	.byte ~00000000,~00000011 ; Left border
	.byte ~11111111,~11111111,~11111111,~11111111,~11111111,~11111111
	.byte ~11111111,~11111111,~11111111,~11111111,~11111111,~11111111,
	.byte ~11100000,~00000000, ; Last brick pixel and Right border

SCREEN_PLAYFIELD ; Open screen between Left and Right borders
	.byte ~00000000,~00000011 ; Left border
	.byte ~00000000,~00000000,~00000000,~00000000,~00000000,~00000000
	.byte ~00000000,~00000000,~00000000,~00000000,~00000000,~00000000,
	.byte ~01100000,~00000000, ; Last brick pixel and Right border

; Numbers are 3x5 blocks aligned to brick positions.
; To draw a zero only two shapes are needed.

; Below is zeros drawn for top line (player and ball counter)
SCREEN_TOP_ZERO1 ; 
	.byte ~00000000,~00000011 ; Left border
	.byte ~01111110,~00000000,~00000000,~00000000,~00000000,~00000000
	.byte ~00000000,~11111100,~00000000,~00000000,~00000000,~00000000,
	.byte ~01100000,~00000000, ; Last brick pixel and Right border 
SCREEN_TOP_ZERO2 ;
	.byte ~00000000,~00000011 ; Left border
	.byte ~01100110,~00000000,~00000000,~00000000,~00000000,~00000000
	.byte ~00000000,~11001100,~00000000,~00000000,~00000000,~00000000,
	.byte ~01100000,~00000000, ; Last brick pixel and Right border 
	
; Below is zeros drawn for scores
SCREEN_SCORE_ZERO1 ; 
	.byte ~00000000,~00000011 ; Left border
	.byte ~00000001,~11111011,~11110111,~11100000,~00000000,~00000000
	.byte ~00000000,~00000001,~11111011,~11110111,~11100000,~00000000,
	.byte ~01100000,~00000000, ; Last brick pixel and Right border
SCREEN_SCORE_ZERO2 ; 
	.byte ~00000000,~00000011 ; Left border
	.byte ~00000001,~10011011,~00110110,~01100000,~00000000,~00000000
	.byte ~00000000,~00000001,~10011011,~00110110,~01100000,~00000000,
	.byte ~01100000,~00000000, ; Last brick pixel and Right border
	
SCREEN_BRICKS ; 14 bricks between left and right borders 
	.byte ~00000000,~00000011 ; Left border
	.byte ~11111101,~11111011,~11110111,~11101111,~11011111,~10111111
	.byte ~01111110,~11111101,~11111011,~11110111,~11101111,~11011111,
	.byte ~11100000,~00000000, ; Last brick pixel and Right border
	

; --------------------------------------------------------------------
; Yup, This is all the "program" there is. 3 bytes of JMP

PRG_START

Do_While_More_Electricity         ; Infinite loop, otherwise the
	jmp Do_While_More_Electricity ; program returns to DOS immediately.

; --------------------------------------------------------------------
; Start the display.  Narrow screen width only needs
; 16 bytes per line for Modes B and C.

; SDMCTL = $022F ; OS Shadow register for ANTIC's DMACTL (Display DMA Control)
; SDLSTL = $0230 ; OS Shadow register for ANTIC's DLISTL (Display List Address)

; And that's it -- data loaded from file. Graphics with no real code.
	
	*=SDLSTL  ; Set new Display List address
	.word DISPLAY_LIST
	
	*=SDMCTL  ; Set DMA control. (Screen DMA on + narrow width.)
	.byte ENABLE_DL_DMA|PLAYFIELD_WIDTH_NARROW

	*=COLOR0  ;  Playfield color register 0.
	.byte $0C  ; light white.

; --------------------------------------------------------------------
; Store the program start location in the Atari DOS RUN Address.
; When DOS is done loading the executable file into memory it will 
; automatically jump to the address placed here in DOS_RUN_ADDR.

; DOS_RUN_ADDR =  $02e0 ; Execute at address stored here when file loading completes.

	*=DOS_RUN_ADDR
	.word PRG_START

; --------------------------------------------------------------------
	.end ; finito
