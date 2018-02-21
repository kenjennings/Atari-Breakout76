# Atari-Breakout76 Organizing Memory

**PREVIOUS SECTION** | **Back To START** 
:--- | :---: 
[:arrow_left: . . . Title Screen](https://github.com/kenjennings/Atari-Breakout76/blob/master/README07TitleScreen.md "Title Screen") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") 
 
---

**Organizing Memory**

Everything resides in memory -- the program, the variables and data, the graphics images, etc.  Program memory arranged to fit the 6502 CPU preferences results in smaller, faster code.  Additionally, the custom graphics hardware in the Atari accesses memory directly and it too prefers, in fact demands the data for graphics feature be arranged in specific ways.

Recall that a 16-bit address requires two bytes of information.  The low byte, value 0 to 255, and the high byte, value 0 to 255.  Multiply the high byte by 256, and add the low byte to specify an address.  

The high byte value is also a "Page" value which points to the beginning of 256 contiguous bytes of memory.  Memory address $0000 to $00FF all have the high byte $00 making this block of memory "Page zero".  Memory addresses $0100 to $01FF all have the high byte $01 making this block of memory "Page one", and so forth for 256 pages each with 256 bytes.

The 6502's X and Y index registers can modify a memory reference offsetting the target address relative to the starting addres by  0 to 255 bytes.  When the resulting target address is in a different page of memory from the starting address it costs an extra cycle of CPU time, so 6502 assembly programs benefit from keeping related data organized on the same page.

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
 
 
