
Retro System Game Development

Atari Computer



To Almighty God, Creator of semiconductor chemistry and physics making all this fun possible.



**Why Retro Computer Game Programming?**

Many people alive today were born so long after the introduction of the first personal computers and video games that they have never had the opportunity to experience the systems that created these industries.  Retro systems are new to them, and these technology fans are making retro systems a cool and trendy hobby.

Another good reason is that a typical game on a retro system operates at a guaranteed frame rate related to the television/CRT standard.  The computer and graphics subsystems are heavily tied to the television display rate, therefore game design follows the same by necessity.  This provides the player an extremely consistent, smooth, and predictable gameplay experience lacking in many modern games.

Developing for retro systems teaches awareness of data representation and respect for processing efficiency.  These lessons are not obvious on modern computers with gigahertz CPUs, multi-gigabyte operating systems, and terabytes of storage.

Retro systems are simple enough that one person can develop a perfectly enjoyable and playable video game.  Today, good games on modern platforms written by a single author are not so common.  The entry barrier to modern game development is monumental.  Modern game development often requires an entire company of programmers, artists, engineers, actors, writers, salespeople, and accountants to meet the gamers expectations for original orchestral soundtracks, hours of cut scenes, extensive back stories, complex equipment and upgrade schemes, non-player artificial intelligence, and first person perspective in a photorealistic world rendered at 47 blood splatters per second.


**The Real Deal or Emulation**

In 2018 many retro systems have reached the 40 year mark.  Age can make the systems fragile, and simply powering them up can destroy decades-old chips and components.  Likewise, data storage devices and media are deteriorating.  The magnetic media on ancient floppy disks can be stripped off just by contact with the disk drive read head.  Some computer systems have a reputation for overheating to the point of self-destruction and age has made this issue worse.  Keeping a retro system working can require technical skills to replace components.  However, there is no substitute for the glow of pixels on a real CRT and operating games with the original controllers for which they were designed.

Emulators provide a practical alternative that save wear and tear on real hardware.  Modern computer capabilities have grown to the point where they can perfectly emulate most retro systems down to the exact machine cycle.  Emulators make it possible to enjoy retro systems virtually for free.  They also supply benefits not possible on the real systems.  Many emulate floppy disks allowing the retro systems' disks to reside as files on the computer hosting the emulator and so eliminate the risk of ruining decades-old disks.  However, some emulators display impossibly perfect pixels in unnatural aspects ignoring the analog CRT nature that made retro games beautiful.

Development tools on retro systems are limited, because the computers are limited.  Current computers allow modern programming tools not available to the programmers decades ago --  Integrated Development Environments, editors with syntax hilighting, and cross-platform compilers allow working in a larger, more comfortable environment with near-instant build times that programmers working on the original retro systems would have envied.  The hybrid decision is to take advantage of the advanced development tools on a modern computer, but actually run the programs on real hardware.



**Why Atari 8-bit Computers?**

There are other systems that were more popular back in the day, but the Atari has unique features that separate it from others.

The Atari 8-bit computers are the evolutionary step between the Atari 2600 video game system and the Amiga computers.  The custom graphics and hardware in the three systems share similarities, because they share the same hardware engineers.  When one is familiar with the custom chipsets of the three systems it is easy to see An Atari computer as the 8-bit version of an Amiga, or as a more powerful and easier to program 2600.

If you intend to acquire a real system the Ataris were built to be very sturdy and robust.  The original 400 and 800 models are like tanks.  While the XL models represent Atari's effort at cost reduction, the company still could not bring themselves to cheapen the construction to the point that reliability suffered.  Though the Ataris sold fewer units than other computers, their high reliability makes it easy to find fully working computers today.

The Atari computers are fast.  The CPU is clocked at 1.79MHz where many other 6502 systems run at 1MHz or slower.

The Operating System is remarkable for an 8-bit computer.  Full-featured and friendly, it supports automatic booting from disk, automatic driver loading from peripherals, standard, centralized I/O for devices, game controller polling, and built-in support for the system's graphics.

One only need look at the Atari's SIO bus to learn where USB comes from. SIO is a single serial port to which all peripherals daisy-chain, not just the disk drives.  The patent holder for USB also designed SIO and credits that experience for influencing USB.

Considering the Atari was designed in the 70s it has remarkably flexible graphics that in some aspects would not be exceeded by other computers until the Amigas appeared.  The graphics chips can do many things in hardware automatically with little to no CPU intervention.

The ANTIC chip executes its own program called the Display List.  The Display List is a program in ANTIC's machine language describing screen construction.  Display List instructions identify the text or graphics mode to display on that line.  This means mixing different text and graphics modes on screen is merely a matter of using different instructions in the Display List.  Mixing graphics modes requires no 6502 machine language programming, and building a Display List can even be done in BASIC.

ANTIC provides a formidable collection of graphics modes.  Six text modes with four kinds of font rendering, and eight graphics modes of varying pixel sizes, color depth, and memory requirements.  In addition to the 14 display modes, the color processor (GTIA) provides four color interpretations for the modes.

The ANTIC hardware supports overscan graphics -- extending the playfield display horizontally and vertically to the borders of the CRT and beyond with no CPU or interrupts required.

The graphics hardware provides full support for horizonal and vertical scrolling.  In fact, full-screen fine scrolling is nearly free.  ANTIC features allow an Atari program to fine scroll the entire display including the overscan area at 60 frames per second with negligible time from the 6502 CPU.

