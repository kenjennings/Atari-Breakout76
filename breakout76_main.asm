;===============================================================================
; Breakout Arcade -- 1976
; Conceptualized by Nolan Bushnell and Steve Bristow.
; Built by Steve Wozniak.
; https://en.wikipedia.org/wiki/Breakout_(video_game)
;===============================================================================
; Ten thousand Breakout clones written
; by variable quality of programmers over
; the intervening 40 years....
;===============================================================================
; Here is yet another lame clone of Breakout 
; written by an idiot.....
;===============================================================================
; Breakout76 -- 2017
; Written by Ken Jennings
; Build for Atari using eclipse/wudsn/atasm on linux
; Source at:
; Github: https://github.com/kenjennings/Atari-Breakout76
; Google Drive: https://drive.google.com/drive/folders/
;===============================================================================

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

;===============================================================================
;   ENABLE/DISABLE PARTS
;===============================================================================

USE_BREAKOUT_TITLE=1
;USE_BREAKOUT_SCORE=1
;USE_BREAKOUT_THUMPER=1
;USE_BREAKOUT_BALL=1
;USE_BREAKOUT_BRICK=1
;USE_BREAKOUT_SCROLLER=1
;USE_BREAKOUT_PADDLE=1
;USE_BREAKOUT_SOUND=1
;USE_BREAKOUT_GAME=1

;===============================================================================
; ****   ******   **    *****
; ** **    **    ****  **  
; **  **   **   **  ** **
; **  **   **   **  ** ** ***
; ** **    **   ****** **  **
; ****   ****** **  **  *****
;===============================================================================

;	.include "diagnostics.asm"

;===============================================================================
;   ENABLE/DISABLE DIAGNOSTIC PARTS - only one at a time
;===============================================================================

DIAG_TITLE=1
;DIAG_SCORE=1
;DIAG_THUMPER=1
;DIAG_BALL=1
;DIAG_BRICK=1
;DIAG_SCROLLER=1
;DIAG_PADDLE=1
;DIAG_SOUND=1
;DIAG_GAME=1

DO_DIAG=1 ; set 0 when no Diagostics.  1 if a Diagnostic is enabled set.

;===============================================================================
;   VARIOUS CONSTANTS AND LIMITS
;===============================================================================
; Let's define some useful offsets and sizes. 
; Could become useful somewhere else.
;
	.include "constants.asm"

;===============================================================================
;    PAGE ZERO VARIABLES
;===============================================================================
; Instructions referencing page 0 are shorter and usually faster.
; These locations can help shorten the code by putting 
; most frequently used values.  There are not a lot of available 
; locations, so tables of values are probably wasteful.
; This is also a convenient place to use when the code needs to 
; pass extra parameters to routines when you can't use A, X, Y 
; registers for other reasons.  Essentially, think of these as 
; extra data registers.
;
; The Atari OS has defined purpose for the first half of Page Zero 
; locations.  Since no Floating Point will be used here we'll 
; borrow everything in the second half of Page Zero.
; If none of the OS graphics routines are used the $80 start 
; may be rolled down into the first half of the page. Addresses TBD.
;
;===============================================================================
;
; Zero Page fun.  This is assembly, dude.  No BASIC in sight anywhere.
; No BASIC means we can get craaaazy with the second half of Page Zero.
;
; In fact, there's no need to have the regular game variables out in 
; high memory.  All the Byte-sized values are hereby moved to Page 0.
;
;===============================================================================

	*=$80

.if .def USE_BREAKOUT_TITLE
	.include "title_vars_pg0.asm"
.endif

.if .def USE_BREAKOUT_SCORE
	.include "score_vars_pg0.asm"
.endif

.if .def USE_BREAKOUT_THUMPER
	.include "thumper_vars_pg0.asm"
.endif

.if .def USE_BREAKOUT_BALL
	.include "ball_vars_pg0.asm"
.endif

.if .def USE_BREAKOUT_BRICK
	.include "brick_vars_pg0.asm"
.endif

