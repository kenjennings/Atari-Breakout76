# Atari-Breakout76 Organizing Memory

**PREVIOUS SECTION** | **Back To START** 
:--- | :---: 
[:arrow_left: . . . Title Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md "Title Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") 
 
---

**Overall Modular Design**

Each feature will place its code and data in files separated by purpose.  The main source file is responsible for establishing the program address or other supporting values, and then the main source file includes each of the other modules.  The kinds of files needed for a feature depend on the memory organization required for the data or the code.  The discussion below outlines the kinds of memory and assembly code that a feature may use. 

**Organizing Memory**

Everything resides in memory -- the program, the variables and data, the graphics images, etc.  Program memory arranged to fit the 6502 CPU preferences results in smaller, faster code.  Additionally, the custom graphics hardware in the Atari accesses memory directly and requires the data for graphics features arranged in specific manners.

Recall that a 16-bit address must be described using two bytes of information.  The low byte, value 0 to 255, and the high byte, value 0 to 255.  Multiply the high byte by 256, and add the low byte to specify an address.  

Memory addresses $0000 to $00FF all have the high byte $00.  The 256 memory addresses related to each other by the same high byte are called a "Page".  The memory addresses with the high byte value $00 are referred to as "Page Zero".  Memory addresses $0100 to $01FF all have the high byte $01 making this block of memory "Page one", and so forth for 256 pages each with 256 bytes.  The memory organized in contiguous 256 byte blocks or Pages is significant to the 6502 processor.  Many parts of the computer are placed in memory based on a staring Page address -- the cartridge location, the Operating System, and input/output hardware such as the custom chips hardware registers.

Not all memory in the system is RAM accessible to a program.  Some memory is ROM containing the Operating System.  On some Atari models the Operating System ROM can be switched out to expose RAM at the same locations.  However, the Atari' comprehensive Operating System provides many useful services and functions, so it is usually more trouble than it is worth for a program to disable the Operating System. 

Also, the ROM cartridge replaces RAM if RAM exists at that same location.  Typically this ROM is Atari BASIC.  Since the point of this exercise is an assembly language program loaded from disk we can assume either the ROM cartridge is removed or on systems where the BASIC ROM is on the motherboard the user manually disables BASIC by holding the Option key during startup.

When the Operating System is active several 256 byte pages at the beginning of memory are committed to variables supporting Operating System functions.  Also, if DOS is loaded a couple more Kilobytes of low memory are committed to DOS and the disk buffers.

The Atari's ANTIC graphics hardware also reads data from memory. While the graphics chip can access the entire 16-bit address space there are limits to how much contiguous memory the chip may automatically reference.  Also, some graphics features use only one byte to describe a starting Page number for the beginning of data.

Overview of system memory:





**Page Zero**

The first Page of memory, Page Zero, is special in the system.  6502 instructions referencing addresses in any other page in memory require two bytes to express the 16-bit address. The 6502 has special machine language instructions for Page Zero that assume the high byte value of the address is $00 and so need only one byte to describe the address.  Frequent reference to Page Zero locations can noticably shrink program size.  

Because the instructions using Page Zero are shorter, they also execute faster than the corresponding instructions referencing other memory.  Page Zero use can speed up programs when execution time is critical.  In a way, Page Zero locations are somewhat like cache or additional registers.

Finally, the 6502 has special instructions that only work with Page 0 locations.  These instructions can use the values in Page 0 memory as pointers to another destination address in memory.  This powerful feature enables writing reusable code that can operate against any memory in the system just by changing an address stored in Page Zero.

Since Page Zero provides so much power and utility these 256 bytes are highly contested.  The first half of Page Zero ($00 to $7F) is committed to the Operating System.  These locations are configuration values and working variables for managing input/output operations, the full screen editor, pixel graphics drawing, the real-time clock, and other useful functions.

The second half of Page Zero ($80 to $FF) is primarily dedicated to the ROM cartridge program.  This ordinarily means BASIC which uses most of the page.  The remainder of the page belongs to the Floating Point library.   

The assembly language game will load from disk and there will be no ROM cartridge running in memory.  The game will also not use any Floating-Point routines.  Therefore, all of this half of Page Zero is available to the program.

A problem with Page Zero on non-Atari computers is how to initialize the values in Page Zero.  Often this requires extra code to explicitly load and store values -- four bytes of instructions, data, and addresses are required to set one byte of Page Zero.

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

This requires 20 bytes of program code to set only 5 bytes in Page Zero.  In an earlier game design I was managing Page Zero like the non-Atari example above as declarations.  This resulted in painful, tedious, source code editing purgatory every time I added or removed a page zero variable.  In the example above, if TITLETEXT is removed, then the declarations for every variable that follows must be recalculated and edited two addresses earlier in memory.  This leads to inevitable problems.

The Atari has an interesting solution.  The Atari executable load file format is structured.  It provides starting and ending addresses with the data to fill in that memory space.  This allows the Atari to optimize executable file size by describing only the data that the program needs thus reducing file size and speeding up load time.  Many other systems start loading at a usually fixed address and must represent all the memory as one continuous block in the file even if parts of it are not used.

