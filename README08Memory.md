# Atari-Breakout76 Organizing Memory

**PREVIOUS SECTION** | **Back To START** 
:--- | :---: 
[:arrow_left: . . . Title Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md "Title Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") 
 
---

**Overall Modular Design**

Programmer sanity is related to well-organized code and data.  Messy, disorganized assembly code is painful to work with and can drive a programmer crazy.  Higher level languages on larger computers do not require the programmer think much about memory -- the compiler and the environment automatically use heap and stack as appropriate and the graphics API or the device drivers manage the graphics card memory. But, assembly language being closer to the metal means the programmer has an obligation to consider more.  Modular, organized design requires more thought, planning, and discipline.

The discussion below outlines the kinds of memory and assembly code that a feature may use.  The code and data for features will be grouped into files following this organization.  The main source file is responsible for establishing the program address or other supporting values, and then the main file includes each of the modular feature files.


**Overview of Memory Organization**

Everything resides in memory -- the program, the variables and data, the graphics images, etc.  Program memory arranged to fit the 6502 CPU preferences results in smaller, faster code.  Additionally, the custom graphics hardware in the Atari accesses memory directly and requires the data for graphics features arranged in specific ways.

Not all memory in the system is RAM accessible to a program.  Some memory is ROM containing the Operating System.  On some Atari models the Operating System ROM can be switched out to expose RAM at the same locations.  However, the Atari' comprehensive Operating System provides many useful services and functions, so it is usually more trouble than it is worth for a program to disable the Operating System. 

Also, the ROM cartridge replaces RAM if RAM exists at that same location.  Typically this ROM is Atari BASIC.  Since the point of this exercise is an assembly language program loaded from disk we can assume either the ROM cartridge is removed or on systems where the BASIC ROM is on the motherboard the user manually disables BASIC by holding the Option key during startup.

Recall that a 16-bit address must be described using two bytes of information.  The low byte, value 0 to 255, and the high byte, value 0 to 255.  Multiply the high byte by 256, and add the low byte to specify an address.  

The 256 memory addresses related to each other by the same high byte value are called a "Page".  The memory addresses with the high byte value $00 are referred to as "Page Zero".  Memory addresses $0100 to $01FF all have the high byte $01 making this block of memory "Page one", and so forth for 256 pages each with 256 bytes.  Memory organized in contiguous 256 byte blocks or Pages is significant to the 6502 processor.  Many parts of the computer are placed in memory based on a staring Page address -- the cartridge location, the Operating System, and input/output hardware such as the custom chips hardware registers; all occur in memory aligned to Page boundaries.

Several 256 byte pages at the beginning of memory are committed to variables supporting Operating System functions.  Also, if DOS is loaded a couple more Kilobytes of low memory are committed to DOS and the disk buffers.

The Atari's ANTIC graphics hardware also reads data from memory.  While the graphics chip can access the entire 16-bit address space there are limits to how much contiguous memory the chip may automatically reference.  Also, some graphics features use only one byte to describe a starting Page number for the beginning of data.

Overview of system memory:

Diagram of memory map goes here.

**Detailed Memory Organization**

**Page Zero**

The first Page of memory, Page Zero, is special in the system.  6502 instructions referencing addresses in any other page in memory require two bytes for expressing the 16-bit address.  The 6502 has special machine language instructions for Page Zero that assume the high byte value of the address is $00, thus need only one byte to describe the address.  Frequent reference to Page Zero locations noticably shrink program size.  

Since the instructions using Page Zero are shorter, they take less time to fetch from memory.  Thus they execute faster than the corresponding instructions referencing other memory.  Page Zero use can speed up programs when execution time is critical.  In a way, Page Zero locations are somewhat like cache or additional registers.

Finally, the 6502 has special instructions that only work with Page 0 locations.  These instructions can use the values in Page 0 memory as pointers -- addresses to other destinations in memory.  This powerful feature enables writing reusable code that can operate against any memory in the system just by changing an address stored in Page Zero.