.if .def USE_BREAKOUT_SCROLLER
	.include "scroller_vars_pg0.asm"
.endif

.if .def USE_BREAKOUT_PADDLE
	.include "paddle_vars_pg0.asm"
.endif

.if .def USE_BREAKOUT_SOUND
	.include "sound_vars_pg0.asm"
.endif

.if .def USE_BREAKOUT_GAME
	.include "game_vars_pg0.asm"
.endif


.if DO_DIAG
	.include "diag_vars_pg0.asm"
.endif

;===============================================================================
;   OTHER NON_PAGE ZERO, NON-ALIGNED VARIABLES
;===============================================================================

;	*=LOMEM_DOS     ; $2000  ; After Atari DOS 2.0s
;	*=LOMEM_DOS_DUP ; $3308  ; Alternatively, after Atari DOS 2.0s and DUP

; This will not be a terribly big or complicated game.  Begin after DOS/DUP.
; This will be forced again later for aligned values. 

	*= LOMEM_DOS_DUP

.if .def USE_BREAKOUT_TITLE
	.include "title_vars.asm"
.endif
.if .def USE_BREAKOUT_SCORE
	.include "score_vars.asm"
.endif
.if .def USE_BREAKOUT_THUMPER
	.include "thumper_vars.asm"
.endif

.if .def USE_BREAKOUT_BALL
	.include "ball_vars.asm"
.endif

.if .def USE_BREAKOUT_BRICK
	.include "brick_vars.asm"
.endif

.if .def USE_BREAKOUT_SCROLLER
	.include "scroller_vars.asm"
.endif

.if .def USE_BREAKOUT_PADDLE
	.include "paddle_vars.asm"
.endif

.if .def USE_BREAKOUT_SOUND
	.include "sound_vars.asm"
.endif

.if .def USE_BREAKOUT_GAME
	.include "game_vars.asm"
.endif


.if DO_DIAG
	.include "diag_vars.asm"
.endif

;===============================================================================
;   OTHER NON_PAGE ZERO, ALIGNED VARIABLES
;===============================================================================

	*= [[*-1]&$FF00-1]+$0100 	; Align to start of page
	.include "title_vars_align.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
;	.include "score_vars_align.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
;	.include "thumper_vars_align.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
;	.include "ball_vars_align.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
;	.include "brick_vars_align.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
;	.include "scroller_vars_align.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
;	.include "paddle_vars_align.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
;	.include "sound_vars_align.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
;	.include "game_vars_align.asm"

	*= [*&$FF00]+$0100 	; Align to start of page
	.include "diag_vars_align.asm"	


;===============================================================================
;	GAME INTERRUPT INCLUDES
;===============================================================================

;===============================================================================
; **  **  *****   ****** 
; **  **  **  **    **   
; **  **  *****     **   
; **  **  **  **    **   
;  ****   **  **    **   
;   **    *****   ******  
;===============================================================================

; MAIN directs things to happen. The magic of that happening is 
; (decided) here.  That is, much of the game guts, animation, and 
; timing either occurs here or is established here.  For the most 
; part, DLIs are only transferring values to registers per the
; directions determined here. 

;	.include "vbi.asm" ; Standard Set and Remove VBI routines

Breakout_VBI

	; Set initial display values to be certain everything begins 
	; at a known state with the title.

	lda #4     ; Horizontal fine scrolling. 
	sta HSCROL ; Title textline is shifted by HSCROLL to center it.
	
	; Force the initial DLI just in case one goes crazy and the 
	; DLI chaining gets messed up. 
	; This may be commented out when code is more final.
	
	lda #<DISPLAY_LIST_INTERRUPT ; DLI Vector
	sta VDSLST
	lda #>DISPLAY_LIST_INTERRUPT
	sta VDSLST+1

; ==============================================================
; MAINTAIN SUB-60 FPS TICKERS
; ==============================================================
	;
	; 30 FPS...  tick 0, 1, 0, 1, 0, 1...
	;
	inc V_30FPS_TICKER
	lda V_30FPS_TICKER
	and #~00000001
	sta V_30FPS_TICKER
	;
	; 20 FPS... tick 2, 1, 0, 2, 1, 0... a bit differently  
	;
	lda V_20FPS_TICKER
	bne Skip_20FPS_Reset
	lda #~00000100 ; #4  which becomes 2 in this iteration, then 1, then 0
