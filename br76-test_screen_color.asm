; --------------------------------------------------------------------
; 6502 assembly on Atari.
; Built with eclipse/wudsn/atasm.

; Create a test screen simulating the proposed Breakout76 screen 
; geometry.  Everything in drawn using map mode graphics rather
; than any special bells and whistles proposed for the actual 
; game implementation. Implement DLIs to simulate the color 
; provided by color plastic overlays in the original game.
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
; with graphics or display list alignment.
; Even the most convoluted display list will not exceed 1K.

	mAlign 1024

DISPLAY_LIST

; Overscan 0 - 15
	.byte DL_BLANK_8
	.byte DL_BLANK_8

; Start screen, 8 lines of top border.
; Map mode B is 2 scan lines.
; screen Lines 0 to 7.
	.rept 4 ; 4 * mode B (2 scan lines) is 8 scan lines
	mDL_LMS DL_MAP_B, SCREEN_BORDER
	.endr

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

	.rept 3 ; middle 3 rows are same shape
	mDL_LMS DL_MAP_C, SCREEN_TOP_ZERO2
	mDL_LMS DL_MAP_B, SCREEN_TOP_ZERO2
	.endr

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

	.rept 3 ; middle 3 rows are same shape
	mDL_LMS DL_MAP_C, SCREEN_SCORE_ZERO2
	mDL_LMS DL_MAP_B, SCREEN_SCORE_ZERO2
	.endr

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
; 2, Lines 44 - 47
; 3, Lines 48 - 51
; 4, Lines 52 - 55
; 5, Lines 56 - 59
; 6, Lines 61 - 64
; 7, Lines 65 - 68
; 8, Lines 69 - 71

	.rept 4 ;; 8 rows of bricks
	mDL_LMS DL_MAP_C|DL_DLI, SCREEN_PLAYFIELD ; plus DLI to set color
	mDL_LMS DL_MAP_C, SCREEN_BRICKS
	mDL_LMS DL_MAP_B, SCREEN_BRICKS
	mDL_LMS DL_MAP_C, SCREEN_PLAYFIELD 
	mDL_LMS DL_MAP_C, SCREEN_BRICKS
	mDL_LMS DL_MAP_B, SCREEN_BRICKS
	.endr
	
; One line for DLI to return to normal screen color.
; Line 72 - 73
	mDL_LMS DL_MAP_B|DL_DLI, SCREEN_PLAYFIELD

; Many lines of blank playfield.  
; If the borders were Player/Missiles then map modes
; would not even be needed.  These could be done by 
; blank line instructions.
; Lines 74 to 195
	.rept 60 ;; repeat 60 times
	mDL_LMS DL_MAP_B, SCREEN_PLAYFIELD
	.endr

; Line with DLI to set blue for paddle border.
; Line 196 - 197
	mDL_LMS DL_MAP_B|DL_DLI, SCREEN_PLAYFIELD
	
; Drawn another border area the paddle.
; This one six scan lines tall.
; Lines 198 - 203
	mDL_LMS DL_MAP_B, SCREEN_BORDER
	mDL_LMS DL_MAP_B, SCREEN_BORDER
	mDL_LMS DL_MAP_B|DL_DLI, SCREEN_BORDER ; And return to normal colors.

; Last four lines under paddle
; Lines 204 - 207
	mDL_LMS DL_MAP_B, SCREEN_PLAYFIELD
	mDL_LMS DL_MAP_B, SCREEN_PLAYFIELD

; Display List End
	.byte DL_JUMP_VB
	.word DISPLAY_LIST
	
; ***************** SCREEN DATA *****************

; Narrow screen width only needs 16 bytes per line for Modes B and C. 
;
; Since screen memory is 16 bytes per line which is a nice divisor into 
; page size of 256 bytes we know the screen memory data will not cross
; a 4K boundary mid-line.
;
; Therefore, it is safe to force alignment to a page rather than 4K.

	mAlign 256

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

; And that's it -- data loaded from file. 
; Most of the Graphics/display created with no real code executed.

; --------------------------------------------------------------------

; Align to page, so all the DLIs have the same high byte.

	mAlign 256
	
; RED BRICKS
DLI_1
	pha
	lda #$42 ; $34
	sta WSYNC
	sta COLPF0
	lda #<DLI_2
	sta VDSLST
	pla
	rti

; ORANGE BRICKS
DLI_2
	pha
	lda #$28
	sta WSYNC
	sta COLPF0
	lda #<DLI_3
	sta VDSLST
	pla
	rti	
	 
; GREEN BRICKS
DLI_3
	pha
	lda #$C4 ; $B4
	sta WSYNC
	sta COLPF0
	lda #<DLI_4
	sta VDSLST
	pla
	rti	

; YELLOW BRICKS
DLI_4
	pha
	lda #$1A ; $FC
	sta WSYNC
	sta COLPF0
	lda #<DLI_5
	sta VDSLST
	pla
	rti	

; RETURN TO WHITE
DLI_5
	pha
	lda #$0C
	sta WSYNC
	sta COLPF0
	lda #<DLI_6
	sta VDSLST
	pla
	rti	

; BLUE PADDLE
DLI_6
	pha
	lda #$96
	sta WSYNC
	sta COLPF0
	lda #<DLI_7
	sta VDSLST
	pla
	rti	

; RETURN TO WHITE
DLI_7
	pha
	lda #$0C
	sta WSYNC
	sta COLPF0
	lda #<DLI_1
	sta VDSLST
	pla
	rti	


; --------------------------------------------------------------------
; Vertical Blank Interrupt

Breakout_VBI

; Force clean start to DLI
	mLoadIntP VDSLST, DLI_1
	
; Finito.
	jmp XITVBV


; --------------------------------------------------------------------

PRG_START
; Start the display.  (Note this is a hacky, not especially safe way to startup.)

; Set new Display List address
; SDLSTL = $0230 ; OS Shadow register for ANTIC's DLISTL (Display List Address)
	mLoadIntP SDLSTL, DISPLAY_LIST

; Set DLI staring address.
	mLoadIntP VDSLST, DLI_1
	
	lda #ENABLE_DL_DMA|PLAYFIELD_WIDTH_NARROW ; Set DMA control. (Screen DMA on + narrow width.)
	sta SDMCTL ; SDMCTL = $022F ; OS Shadow register for ANTIC's DMACTL (Display DMA Control)

	lda #$0C   ; Set COLOR0 to light white. 
	sta COLOR0 ; COLOR0  ; OS Sharow register for Playfield color register 0.

    ; Set the VBI
	ldy #<Breakout_VBI ; LSB for routine
	ldx #>Breakout_VBI ; MSB for routine
	lda #7 ; Set Interrupt Vector 7 for Deferred VBI
	jsr SETVBV  ; and away we go.

	lda #[NMI_DLI|NMI_VBI] ; Set DLI and VBI Interrupt flags ON
	sta NMIEN

Do_While_More_Electricity         ; Infinite loop, otherwise the
	jmp Do_While_More_Electricity ; program returns to DOS immediately.

; --------------------------------------------------------------------
; Store the program start location in the Atari DOS RUN Address.
; When DOS is done loading the executable file into memory it will 
; automatically jump to the address placed here in DOS_RUN_ADDR.

; DOS_RUN_ADDR =  $02e0 ; Execute at address stored here when file loading completes.

	mDiskDPoke DOS_RUN_ADDR, PRG_START

; --------------------------------------------------------------------
	.end ; finito