Since Page Zero provides so much power and utility these 256 bytes are highly contested.  The first half of Page Zero ($00 to $7F) is committed to the Operating System.  These locations are configuration values and working variables for managing input/output operations, the full screen editor, pixel graphics drawing, the real-time clock, and other useful functions.

The second half of Page Zero ($80 to $FF) is primarily dedicated to the ROM cartridge program.  This ordinarily means BASIC which uses most of the page.  The remainder of the page belongs to the Floating Point library.   

This assembly language game will load from disk and there will be no ROM cartridge running in memory.  The game will not use any Floating-Point routines.  Therefore, all of the last half of Page Zero is available to the program.

**Using Page Zero -- The Initialization Problem**

A problem with Page Zero is how to initialize the values in Page Zero.  The direct approach of explicitly loading and storing  values wastes memory -- four bytes of instructions, data, and addresses are required to set one byte of Page Zero.  Examine this code:

```asm
TITLESPEED = $80
TITLETEXT  = $81 ; two-byte pointer
TITLEX     = $83
TITLEY     = $84

	lda #$FF
	sta TITLESPEED
	lda #$FC
	sta TITLETEXT
	lda #$02
	sta TITLETEXT+1
	lda #$7F
	sta TITLEX
	lda #$40
	sta TITLEY
```

This requires 20 bytes of program code to set only 5 bytes in Page Zero.  Initializing all of the available Page Zero locations from $80 to $FF would require 512 bytes of code for initialization.  On an 8-bit computer that's a serious investment in a program.

Also, the explicit memory address declarations contribute another problem. Each removal or insertion of a page zero variable puts the programmer into painful, tedious, code-editing purgatory.  In the example above, if TITLETEXT is removed, then the declarations for every following variable must be recalculated and edited two addresses earlier in memory.  This leads to inevitable problems (aka: bugs).  The alternative is messy code, and gaps in Page Zero usage, because a variable was removed in code and forgotten.

A more memory efficient solution to the Page Zero initialization problem is to declare the data intended for Page Zero in another location in memory in and then copy the data to Page Zero during program initialization. Such as:

```asm
TITLESPEED = $80
TITLETEXT  = $81 ; two-byte pointer
TITLEX     = $83
TITLEY     = $84

	*= $3400

PAGEZERODATA
	.byte $FF
	.word $02FC
	.byte $7f
	.byte $40
. . .
	MAXZERODATA = $40 ; How many bytes used in Page Zero.

INIT
	ldy #$00
LOOPCOPYZERO
	lda PAGEZERODATA,y
	sta $80,y
	iny
	cpy #MAXZERODATA
	bne LOOPCOPYZERO
. . .
```

This solution reduces the memory overhead for initializing Page Zero locations.  The entire working code is 12 bytes of looping instructions which copy a contiguous block of bytes into Page Zero.  As far as the initialization goes, this beats the explicit code by a mile.  However, after loading data into Page Zero the data outside of Page Zero becomes a redundant copy, wasting memory space though much less than the prior example.  This solution also does not address the problem of editing the labels for Page Zero locations.  Adding and removing location labels is still an onerous task.  

The Atari has an interesting solution.  The Atari executable load file format is structured.  It provides starting and ending addresses with the data to load in that memory space.  This allows the Atari to optimize executable file size by describing only the data that the program needs thus reducing file size and speeding up load time.  Many other systems start loading a machine language program at a fixed address and must represent all the memory as one continuous block in the file even if parts of it are not used.

The executable file format discussion is relevant to Page Zero, because it allows an Atari assembly language program to declare Page Zero variables and define the initial values the same as it would do for any other memory.  Therefore, data can be loaded directly into Page Zero locations from the file:

```asm
	*= $80 ; Set program location to Page Zero

TITLESPEED .byte $FF
TITLETEXT  .word $02FC
TITLEX     .byte $7f
TITLEY     .byte $40
. . .
```

This loads five bytes of data into five bytes of Page Zero.  There is actually no code involved.  The data is loaded directly into memory from the file on disk.  This also solves the problem with managing and keeping order of Page Zero variables, since the source code no longer needs to declare the addresses.  The Assembler will take care of the address assignments.  