Skip_20FPS_Reset
	lsr A 
	sta V_20FPS_TICKER
	;
	; 15 FPS... tick off 0, 1, 2, 3, 0, 1, 2, 3...
	;
	inc V_15FPS_TICKER
	lda V_15FPS_TICKER
	and #~00000011
	sta V_15FPS_TICKER
	;
	; 128 ticks per flag/approx 2 sec
	;
	inc V_LONG_DELAY
	lda V_LONG_DELAY
	and #~01111111
	sta V_LONG_DELAY
	
	
; ==============================================================
; TITLE FLY IN
; ==============================================================

Enter_Title_VBI
	.include "title_vbi.asm"
Exit_Title_VBI

; ==============================================================
; SCORES, and BALLS label and bouncing ball counter
; ==============================================================

Enter_Scores_VBI
;	.include "scores_vbi.asm"
Exit_Scores_VBI

; ==============================================================
; Thumper bumpers on top and left and right side
; ==============================================================

Enter_Thumper_VBI
;	.include "thumper_vbi.asm"
Exit_Thumper_VBI

; ==============================================================
; The Ball
; ==============================================================

Enter_Ball_VBI
;	.include "ball_vbi.asm"
Exit_Ball_VBI

; ==============================================================
; Bricks Scrolling
; ==============================================================

Enter_Brick_VBI
;	.include "brick_vbi.asm"
Exit_Brick_VBI

; ==============================================================
; Credit Scrolling
; ==============================================================

Enter_Scroller_VBI
;	.include "scroller_vbi.asm"
Exit_Scroller_VBI

; ==============================================================
; Paddle Movement, size, image
; ==============================================================

Enter_Paddle_VBI
;	.include "paddle_vbi.asm"
Exit_Paddle_VBI

; ==============================================================
; World's Cheesiest Sound Sequencer
; ==============================================================

Enter_Sound_VBI
;	.include "sound_vbi.asm"
Exit_Sound_VBI

;===============================================================================
; THE END OF USER DEFERRED VBI ROUTINES
;===============================================================================

Exit_VBI
; Finito.
	jmp XITVBV

	
	
	
;	.include "dli.asm"
;===============================================================================
; ****    **      ******  
; ** **   **        **   
; **  **  **        **   
; **  **  **        **   
; ** **   **        **   
; ****    ******  ******  
;===============================================================================

DISPLAY_LIST_INTERRUPT

.local
	.include "title_dli.asm"

?NEXT_DLI ; Previous DLI chains to this title







;===============================================================================
; ****    ******   ****   *****   **        **    **  **  
; ** **     **    **      **  **  **       ****   **  ** 
; **  **    **     ****   **  **  **      **  **   ****  
; **  **    **        **  *****   **      **  **    **   
; ** **     **        **  **      **      ******    **   
; ****    ******   ****   **      ******  **  **    **   
;===============================================================================

;===============================================================================
; PLAYER/MISSILE BITMAP MEMORY
;===============================================================================

; Must this be 2K or is 1K alignment good?

	*= [*&$F800]+$0800
	
; Using 2K boundary for single-line 
; resolution Player/Missiles
PLAYER_MISSILE_BASE
PMADR_MISSILE = [PLAYER_MISSILE_BASE+$300] ; Ball.                            Ball counter.
PMADR_BASE0 =   [PLAYER_MISSILE_BASE+$400] ; Flying text. Boom brick. Paddle. Ball Counter.
PMADR_BASE1 =   [PLAYER_MISSILE_BASE+$500] ;              Boom Brick. Paddle. Ball Counter.
PMADR_BASE2 =   [PLAYER_MISSILE_BASE+$600] ; Thumper.                 Paddle. Ball Counter.
PMADR_BASE3 =   [PLAYER_MISSILE_BASE+$700] ; Thumper.                 Paddle. Ball Counter.

