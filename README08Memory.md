# Atari-Breakout76 Organizing Memory

**PREVIOUS SECTION** | **Back To START** 
:--- | :---: 
[:arrow_left: . . . Title Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md "Title Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") 
 
---

**Organizing Memory**

Everything resides in memory -- the program, the variables and data, the graphics images, etc.  Program memory arranged to fit the 6502 CPU preferences results in smaller, faster code.  Additionally, the custom graphics hardware in the Atari accesses memory directly and it too demands the data for graphics features be arranged in specific ways.

Recall that a 16-bit address must be described using two bytes of information.  The low byte, value 0 to 255, and the high byte, value 0 to 255.  Multiply the high byte by 256, and add the low byte to specify an address.  

Memory address $0000 to $00FF all have the high byte $00.  The relationship of the 256 memory locations with the same high byte is called a "Page", so this memory with the high byte value $00 is referred to as "Page Zero".  Memory addresses $0100 to $01FF all have the high byte $01 making this block of memory "Page one", and so forth for 256 pages each with 256 bytes.  The memory organized in contiguous 256 byte blocks or Pages is significant to the 6502 processor.  Many parts of the computer are placed in memory based on a staring Page address -- the cartridge ROM location, the Operating System, and custom chips hardware registers.  

Not all memory in the system is accessible for a program.  Some memory is ROM containing the Operating System.  On some Atari models the Operating System ROM can be switched out to expose RAM at the same locations.  However, the Atari' comprehensive Operating System provides many useful services and functions, so it is usually more trouble than it is worth for a program to disable the Operating System. 

Also, the ROM cartridge replaces RAM if RAM exists at that same location.  Typically this ROM is Atari BASIC.  Since the point of this exercise is an assembly language program loaded from disk we can assume either the ROM cartridge is removed or the user manually disables BASIC with the Option key during startup on systems where the BASIC ROM is on the motherboard.

When the Operating System is active several 256 byte pages at the beginning of memory are committed to variables supporting Operating System functions.  Also, if DOS is loaded a couple more Kilobytes of low memory are committed to DOS and the disk buffers.

Overview of system memory:


Likewise, the Atari's ANTIC graphics hardware reads data from memory. While the graphics chip can access the entire 16-bit address space there are limits to how much contiguous memory the chip may automatically reference.  Also, some features use only one byte to describe a starting Page number for the beginning of data.

| Feature | DMA address | Starting Address Limit | Max Contiguous RAM |
| --- | --- | --- | --- | 
| Display List | 16-bit | 16-bit | 1K Max (Restart with JMP instruction)|
| Display RAM | 16-bit | 16-bit | 4K Max (Restart via LMS instruction |
| Player/Missile (double-line) | Page Pointer | 1K Boundary | 1K Max |
| Player/Missile (single-line) | Page Pointer | 2K Boundary | 2K Max |
| Character Set (Modes 2, 3, 4, 5) | Page Pointer | 1K Boundary | 1K Max |
| Character Set (Modes 6, 7) | Page Pointer | 1/2K Boundary | 1/2K Max |

**Page Zero**

The first Page of memory, Page Zero, is special in the system.  6502 instructions referencing addresses in any other page in memory require three bytes (the instruction byte and two address bytes). The 6502 has specific machine language instructions for Page Zero that assume the high byte value of the address is $00 and so they need only two bytes -- one instruction byte and one address byte.  Frequent references to Page Zero locations can noticably shrink program size.  

These Page Zero instructions also execute faster than the corresponding instructions referencing other memory, so they can speed up programs when execution time is critical.  Finally, the 6502 has some special instructions that only work with Page 0 locations.  These instructions use the values in Page 0 memory as a pointer to another destination address in memory.  This powerful feature enables writing reusable code that can operate against any memory in the system just by changing an address stored in Page Zero. 

Since Page Zero provides so much power and utility these 256 bytes are highly contested.  The first half of Page 0, $00 to $7F is committed to the Operating System as configuration values and working variables for managing input/output operations, the full screen editor, pixel graphics, the real-time clock, and other useful functions.

The second half of Page Zero ($80 to $FF) is primarily dedicated to the ROM cartridge program.  This ordinarily means BASIC which uses most of the page.  The remainder of the page belongs to the Floating Point library.   

The assembly language game will load from disk and there will be no ROM cartridge running in memory.  The game will also not use any Floating-Point routines.  Therefore, all of the second half of Page Zero, 128 bytes, are available to the program for use as  128 byte-sized variables or 64 address-sized variables. 


**Aligned Memory**

Respecting the 8-bit architecture's 256-byte Page organization improves machine language efficiency.  We've already seen how using Page Zero reduces code size and execution time.  There is more to consider when accessing memory outside of Page Zero.  The 6502's X and Y index registers are used in machine language instructions to offset a target memory address relative to the starting address by 0 to 255 bytes.  When the resulting target address is in a different page of memory from the starting address it costs the instruction more time to access the memory. Therefore programs benefit when keeping related data organized in the same Page.

Also, the Atari's ANTIC graphics chip reads memory to provide data for several graphics features.  As previously mentioned, while ANTIC does have access to the entire 16-bit address space it also has limits either on the starting address or in the amount of contiguous memory it can read.

- **Display List** The Display List can begin anywhere in memory, but it cannot cross over a 1K boundary (4 Pages) in memory unless the Display List includes a JMP  (jump) instruction to continue at the new address after the 1K boundary.  This is not a difficult problem to avoid as even the largest possible display list is less than 1K.

- **Display RAM** The text and pixel display data can begin anywhere in memory with the exception that it does not cross over a 4K boundary in the middle of displaying a line of contiguous data.  The full screen graphics mode in ANTIC Modes E and F require 8K of RAM.  The Operating System creates these Display Lists with an instruction including the LMS (Load Memory Scan) option near the middle of the screen instructing ANTIC to reload the display address for the second 4K block of memory.

- **Double-Line Player Missile Graphics** This uses a one byte pointer to a page (the high byte of an address).  For this mode the Page must be at a 1K boundary.  ANTIC will read Player/Missile bitmaps from the identified 1K block beginning at this page.

- **Single-Line Player Missile Graphics** This uses a one byte pointer to a page (the high byte of an address).  For this mode the Page must be at a 2K boundary.  ANTIC will read Player/Missile bitmaps from the identified 2K block beginning at this page.

- **Character Set (2, 3, 4, 5)** This uses a 1 byte pointer to a page in memory.  These character set images for this text mode must begin on a 1K boundary, and ANTIC reads data for the character set from the identified 1K block beginning at this page.

- **Character Set (6, 7)** This uses a 1 byte pointer to a page in memory.  These character set images for this text mode must begin on a 1/2K boundary, and ANTIC reads data for the character set from the identified 1/2K block beginning at this page.


**Unaligned Memory**

**Code: The Main Program**

**Interrupts: Vertical Blank Interrupt**

**Interrupts: Display List Interrupt**

---

**PREVIOUS SECTION** | **Back To START** 
:--- | :---: 
[:arrow_left: . . . Title Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md "Title Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") 
 
 
