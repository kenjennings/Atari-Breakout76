
**Why Retro Computer Game Programming?**

Many people  today were born so long after the introduction of the first personal computers and video games that they have never had the opportunity to use or even see the systems that created these industries.  For those people the retro systems are new experiences and this new popluation of technology fans are making retro systems a cool and trendy hobby.  

Many retro systems have reached the 40 year mark.  Age can make the systems fragile, and simply powering them up can burn out decades-old chips and circuits.  Likewise, data storage devices and media are deteriorating.  Emulators provide a practical alternative that save wear and tear on real hardware.  Modern computer capabilities have grown to the point where they can perfectly emulate  retro systems down to the exact machine cycle.  Emulators make it possible to enjoy retro systems virtually for free.  They also supply benefits not possible on the real systems.  Many emulate floppy disks allowing the retro systems' disks to reside as files on the computer running the emulator which eliminates the need to risk ruining decades-old floppy disks.

Current computers also provide modern programming tools not available to the programmers decades ago.  Integrated Development Environments, editors with syntax hilighting, and cross-platform compilers allow working in a comfortable environment with near-instant build times that those original programmers would have envied.

Developing for retro systems teaches awareness of data representation and processing efficiency that is not very easy to explore on modern computers with gigabyte operating systems, and terabytes of storage.  Observe the multiple orders of magnitude difference of processing and storage between a retro system and a commodity personal computer in 2018:

Topic | Retro System | 2018 commodity PC | Factor Increase
--- | --- | --- | ---
CPU Speed | 1 to 2 MHz | 2+ Ghz | * 1000 to 2000
Memory | 4 to 64 Kilobytes | 4 - 8 Gigabytes | * 60,000 to 195,000
Storage | 90 to 360 Kilobytes | 1 - 2 Terabytes | * 2.7 to 22 million
I/O speed | 300 bits to 19 Kilobits per sec |  600 Megabytes per sec (Sata 3) | * 252,000 to 16 million

Modern game development requires an entire company of developers, artists, engineers, actors, salespeople, and accountants to meet the expectations of gamers demanding original orchestral soundtracks, hours of cut scenes, extensive back stories, complex equipment and upgrade schemes, non-player character artificial intelligence, and first person perspective in a photorealistic world rendered at 75 blood splatters per second.  In contrast, Retro systems are simple enough that one person can develop a perfectly enjoyable video game.

Modern computers are phenomenally more powerful than the first personal computers.  However, those early computers could do many of the things people do with computers today, sometimes a little slower -- editing text, printing documents, also programming.  Some of the computers of days past provided sufficient graphics capabilities making digital art and illustration practical.  There are a few things that they did not do:  The Internet did not exist, so networking, web browsing, and email were non-existent concerns.

The smaller memory limits the size of work the computer can manage at one time.  The slower storage I/O makes it take longer to load smaller files.  But in comparison, sometimes modern computers are painfully inefficient.  While they may be many tens of thousands times faster with millions of times more memory and storage the user's experience is not tens of thousands or millions of times faster.  Today's computers performing simple tasks still make users  wait  inexplicably and run slowly while churning through unimaginable megabytes of data on disk.  I am often infuriated by how long it takes for seemingly trivial tasks to complete on modern PCs.  

To what can we credit this advancement in personal computer performance?  We have object-oriented languages to thank.  This has monstrously bloated applications and Operating Systems with repetetive memory thrashing, redundant code, and garbage collection.

---

**Why Atari 8-bit Computers?**

There are other systems that were more popular back in the day, but the Atari's unique features separate it from the others.

Ataris are very reliable.  If you intend to acquire a real system the Ataris were built to be very sturdy and robust.  The original models 400 and 800 are like tanks.  While the XL models represent Atari's effort at cost reduction, the company still could not bring themselves to cheapen the construction to the same degree as other computer systems.  They do not overheat to the point of destroying chips which is a common problem with certain other retro computers.  Though the Ataris sold fewer units than other computers, fully working computers are still common and easy to find today.

Though often neglected in the mindshare of retro systems, Atari 8-bit computers are the evolutionary step between the widely acknowledged Atari 2600 video game system and the Amiga computers.  The custom graphics and hardware in the three systems share design similarities, because they shared the same hardware designers.  An Atari computer can be seen as an 8-bit version of an Amiga, or as a more powerful and easier to program 2600.

Considering the Atari was designed in the 70s it has remarkably flexible graphics that in some areas would not be exceeded until the Amiga appeared.  Without utilizing any interrupts or complex timing tricks the display hardware can inherently do the following:

- Fully programmable Playfield via a Display List that enables mixing graphics modes with no interrupts or CPU intervention.
- Six text modes with four kinds of character rendering including lowercase descenders.  It also supports redefinable characters, and vertical mirroring.
- Eight graphics modes of varying pixel sizes, color depth, and memory requirements.
- Four kinds of color interpretation modes can be applied to the 14 text and graphics modes described above.
- Supports display sizes up to vertical and horizontal overscan.
- Fine scrolling support up to 16 color clocks horizontally, and 16 scan lines vertically.
- "Sprites", aka Player/Missile graphics display four, 8 pixel-wide Players, and four, 2 pixel-wide Missile objects that can be the height of the screen.
- Missiles may be group together as a fifth player.
- Players and Missiles fully independent of Playfield dimensions and can be moved into the vertical or horizontal overscan area.
- Player/Missile pixel width may vary (1x, 2x, 4x), and pixel height may vary (1x, 2x). (Double-height pixels can be moved vertically one scanline at a time.)
- Full hardware collision detection between Players, Missiles, and Playfield colors specific to the individual Playfield color and Player/Missile object.
- Multiple priority schemes allow Player/Missiles and Playfield graphics to have different display priorities over one another. 
- Colors for the playfield and Player/Missile graphics are defined indirectly through nine color registers that can be set to any of 128 available colors.
- Color may be merged between multiple Player/Missiles, and between Player/Missiles and the Playfield generating more colors -- up to 23 colors on one scan line.

The sound hardware designed for game sound effects is also significant.  Audio capabilities include:

- Four audio channels.
- 8-bit or 16-bit frequency 
- several waveforms and multiple pseudo-random noise patterns.
- Volume-only mode on each voice for playing digital samples.
- 15Khz or 64Khz or 1.79MHz clocks
- High pass filter

Additionally, the system supports:

- Hardware random number generator
- 2 or 4 game ports (depending on computer model) doubling as programmable I/O ports.
- light pen support
- Multiple high-resolution timers.
- 19.2 Kilobit serial I/O, maximum 127 Kilobit.
- Peripherals are intelligent and daisy-chain to one serial port (like modern USB). 


The Atari comes with a comprehensive and friendly Operating System that provides the following facilities:

- Automatic booting and driver loading from peripherals.
- Standard, centralized I/O library defining devices for cassete, disk, printer, screen graphics, and full screen text editor.
- Support for creating graphics displays, plotting, drawing, and filling.  Displays may be full screen or include a scrolling text window for the editor.
- Basic floating-point math library
- Game controller polling.