; Reserve 2K. Move alignment after 2K Player/missile bitmaps.
; ( *= $8800 )
	*= [*&$F800]+$0800

;===============================================================================
; CHARACTER SETS (FROM FILE)
;===============================================================================

; Custom character set for Credit text window
; Mode 3 Custom character set. 1024 bytes
; Alphas, numbers, basic punctuation.
; - ( ) . , : ; and /
; Also, infinity and Cross.
; Also artifact the word "FIRE"

; Character set is 1K of data, so alignment does 
; not need to be forced again here.

CHARACTER_SET_00
	.incbin "mode3.cset"

; Custom character set for Title and Score
; Mode 6 custom character set.  512 bytes.
; 2x chars for 0 to 9. 1-10 (top) and 11-20 (bottom)
; 2x chars for title text:  
; B R E A K O U T $15-$24 (top/bottom interleaved)
; 3 chars for ball counter label "BALLS" ($25-$27)

; Character set is 1/2K of data, so
; alignment does not need to be forced here.
; ( *= $8E00 )
CHARACTER_SET_01
	.incbin "breakout.cset"

;===============================================================================
;   OTHER ALIGNED DISPLAY MEMORY
;===============================================================================

;	*= [*&$FF00]+$0100 	; Align to start of page
	
;	.include "title_mem.asm"

	*= [*&$FF00]+$0100 	; Align to start of page
	
	.include "score_mem.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
	
;	.include "thumper_mem.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
	
;	.include "ball_mem.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
	
;	.include "brick_mem.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
	
;	.include "scroller_mem.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
	
;	.include "paddle_mem.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
	
;	.include "sound_mem.asm"

;	*= [*&$FF00]+$0100 	; Align to start of page
	
;	.include "game_mem.asm"

	*= [*&$FF00]+$0100 	; Align to start of page
		
	.include "diag_mem.asm"	
	

	

; A VBI sets initial values:
; HPOS and SIZE for all Players and missiles.
; HSCROL and VSCROL.
; By default CHBAS and inital COLPF/COLPM are already handled.

;===============================================================================
; DISPLAY DESIGN 
;===============================================================================

;-------------------------------------------
; TITLE SECTION: NARROW
; Player 0 == Flying text.
; Mode 6 color text for title.
; Color 0 == Text
; Color 1 == Text
; Color 2 == Text
; Color 3 == Text
;-------------------------------------------
; COLPM0, COLPF0, COLPF1, COLPF2, COLPF3
; HPOSP0
; SIZEP0
; CHBASE
; VSCROLL, HSCROLL (for centering)
;-------------------------------------------
	; Scan line 8,       screen line 1,         One blank scan line

; Jump to Title Scroll frame... 

	; Scan lines 9-41,   screen lines 2-34,     4 lines of Mode 6 text for vertical scrolling title 

; Jump back to Main list.

;-------------------------------------------
; SCORE SECTION: NORMAL
; Player 0 == Sine Wave Balls
; Player 1 == Sine Wave Balls
; Player 2 == Sine Wave Balls.
; Player 3 == Sine Wave Balls
; Missile 3 == Sine Wave Balls (Fifth Player)
; Mode 6 color text for score.
; Color 0  == "BALLS"
; Color 1  == "P1/P2" 
; Color 2  == score
; Color 3  == score
;-------------------------------------------
; (once)
; COLPM0, COLPM1, COLPM2, COLPM3, COLPF3 
; HPOSP0, HPOSP1, HPOSP2, HPOSP3, 
; HPOSM0, 
; SIZEP0, SIZEP1, SIZEP2, SIZEP3, SIZEM
; PRIOR, DMACTL (width)
; (per line)
; COLPF0, COLPF1, COLPF2, 

; (CHBASE)
; VSCROL
;-------------------------------------------
; Ball counter and score.  Vscrol
	; Scan line 213-220, screen line 206-213,   Mode 6 text, Vertical scrolling on
	; Scan line 221-228, screen line 214-221,   Mode 6 text, Vertical scrolling off

	; Scan line 229-229, screen line 222-222,   One blank scan line
	