Next is how to use this method to make a modular solution for managing the program code.  The main source file must control the assembly directive to set the program address to Page Zero, then the main code includes the files for each modular feature requiring Page Zero variables.

Main looks like this:

```asm
	*= $80

.include "TitleZero.asm"
.include "BallZero.asm"
.include "PaddleZero.asm"
etc.
```

And then "TitleZero.asm" contains:

```asm
TITLESPEED .byte $FF
TITLETEXT  .word $02FC
TITLEX     .byte $7f
TITLEY     .byte $40
. . .
```

No part of the code explicitly assigns address values to the labels.  Any of the Page Zero variable files can be easily edited and variables changed and moved around, and then everything is correct after reassembly.

**Aligned Program Data**

Respecting the 8-bit architecture's 256-byte Page organization improves machine language efficiency.  We've already seen how using Page Zero reduces code size and execution time.  There is more to consider when accessing memory outside of Page Zero.  The 6502's X and Y index registers act as offsets by 0 to 255 bytes relative to a starting address.  When the resulting target address is in a different page of memory than the starting address it costs the instruction more time to access the memory. Therefore programs benefit when keeping related data organized in the same Page.

The Atari's ANTIC graphics chip reads memory to provide data for several graphics features.  As previously mentioned, while ANTIC does have access to the entire 16-bit address space features have limits on the starting address and/or the amount of contiguous memory it can read.