The Atari has a big color palette -- ordinarily 128 colors (256 in special circumstances.)  Eight shades of 16 colors.  The Atari has more shades of a single color than some computers have colors.  In most graphics modes, there are no fixed colors.  All the colors on the screen are chosen by indirection (hardware color registers).  If you desire a tree displayed in four shades of green you can do it.

The Atari has eight overlay objects called "Player/Missile" graphics which other systems may refer to as "Sprites" or "MOBs".  Four are 8-bits wide, and four are 2 bits wide.  Each is entirely independent of the text/graphics mode, can be independently sized, have its own colors, and can range up to the entire screen height.  Various priority settings can change the stacking order and move Players above or below playfield graphics, and also blend colors between multiple Players/Missiles and the playfield graphics. 

The Atari has the POKEY sound chip supplying four-voice sound.  Designed for sound effects its capabilities range from pure tones, to electric guitars, to car engines, to rocket ships, and with some CPU assistance, digitally sampled sounds.  The chip also supplies several high resolution timers.



---


Observe the multiple orders of magnitude difference of processing and storage between a retro system and a commodity personal computer in 2018:

Topic | Retro System | 2018 commodity PC | Factor Increase
--- | --- | --- | ---
CPU Speed | 1 to 2 MHz | 2+ Ghz | * 1000 to 2000
Memory | 4 to 64 Kilobytes | 4 - 8 Gigabytes | * 60,000 to 195,000
Storage | 90 to 360 Kilobytes | 1 - 2 Terabytes | * 2.7 to 22 million
I/O speed | 300 bits to 19 Kilobits per sec |  600 Megabytes per sec (Sata 3) | * 252,000 to 16 million


Modern computers are phenomenally more powerful than the first personal computers.  However, those early computers could do many of the things people do with computers today, just a little slower -- editing text, printing documents, also programming.  A few of the computers of days past provided sufficient graphics capabilities making digital art and illustration practical.  There are a few things that they did not do:  The Internet did not exist, so networking, web browsing, and email were not concerns.

Everything is limited on a retro computer.  The smaller memory restricts the size of work the computer can manage at one time.  The slower storage I/O takes it longer to load files, but in comparison, modern computers are sometimes painfully inefficient, too.  Although they may be many tens of thousands times faster with millions of times more memory and storage, they still make users inexplicably wait and run slowly while churning through unimaginable megabytes of data on disk.  I am often infuriated by how long it takes for seemingly simple things to occur on modern PCs.  We have Object oriented languages to thank.  This has monstrously bloated applications and Operating Systems with repetetive memory thrashing, redundant code, and garbage collection.



---




same degree as other computer systems.

assembly programming to sustain the is requires no 6502 CPU time and can be done in BASIC. without  This is a very power feature as many other 8-bit computers from the era either can't support multiple display modes on the screen, or require complex interrupts to change video registers.


(Display List commands identify the text or graphics mode to display on that line.), and optional ly the 16-bit address of the start of screen memory for that line, plus options indicating the line performs horizontal or vertical fine scrolling.  Each text or graphics mode line requires an instruction.  

The Display List supports the following features:

- Six text modes with four kinds of character rendering including lowercase descenders.  Also supports redefinable characters, and vertical mirroring.

- Eight pixel graphics modes of varying pixel sizes, color depth, and memory requirements.

- Four kinds of color interpretation modes can be applied to the 14 screen display modes described above.

- The graphics output supports vertical and horizontal overscan display.

- Fine scrolling supports movement up to 16 color clocks horizontally, and 16 scan lines vertically.

- "Sprites", aka Player/Missile graphics displays four, 8 pixel-wide Players, and four 2 pixel-wide Missile objects that can be the height of the screen.

- Missiles may be group together as a fifth player.

- Players and Missiles fully independent of Playfield dimensions and can be moved into the vertical or horizontal overscan area.

- Player/Missile pixel width may vary (1x, 2x, 4x), and pixel height may vary (1x, 2x)

- Full hardware collision detection between Players, Missiles, and Playfield colors specific to the individual Playfield color and Player/Missile object.

- Multiple priority schemes allow Player/Missiles and Playfield graphics to have different display priorities over one another. 

- Colors for the playfield and Player/Missile graphics are defined indirectly through nine color registers that can be set to any of 128 available colors.

- Additional color can be created by priority options that merge the colors of overlapping pixels between multiple Players/Missile, and the Playfield.

The Atari's audio hardware designed for game sound effects is also significant.  Audio capabilities include:

- Four audio channels.

- 8-bit or 16-bit frequency 

- several waveforms and multiple pseudo-random noise patterns.

- Volume-only mode on each voice for playing digital samples.

- 15Khz or 64Khz or 1.79MHz clocks

- High pass filter

Additionally, the system hardware supports:

- Hardware random number generator

- 2 or 4 game ports (depending on computer model) doubling as programmable I/O ports.

- light pen support

- Multiple high-resolution timers.

- Standard 19.2 Kilobit serial I/O, maximum 127 Kilobit.

The Atari comes with a comprehensive Operating System that provides:

- Automatic booting and driver loading from peripherals.

- Standard, centralized I/O library defining devices for Cassete, Disk, Printer, Screen graphics, and the full-screen text Editor.

- Support for creating graphics displays, plotting, drawing, and filling.  Displays may be full screen or include a scrolling text window.

- Basic floating-point math library

- Game controller polling.