;-------------------------------------------
; THUMPER BUMPER SECTION: NORMAL
; color 1 = horizontal/top bumper.
; Player 3 = Left bumper 
; Player 2 = Right Bumper
;-------------------------------------------
; COLPF0, COLPM3, COLPM2
; HPOSP3, HPOSP2
; SIZEP3, SIZEP2
;-------------------------------------------

	; Scan line 42,      screen line 35,         One blank scan lines

; Jump to Horizontal Thumper bumper

	; Scan lines 43-53,  screen line 36-46,     11 various blank and graphics lines in routine

; Jump back to Main list.

;-------------------------------------------
; PLAYFIELD SECTION: NORMAL
; color 1 = bricks
; Missile 3 (5th Player) = BALL 
; Player 0 = boom-o-matic animation 1
; Player 1 = boom-o-matic animation 1
;-------------------------------------------
;    and already set earlier:
; Player 3 = Left bumper 
; Player 2 = Right Bumper
;-------------------------------------------
; COLPF0, COLPM0, COLPM1, COLPF3
; HPOSP0, HPOSP1, HPOSM3
; SIZEP0, SIZEP1, SIZEM3
; VSCROLL
;-------------------------------------------

; Blanks above bricks.

	; Scan line 54-77,   screen line 47-70,     24 blank lines

; Bricks...
	; Scan line 78-82,   screen line 71-75,     5 Mode C lines, repeated
	; Scan line 83-84    screen line 76-77,     Two blank scan lines, No scrolling -- sacrifice line
	; ...
	; Brick line 8
	; Scan line 127-131, screen line 120-124,   5 Mode C lines, repeated
	; Scan line 132-133, screen line 125-126,   Two blank scan lines, No scrolling -- sacrifice line

; After Bricks.
	; Scan line 134-141, screen line 127-134,   Eight blank scan lines

;-------------------------------------------
; CREDITS SECTION: NARROW
; Color 2 = text
; Color 3 = text background
;    and already set earlier:
; Missile 3 (5th Player) = Ball
; Player 3 = Left bumper 
; Player 2 = Right Bumper
;-------------------------------------------
; COLPF1, COLPF2
; CHBASE
; VSCROLL, HSCROLL
;-------------------------------------------

; Credits
	; Scan line 142-151, screen line 135-144,   10 Lines Mode 3
	; Scan line 152-161, screen line 145-154,   10 Lines Mode 3
	; Scan line 162-171, screen line 155-164,   10 Lines Mode 3
	; Scan line 172-181, screen line 165-174,   10 Lines Mode 3
	; Scan line 182-191, screen line 175-184,   10 Lines Mode 3
	; Scan line 192-201, screen line 185-194,   10 Lines Mode 3
	; Scan line 202-202, screen line 195-195,   10 (1) Lines Mode 3 ; scrolling sacrifice
	
	; Scan line 203-204, screen line 196-197,   Two blank scan lines

;-------------------------------------------
; PADDLE SECTION: NARROW
; Player 1 = Paddle
; Player 2 = Paddle
; Player 3 = Paddle
;    and already set earlier:
; Missile 3 (5th Player) = BALL
;-------------------------------------------
; COLPM1, COLPM2, COLPM3
;-------------------------------------------

; Paddle
	; Scan line 205-212, screen line 198-205,   Eight blank scan lines (top 4 are paddle)	


	
; Jump Vertical Blank.


;===============================================================================
;   DISPLAY_LIST
;===============================================================================

;===============================================================================
; Forcing the Display list to start on a 1K boundary is overkill.  
; Display Lists even as funky as this one are fairly short. 
; Alignment to the next 256 byte Page is sufficient insurance 
; preventing the display list from crossing over any 1K boundary.

	*=[*&$FF00]+$0100

	; ( *= $9300 to  ) 

