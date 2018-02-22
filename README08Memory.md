# Atari-Breakout76 Organizing Memory

**PREVIOUS SECTION** | **Back To START** 
:--- | :---: 
[:arrow_left: . . . Title Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md "Title Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") 
 
---

**Organizing Memory**

Everything resides in memory -- the program, the variables and data, the graphics images, etc.  Program memory arranged to fit the 6502 CPU preferences results in smaller, faster code.  Additionally, the custom graphics hardware in the Atari accesses memory directly and it too demands the data for graphics features be arranged in specific ways.

Recall that a 16-bit address must be described using two bytes of information.  The low byte, value 0 to 255, and the high byte, value 0 to 255.  Multiply the high byte by 256, and add the low byte to specify an address.  

The high byte value is also referred to as a "Page" value -- a pointer to the beginning of 256 contiguous bytes of memory.  Memory address $0000 to $00FF all have the high byte $00 making this block of memory "Page zero".  Memory addresses $0100 to $01FF all have the high byte $01 making this block of memory "Page one", and so forth for 256 pages each with 256 bytes.

The 6502's X and Y index registers modifies a memory reference offsetting the target address relative to the starting address by  0 to 255 bytes.  When the resulting target address is in a different page of memory from the starting address it costs an extra cycle of CPU time, so 6502 assembly programs benefit from keeping related data organized on the same page.

Not all memory in the system is accessible for a program.  Some memory is ROM for the operating system.  On some Atari models the Operating System ROM can be switched out to expose RAM at the same locations, but the Atari OS  provides useful services, so it is more trouble than it is worth to disable the operating system. 

Also, the ROM cartridge replaces RAM if it exists at that location.  Typically this is Atari BASIC.  Since the point of this exercise is an assembly language program loaded from disk we can assume the ROM cartridge is removed or on systems where the BASIC ROM is on the motherboard the user manually disables BASIC with the Option key during startup.

When the OS is active several pages at the beginning of memory are committed to OS functions.  Also, if DOS is loaded a couple more Kilobytes of low memory are committed to DOS and the disk buffers.

Overview of system memory:


Likewise, the Atari's ANTIC graphics hardware reads data from memory. While the graphics chip can access the entire 16-bit address space there are limits to how much contiguous memory the chip may automatically reference.  Also, some features use only one byte -- a Page reference -- to identify the beginning of data.

| Feature | DMA address | Starting Address Limit | Max Contiguous RAM |
| --- | --- | --- | --- | 
| Display List | 16-bit | 16-bit | 1K Max |
| Display RAM | 16-bit | 16-bit | 4K Max (Restart via LMS instruction |
| Player/Missile (double-line) | Page Pointer | 1K Boundary | 1K Max |
| Player/Missile (single-line) | Page Pointer | 2K Boundary | 2K Max |
| Character Set (Modes 2, 3, 4, 5) | Page Pointer | 1K Boundary | 1K Max |
| Character Set (Modes 6, 7) | Page Pointer | 1/2K Boundary | 1/2K Max |

**Page Zero**

**Aligned Memory**

**Unaligned Memory**

**Code: The Main Program**

**Interrupts: Vertical Blank Interrupt**

**Interrupts: Display List Interrupt**

---

**PREVIOUS SECTION** | **Back To START** 
:--- | :---: 
[:arrow_left: . . . Title Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md "Title Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") 
 
 