The executable file format discussion is relevant to Page Zero, because it allows an Atari assembly language program to declare Page Zero variables and define the initial values the same as it would do for any other memory.  Therefore, data can be loaded directly into Page Zero locations from the executable file:

```asm
	*= $80 ; Set program location to Page Zero

VARIABLE1 .word $02FC
VARIABLE2 .byte $FF
```

This loads 3 bytes of data into three bytes of Page Zero.  There is actually no code involved.  The data is loaded directly from the executable file on disk.

This also solves the problem with managing and keeping order of Page Zero variables.  The addresses of the variables no longer need to be declared.  The Assembler will take care of it.  The main source file can control the assembly directive to set the program address to Page Zero, then include files for each feature that defines variable values without andy other address definitions.

Main looks like this:

```asm
	*= $80

.include "TitleZero.asm"
.include "BallZero.asm"
.include "PaddleZero.asm"
etc.

And then "TitleZero.asm" contains:
 
TITLESPEED .byte $FF
TITLETEXT  .word $02FC
TITLEX     .byte $7f
TITLEY     .byte $40
. . .
```

No part of the code actually declares the addresses of variables.  Any of the Page Zero variable files can be easily edited and variables changed and moved around, and then everything is correct after reassembly.

**Aligned Memory**

Respecting the 8-bit architecture's 256-byte Page organization improves machine language efficiency.  We've already seen how using Page Zero reduces code size and execution time.  There is more to consider when accessing memory outside of Page Zero.  The 6502's X and Y index registers are used in machine language instructions to offset a target memory address relative to the starting address by 0 to 255 bytes.  When the resulting target address is in a different page of memory than the starting address it costs the instruction more time to access the memory. Therefore programs benefit when keeping related data organized in the same Page.

The Atari's ANTIC graphics chip reads memory to provide data for several graphics features.  As previously mentioned, while ANTIC does have access to the entire 16-bit address space it also has limits either on the starting address or in the amount of contiguous memory it can read.

| Feature | DMA address | Starting Address Limit | Max Contiguous RAM |
| --- | --- | --- | --- | 
| Display List | 16-bit | 16-bit | 1K Max (Restart with JMP instruction)|
| Display RAM | 16-bit | 16-bit | 4K Max (Restart via LMS instruction |
| Player/Missile (double-line) | Page Pointer | 1K Boundary | 1K Max |
| Player/Missile (single-line) | Page Pointer | 2K Boundary | 2K Max |
| Character Set (Modes 2, 3, 4, 5) | Page Pointer | 1K Boundary | 1K Max |
| Character Set (Modes 6, 7) | Page Pointer | 1/2K Boundary | 1/2K Max |


- **Display List** ANTIC can read the Display List beginning anywhere in memory, but it cannot read across a 1K boundary (4 Pages) in memory.  Reading past a 1K boundary requires the Display List include a JMP  (jump) instruction which reloads the Display List program counter at the new address after the 1K boundary.  But, this is not a difficult problem to avoid as even the largest possible display list is less than 1K.

- **Display RAM** The text and pixel display data can begin anywhere in memory with the exception that it does not cross over a 4K boundary in the middle of displaying a line of contiguous data.  A full screen display in ANTIC modes E and F require 8K of RAM.  The Operating System creates these Display Lists with an instruction including the LMS (Load Memory Scan) option near the middle of the screen instructing ANTIC to reload the screen memory address for the second 4K block of memory.

- **Double-Line Player Missile Graphics** This uses a one byte pointer to a page (the high byte of an address).  For this mode the Page must be at a 1K boundary.  ANTIC will read Player/Missile bitmaps from the identified 1K block beginning at this page.

- **Single-Line Player Missile Graphics** This uses a one byte pointer to a page (the high byte of an address).  For this mode the Page must be at a 2K boundary.  ANTIC will read Player/Missile bitmaps from the identified 2K block beginning at this page.

- **Character Set (2, 3, 4, 5)** This uses a 1 byte pointer to a page in memory.  These character set images for this text mode must begin on a 1K boundary, and ANTIC reads data for the character set from the identified 1K block beginning at this page.

- **Character Set (6, 7)** This uses a 1 byte pointer to a page in memory.  These character set images for this text mode must begin on a 1/2K boundary, and ANTIC reads data for the character set from the identified 1/2K block beginning at this page.

**Unaligned Memory**

General purpose data need not be organized.  Although, lists and tables which will be referenced by index benefit when they are all in the same page.


**Code: The Main Program**

This program is not very memory intensive.  The executing part can be loaded after the Atari's DUP utility (the friendly menu-driven interface for DOS, so that the MEMSAVE file to swap DUP out for another program need not be used.  A larger game that needs more storage could 

**Interrupts: Vertical Blank Interrupt**

**Interrupts: Display List Interrupt**

---

**PREVIOUS SECTION** | **Back To START** 
:--- | :---: 
[:arrow_left: . . . Title Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md "Title Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") 
 
 