DISPLAY_LIST 
 
	; Scan line 8,       screen line 1,         One blank scan line
	.byte DL_BLANK_1|DL_DLI 
	; VBI: Set Narrow screen, HSCROLL=4 (to center text), VSCROLL, 
	;      HPOSP0 and SIZE0 for title.  PRIOR=All P/M on top.
	; DLI1: hkernel for COLPF and COLPM color bars in the text.

;===============================================================================

;	.byte DL_JUMP		    ; JMP to Title scrolling display list "routine"

;DISPLAY_LIST_TITLE_VECTOR   ; Low byte of coarse scroll frame
;	.word TITLE_FRAME_EMPTY ; 

;TITLE_FRAME_EMPTY
; Scan line 9-16,    screen lines 2-9,      Eight blank lines
	.byte DL_BLANK_8
; Scan line 17-24,   screen lines 10-17,    Eight blank lines
	.byte DL_BLANK_8
; Scan line 25-32,   screen lines 18-25,    Eight blank lines
	.byte DL_BLANK_8
; Scan line 33-40,   screen lines 26-33,    Eight blank lines
	.byte DL_BLANK_8
; Scan line 41,      screen lines 34,       1 blank lines, (mimic the scrolling sacrifice)
	.byte DL_BLANK_1|DL_DLI ; DLI2 for Score_Line
; Return to main display list
;	.byte DL_JUMP
;	.word DISPLAY_LIST_TITLE_RTS

;===============================================================================

	;===============================================================================

	; DLI2:
	; Set Normal Width, VSCROLL, for Scores, colors for ball counters.
	
	; Next is the score lines. Like to use 12 scan lines for the text.
	; Mode 6 seems like fun, again. Center the 12 lines of custom 
	; character set in the middle of these 16.
	;
	; VSCROLL abuse will be used to compress the 16 scan lines into 12.
	;
	; Scan line 42-47, screen line 35-40,   Mode 6 text, scrolling
	.byte DL_TEXT_6|DL_LMS|DL_VSCROLL
DISPLAY_LIST_SCORE_LMS	
	.word SCORE_LINE0
	; Scan line 48-53, screen line 41-46,   Mode 6 text, scrolling
	.byte DL_TEXT_6|DL_LMS
	.word SCORE_LINE1

	; Scan line 54-54, screen line 47-47,   One blank scan line

	;===============================================================================
	; DLI3: Occurred as the last line of the Score Line section.
	;
	; Set Normal Screen, VSCROLL=0, COLPF0 for horizontal bumper.
	; Set PRIOR for Fifth Player.
	; Set HPOSM0/HPOSM1, COLPF3 SIZEM for left and right Thumper-bumpers.
	; set HITCLR for Playfield.
	; Set HPOSP0/P1/P2, COLPM0/PM1/PM2, SIZEP0/P1/P2 for top row Boom objects.
	
	
;DISPLAY_LIST_TITLE_RTS ; return destination for title scrolling "routine"
	; Scan line 42,      screen line 35,         One blank scan lines
	.byte DL_BLANK_1   ; I am uncomfortable with a JMP going to a JMP.
	; Also, the blank line provides time for clean DLI.
		
	; Scan lines 55-65,  screen line 48-58,     11 various blank and graphics lines in routine

	
;	.byte DL_JUMP	        ; Jump to horizontal thumper animation frame
DISPLAY_LIST_THUMPER_VECTOR ; remember this -- update low byte to change frames
;	.word THUMPER_FRAME_WAIT

;   Simulate the thumper box.

    .byte DL_BLANK_3
    .byte DL_BLANK_8
    
	; Note DLI started before thumper-bumper Display Lists for 
	; P/M HPOS, COLPM, SIZE and HITCLR
	; Also, this DLI ends by setting HPOS and COLPM for the BOOM 
	; objects in the top row of bricks. 

DISPLAY_LIST_THUMPER_RTS ; destination for animation routine return.
	; Top of Playfield is empty above the bricks. 
	; Scan line 66-89,   screen line 59-82,     24 blank lines


	.byte DL_BLANK_8
	.byte DL_BLANK_8