| Feature | DMA address | Starting Address Alignment | Max Contiguous RAM |
| --- | --- | --- | --- | 
| Display List | 16-bit | 16-bit | 1K Max (Restart with JMP instruction)|
| Display RAM | 16-bit | 16-bit | 4K Max (Restart via LMS instruction |
| Player/Missile (double-line) | Page Pointer | 1K Boundary | 1K Max |
| Player/Missile (single-line) | Page Pointer | 2K Boundary | 2K Max |
| Character Set (Modes 2, 3, 4, 5) | Page Pointer | 1K Boundary | 1K Max |
| Character Set (Modes 6, 7) | Page Pointer | 1/2K Boundary | 1/2K Max |

- **Display List** ANTIC can read the Display List beginning anywhere in memory, but it cannot read across a 1K boundary (4 Pages) in memory.  Reading past a 1K boundary requires the Display List include a JMP  (jump) instruction which reloads the Display List program counter to the new address after the 1K boundary.  But, this is not a difficult problem to avoid as even the largest possible Display List is less than 1K.

Display List 1K Memory Map here.

- **Display RAM** Antic reads screen memory through the Memory Scan register.  As indicated in the Display List overview earlier an ANTIC Display List command for a text or graphics mode may optionally describe the starting address for screen memory.  If there is no screen memory specification ANTIC's Memory Scan automatically continues reading sequentially from memory where it ended for the previous line.  The Memory Scan address for text and pixel mode display data can begin anywhere in memory with the exception that the action of reading memory for the mode line does not cross over a 4K boundary in the middle of the line.

The Operating System constructs Display Lists for graphics modes with the Load Memory Scan option on the first mode line.  ANTIC's Memory Scan reads the remainder of the screen data automatically traversing through contiguous memory that follows.  An exception is ANTIC modes E and F which require 8K of RAM.  The Operating System creates these Display Lists with the Load Memory Scan option added to an instruction near the middle of the screen directing ANTIC to load a new starting screen memory address into the Memory Scan register for the second 4K block of memory.

Display Data 4K memory Map here.

- **Double-Line Player Missile Graphics** This Player/Missile mode supplies one byte of bitmap data to the Player/Missile images for two consecutive scan lines.  Player/Missile memory DMA uses a one byte pointer to a Page (PMBASE).  This Player/Missile display mode requires the PMBASE Page must be at a 1K boundary.  ANTIC reads Player/Missile bitmaps from the 1K memory block beginning at this page.

Player/Missile Double-Line Memory Map - Offsets relative to PMBASE

| - | Unused | M3 M2 M1 M0 | P0 | P1 | P2 | P3 |
| --- | --- | :---: | --- | --- | --- | --- |
| ***Start*** | Top | of | Screen | . | . | .|
| hex | $000 | $180 | $200 | $280 | $300 | $380 |
| dec |  0 | 384 | 512 | 640 | 768 | 896 |
| ***End*** | Bottom | of | Screen | . | . | .|
| hex | $17f | $1ff | $27f | $2ff | $37f | $3ff |
| dec |  383 | 511 | 639 | 767 | 895 | 1023 |


Player/Missile 1K  memory Map here.

- **Single-Line Player Missile Graphics** This Player/Missile mode supplies one byte of bitmap data to the Player/Missile images for each scan line.  Player/Missile memory DMA uses a one byte pointer to a Page (PMBASE).  This Player/Missile display mode requires the Page must be at a 2K boundary.  ANTIC reads Player/Missile bitmaps from the 2K memory block beginning at this page.


Player/Missile Single-Line Memory Map - Offsets relative to PMBASE

| - | Unused | M3 M2 M1 M0 | P0 | P1 | P2 | P3 |
| --- | --- | :---: | --- | --- | --- | --- |
| ***Start*** | Top | of | Screen | . | . | .|
| hex | $000 | $300 | $400 | $500 | $600 | $700 |
| dec |  0 | 768 | 1024 | 1280 | 1536 | 1792 |
| ***End*** | Bottom | of | Screen | . | . | .|
| hex | $2ff | $3ff | $4ff | $5ff | $6ff | $7ff |
| dec |  767 | 1023 | 1279 | 1535 | 1791 | 2047 |

Player/Missile 2K  Map here.

Note that reserving the 1K or 2K of aligned memory for Player/Missile graphics automatically includes a block of unused space which by definition is also automatically aligned.  This space may be used for undisplayed frames of animated Player/Missile bitmaps, screen memory, part of a character set, or any other purpose.  Likewise, the aligned memory for any unused Player/Missile object is available for other purposes.


- **Character Set (modes 2, 3, 4, 5)** This uses a 1 byte pointer to a page in memory.  These character set images for this text mode must begin on a 1K boundary, and ANTIC reads data for the character set from the identified 1K block beginning at this page.

Character Set 1k memory Map here.

- **Character Set (modes 6, 7)** This uses a 1 byte pointer to a page in memory.  These character set images for this text mode must begin on a 1/2K boundary, and ANTIC reads data for the character set from the identified 1/2K block beginning at this page.

Character set 1/2 K Memory Map here.


**Unaligned Program Data**

General purpose data need not be organized.  Although, lists and tables which will be referenced by an index benefit when they are all in the same page.


**Code: The Main Program**

Breakout is a simple game and is not very memory intensive.  It can begin in memory after the Atari's DUP utility. (DUP is the friendly, menu-driven interface for DOS.)  A larger game that needs more memory could use the space for DUP providing a few more K of RAM to the program.  If memory is tight there are third party utilities to optimize memory such as XBIOS which provides critical disk functions needed by games using a fraction of the memory needed for Atari DOS.

General execution is to maintain the state and values of on-screen entities in order from the top of the screen to the bottom.  Calculations for all moving, variable visible entities occur during the main progam.  Changes to the displayed entities occur either during the main program before the entity is displayed, or during the Vertical Blank interrupt between frames.

When the main program completes a cycle of game entity updates it loops waiting for the start of the next frame.  Thus the main code and the vertical blank are in sync with each other servicing the game entity animation, movement, and value changes frame by frame.

**Interrupts: Vertical Blank Interrupt**

At the end of a video frame, the CRT electron beam must return to the top of the screen.  This period of time between video frames is called the vertical blank and it surprising long (several thousand machine cycles).  During this time the Atari stops itself and runs utility code performing important system house-keeping that includes updates of critical custom hardware registers for the display while the screen output is off, copying color register shadow registers to the hardware registers, polling the game controllers, and maintaining timers and clocks.

Diagram normal VBI/SYSVBV/SYSEXIT

Interrupts seem like an advanced topic, but the Vertical Blank Interrupt is really not so hard to understand and use on the Atari.  The Atari Operating system provides an easy to use facilities to attach a custom routine for execution either before or after the Operating System's vertical blank maintenance code.  Code added before the Operating System Vertical Blank routine is the "Immediate Vertical Blank Interrupt", and code added after the Operating System's Vertical Blank routine is the "Deferred Vertical Blank Interrupt."

There are not many special considerations for the user code running in the vertical blank.  6502 CPU registers do not need to be saved on entry and restored on exit.  The only requirements are exiting the code by jumping to the proper Operating System vector, and a healthy respect for the time spent in the custom vertical blank routine.  The time available during the Vertical Blank allows execution of about 800 to 1000 6502 instructions before the display begins for the next frame.  

The user's Immediate Vertical Blank Interrupt code should be as short and fast as possible to return control to the Operating System's Vertical Blank Interrupt, so that it can finish all its critical updates before the next frame begins display.  The user's Deferred Vertical Blank Interrupt has more lattitute.  It may continue to run beyond the start of the next display frame. It must end before the next vertical blank starts.

Immediate, System, and Deferred diagram.

**Interrupts: Display List Interrupt**

The Display List Interrupt occurs while the ANTIC chip is generating the display.  One of the options available to a text or graphics mode line is the Display List Interrupt.  If this option is set then on the last scan line of the text or graphics mode ANTIC will alert the 6502 to the interrupt.  The CPU stops its main code to run the interrupt code defined for the Display List Interrupt.

This is a little more complicated to set up than the Vertical Blank interrupt, and there are some important rules to follow in the code to enter and exit the Display List Interrupt correctly.  On the good side, the programmer does not have to calculate the interrupt location on screen or otherwise do anything complicated to compensate for interrupt instability.

Display List Interrupt setup must occur when it is absolutely certain another Display List Interrupt cannot start.  The large scale, brute force method is to stop the screen display, turn off the interrupts, and wait for the current frame to finish, then set the Display List Interrupt address, re-enable the interrupts, and re-enable the display.  This definitely guarantees no Display List Interrupt collision, but it also guarantees no video output for a frame.  Alternatively, a machine language program can monitor ANTIC's register reporting the current scan line and alter the Display List Interrupt vector when it knows it cannot overlap another Display List Interrupt's execution.  But, the safest and easiest method is to use the Vertical Blank Interrupt to reset the Display List Interrupt for each frame.  

Multiple Display List Interrupt on the display requires each interrupt to end by resetting the Display List Interrupt vector to the starting address of the next Display List Interrupt routine.  The last Display List Interrupt on the screen resets the vector to the first Display List Interrupts starting address.  The Vertical Blank Interrupt is again the most useful assistant.  When a program has multiple Display List Interrupts, the Vertical Blank Interrupt reinforcing the correct starting point for each frame stabilizes the Display List Interrupt sequence which helps diagnose bugs in the display or the interrupts.

Connecting multiple display list interrupts is a wrench in the works of keeping a screen feature independent code.  For a Display List routine to reset the Display List vector to the address of the next routine requires the first routine know the address of the second routine violating the independent design.  The problem resoltion her is to make the main code responsible for knowing the address of the Display List interrupt routines and to reset the Display List Interrupt vector for each routine. 

Main looks like this:

```asm
	*= $5000

DLI_1
.include "TitleDLI.asm"
	lda #<DLI_2
	sta VDSLST
	lda #>DLI_2
	sta VDSLST+1
	pla
	rti
	
DLI_2
.include "BallDLI.asm"
	lda #<DLI_3
	sta VDSLST
	lda #>DLI_3
	sta VDSLST+1
	pla
	rti
	
DLI_3
.include "PaddleDLI.asm"
	lda #<DLI_4
	sta VDSLST
	lda #>DLI_4
	sta VDSLST+1
	pla
	rti
etc.

; at the end of Display List Interrupts the Main code
; can either reset the vector to the first routime, 
; or trust the Vertical Blank Interrupt to do it.

	lda #<DLI_1
	sta VDSLST
	lda #>DLI_1
	sta VDSLST+1
	pla
	rti
	
```

And then "TitleDLI.asm" contains:

```asm
; The routine need not declare a starting address, since 
; the Main code will take care of it.

	pha        ; Save A
	lda #$1A   ; Light Yellow-ish
	sta WSYNC  ; Sync to end of scanline
	sta COLPF0 ; Set Playfield color
;	pla        ; Do NOT Do This

```

Guidelines for Display List Interrupt Routines:
- The routine starts by saving the A register to the stack, and the X, and Y registers if used in the routine.
- The routine ends by restoring X and Y from the stack if previously saved.
- The routine DOES NOT restore A from the stack.
- The routine DOES NOT reset the Display List Interrupt vector to the next routine.
- The routine DOES NOT present the RTI instruction to end the interrupt routine.

Therefore the Main code is responsible for the following:
- The Main code will reset the Display List Interrupt vector to the next routine. (Using the A register).
- The Main code will restore the A register from the stack.
- The Main code will present the RTI instruction to end the interrupt.

---

**File Naming Conventions**

| **Usage** | **Example** | **Description** |
| --- | --- | --- |
| Capitalized | ANTIC.asm   | System Include files | 
| macro_ + subject | macro_math.asm | System macro library (for math) |
| lib_ + subject | lib_math.asm | System library code called by JSR |
| zero_ + game_ + subject | zero_bk76_Bricks.asm | Page Zero variables/declarations |
| mem_ + game_ + subject | mem_bk76_Bricks.asm | Aligned variables/memory declarations |
| var_ + game_ + subject | var_bk76_Bricks.asm | Unaligned, global variables/memory |
| main_ + game_ + subject | main_bk76_Bricks.asm | mainline code for the feature |
| vbi_ + game_ + subject | vbi_bk76_Bricks.asm | Vertical Blank Interrupt code for the feature |
| dli_ + game_ + subject | dli_bk76_Bricks.asm | Display List Interrupt code for the feature |
| main_ + game | main_bk76.asm | main program that includes all other files |


**General Label Naming Conventions**

Imitating Hungarian notation, this uses a prefix at the start of the variable names to indicate location and size....

Add location + Size to the beginning of the variable.

Add location to the beginning of user/main program branch/jump destinations.


**Locations:**

| **Label Prefix** | **Location Description** |
| --- | --- |
| z | Variable in Page Zero location |
| v | Variable in other page location |
| b | Local short branch destination |
| g | global "goto", a JSR/JMP in user/main program routine |



**Variable Sizes:**

| **Label Prefix** | **Size Description** |
| --- | --- |
| b | Byte value |
| w | word value |
| a | address value (pointing to anything) | 
| l | long (4 byte) value |
| f | floating point (6 byte) value |
| s | string, aka sequential block of bytes |


**Variable Label Examples**

**Examples** | **Description**
--- | --- 
zbTempParm | Page Zero location contains byte value
zwVector | Page Zero location contains two-byte, 16-bit value 
zaParmAddr | Page Zero value contains address (two-byte, 16-bit)
vfPiRSquare | Generic memory variable contains floating point (6 byte) value
bLoopScreen | nearby branch target
gInitDisplay | global JMP/JSR target in user code


**Other Label Naming Conventions**

| **Usage** | **Example** | **Description** |
| --- | --- | --- |
| CAPITALIZED | SDMCTL | Defined constants.  System register addresses, Register values, OS variables, , OS vectors |
| m + Mixed Case | mAdd16 | macro routines.  May be wrappers to call library (JSR) routines. |
| lib + Mixed Case | libClearScreen | Library routine (called by JSR) |


---

**PREVIOUS SECTION** | **Back To START** 
:--- | :---: 
[:arrow_left: . . . Title Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md "Title Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") 
 
 