;	.byte DL_BLANK_7|DL_DLI 


;===============================================================================
; ****   ******   **    *****
; ** **    **    ****  **  
; **  **   **   **  ** **
; **  **   **   **  ** ** ***
; ** **    **   ****** **  **
; ****   ****** **  **  *****
;===============================================================================

; DIAGNOSTIC ** START
	; Delineate end of DLI VSCROLL area
	.byte DL_BLANK_5  ; 5 + 1 mode C below + 1 blank below = 7 commented above
	.byte DL_MAP_C|DL_LMS
	.word BRICK_LINE_MASTER 	
; DIAGNOSTIC ** END


	.byte DL_BLANK_1|DL_DLI
	 
	.byte DL_BLANK_1
	
	; DLI3: Hkernel 8 times....
	;      Set HSCROLL for line, VSCROLL = 5, then Set COLPF0 for 5 lines.
	;      Reset VScroll to 1 (allowing 2 blank lines.)
	;      Set P/M Boom objects, HPOS, COLPM, SIZE
	;      Repeat HKernel.

	; Define 8 rows of Bricks.  
	; Each is 5 lines of mode C graphics, plus 2 blank line.
	; The 5 rows of graphics are defined by using the VSCROL
	; exploit to expand one line of mode C into five lines.

	; Block line 1
	; Scan line 90-94,   screen line 83-87,     5 Mode C lines, repeated
	; Scan line 95-96    screen line 88-89,     Two blank scan lines, No scrolling -- sacrifice line
	; ...
	; Block line 8
	; Scan line 139-143, screen line 132-136,   5 Mode C lines, repeated
	; Scan line 144-145, screen line 137-138,   Two blank scan lines, No scrolling -- sacrifice line
DL_BRICK_BASE
	; DL_BRICK_BASE+1, +5, +9, +13, +17, +21, +25, +29 is low byte of row.
	; Only this byte should be needed for scrolling each row.

	; scan line +0 to +4  -- 5 scan lines of mode C copied/extended
	.byte DL_MAP_C|DL_LMS|DL_VSCROLL|DL_HSCROLL
	.word [BRICK_LINE0+21] ; offset into center screen
	; two blank scan line
	.byte DL_BLANK_2 	

	; scan line +0 to +4  -- 5 scan lines of mode C copied/extended
	.byte DL_MAP_C|DL_LMS|DL_VSCROLL|DL_HSCROLL
	.word [BRICK_LINE1+21] ; offset into center screen
	; two blank scan line
	.byte DL_BLANK_2 	
	
	; scan line +0 to +4  -- 5 scan lines of mode C copied/extended
	.byte DL_MAP_C|DL_LMS|DL_VSCROLL|DL_HSCROLL
	.word [BRICK_LINE2+21] ; offset into center screen
	; two blank scan line
	.byte DL_BLANK_2 	

	; scan line +0 to +4  -- 5 scan lines of mode C copied/extended
	.byte DL_MAP_C|DL_LMS|DL_VSCROLL|DL_HSCROLL
	.word [BRICK_LINE3+21] ; offset into center screen
	; two blank scan line
	.byte DL_BLANK_2 	
	
	; scan line +0 to +4  -- 5 scan lines of mode C copied/extended
	.byte DL_MAP_C|DL_LMS|DL_VSCROLL|DL_HSCROLL
	.word [BRICK_LINE4+21] ; offset into center screen
	; two blank scan line
	.byte DL_BLANK_2 	

	; scan line +0 to +4  -- 5 scan lines of mode C copied/extended
	.byte DL_MAP_C|DL_LMS|DL_VSCROLL|DL_HSCROLL
	.word [BRICK_LINE5+21] ; offset into center screen
	; two blank scan line
	.byte DL_BLANK_2 	
	
	; scan line +0 to +4  -- 5 scan lines of mode C copied/extended
	.byte DL_MAP_C|DL_LMS|DL_VSCROLL|DL_HSCROLL
	.word [BRICK_LINE6+21] ; offset into center screen
	; two blank scan line
	.byte DL_BLANK_2 	

	; scan line +0 to +4  -- 5 scan lines of mode C copied/extended
	.byte DL_MAP_C|DL_LMS|DL_VSCROLL|DL_HSCROLL
	.word [BRICK_LINE7+21] ; offset into center screen
	; two blank scan line
	.byte DL_BLANK_2 	
	
	
;===============================================================================
; ****   ******   **    *****
; ** **    **    ****  **  
; **  **   **   **  ** **
; **  **   **   **  ** ** ***
; ** **    **   ****** **  **
; ****   ****** **  **  *****
;===============================================================================

; DIAGNOSTIC ** START	
; Temporarily test layout and spacing without the DLI/VSCROL trickery.

;	.byte DL_MAP_C|DL_LMS|DL_HSCROLL
;	.word BRICK_LINE0+[entry*$40] ; not immediately offset into middle of graphics line
;	.word [GAMEOVER_LINE0+[entry*20]-2]
;	.byte DL_MAP_C|DL_LMS|DL_HSCROLL
;	.word BRICK_LINE0+[entry*$40] ; not immediately offset into middle of graphics line
;	.word [GAMEOVER_LINE0+[entry*20]-2]
;	.byte DL_MAP_C|DL_LMS|DL_HSCROLL
;	.word BRICK_LINE0+[entry*$40] ; not immediately offset into middle of graphics line
;	.word [GAMEOVER_LINE0+[entry*20]-2]
;	.byte DL_MAP_C|DL_LMS|DL_HSCROLL
;	.word BRICK_LINE0+[entry*$40] ; not immediately offset into middle of graphics line
;	.word [GAMEOVER_LINE0+[entry*20]-2]
;	.byte DL_MAP_C|DL_LMS|DL_HSCROLL
;	.word BRICK_LINE0+[entry*$40] ; not immediately offset into middle of graphics line
;	.word [GAMEOVER_LINE0+[entry*20]-2]
; DIAGNOSTIC ** END

	; HKernel ends:
	; set Narrow screen, COLPF2, VSCROLL, COLPF1 for scrolling credit/prompt window.
	; Collect HITCLR values for analysis of bricks .  Reset HITCLR.
	
	
	; a scrolling window for messages and credits.  
	; This is 8 blank lines +  8 * 10 scan lines plus 7 blank lines.
	; These are ANTIC Mode 3 lines so each is 10 scan lines tall.


;===============================================================================
; ****   ******   **    *****
; ** **    **    ****  **  
; **  **   **   **  ** **
; **  **   **   **  ** ** ***
; ** **    **   ****** **  **
; ****   ****** **  **  *****
;===============================================================================

; DIAGNOSTIC ** START
	; Delineate end of DLI VSCROLL area
	.byte DL_MAP_C|DL_LMS
	.word BRICK_LINE_MASTER 	
; DIAGNOSTIC ** END


	
; some blank lines, two lines diagnostics, a few more blank lines.


	.byte DL_BLANK_8,DL_BLANK_8,DL_BLANK_7|DL_DLI; This is last DLI for DIAG
	.byte DL_BLANK_8 
	.byte DL_TEXT_2|DL_LMS
	.word DIAG0
	.byte DL_BLANK_4
	.byte DL_TEXT_2|DL_LMS
	.word DIAG1
	.byte DL_BLANK_8,DL_BLANK_8,DL_BLANK_8,DL_BLANK_8

	
	
	
	
	; Finito.
	.byte DL_JUMP_VB
	.word DISPLAY_LIST



;===============================================================================
;   PROGRAM_INIT_ADDRESS
;===============================================================================
; Atari uses a structured executable file format that 
; loads data to specific memory and provides an automatic 
; run address.
;===============================================================================
; Store the program start location in the Atari DOS RUN Address.
; When DOS is done loading the executable it will automatically
; jump to the address placed in the DOS_RUN_ADDR.
;===============================================================================
;
	*=DOS_RUN_ADDR
	.word PRG_START

;===============================================================================

	.end ; finito
 
;===============================================================================

