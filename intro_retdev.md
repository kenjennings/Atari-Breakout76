
**Why Retro Computer Game Programming?**

Many people alive today were born so long after the introduction of the first personal computers and video games that they have never had the opportunity to experience the systems that created these industries.  Retro systems are new to them, and these technology fans are making retro systems a cool and trendy hobby.  

Many retro systems have reached the 40 year mark.  Age can make the systems fragile, and simply powering them up can burn out decades-old chips and circuits.  Likewise, data storage devices and media are deteriorating.  Emulators provide a practical alternative that save wear and tear on real hardware.  Modern computer capabilities have grown to the point where they can perfectly emulate most retro systems down to the exact machine cycle.  Emulators make it possible to enjoy retro systems virtually for free.  They also supply benefits not possible on the real systems.  Many emulate floppy disks allowing the retro systems' disks to reside as files on the computer hosting the emulator which eliminates the need to risk ruining decades-old floppy disks.

Current technology provides modern programming tools not available to the programmers decades ago.  Integrated Development Environments, editors with syntax hilighting, and cross-platform compilers allow working in a larger, more comfortable environment with near-instant build times that programmers working on the original retro systems would have envied.

Developing for retro systems teaches awareness of data representation and processing efficiency that is not obvious on modern computers with gigahertz CPUs, multi-gigabyte operating systems, and terabytes of storage.  Observe the multiple orders of magnitude difference of processing and storage between a retro system and a commodity personal computer in 2018:

Topic | Retro System | 2018 commodity PC | Factor Increase
--- | --- | --- | ---
CPU Speed | 1 to 2 MHz | 2+ Ghz | * 1000 to 2000
Memory | 4 to 64 Kilobytes | 4 - 8 Gigabytes | * 60,000 to 195,000
Storage | 90 to 360 Kilobytes | 1 - 2 Terabytes | * 2.7 to 22 million
I/O speed | 300 bits to 19 Kilobits per sec |  600 Megabytes per sec (Sata 3) | * 252,000 to 16 million

Modern game development requires an entire company of developers, artists, engineers, actors, writers, salespeople, and accountants to meet the expectations of gamers demanding original orchestral soundtracks, hours of cut scenes, extensive back stories, complex equipment and upgrade schemes, non-player artificial intelligence, and first person perspective in a photorealistic world rendered at 75 blood splatters per second.   In contrast, retro systems are simple enough that one person can develop a perfectly enjoyable and playable video game.

Modern computers are phenomenally more powerful than the first personal computers.  However, those early computers could do many of the things people do with computers today, just a little slower -- editing text, printing documents, also programming.  A few of the computers of days past provided sufficient graphics capabilities making digital art and illustration practical.  There are a few things that they did not do:  The Internet did not exist, so networking, web browsing, and email were not concerns.

Everything is limited on a retro computer.  The smaller memory restricts the size of work the computer can manage at one time.  The slower storage I/O takes it longer to load files, but in comparison, modern computers are sometimes painfully inefficient, too.  Although they may be many tens of thousands times faster with millions of times more memory and storage, they still make users inexplicably wait and run slowly while churning through unimaginable megabytes of data on disk.  I am often infuriated by how long it takes for seemingly simple things to occur on modern PCs.  We have Object oriented languages to thank.  This has monstrously bloated applications and Operating Systems with repetetive memory thrashing, redundant code, and garbage collection.

---

**Why Atari 8-bit Computers?**

There are other systems that were more popular back in the day, but the Atari has unique features that separate it from others.

Ataris are very reliable.  If you intend to acquire a real system the Ataris were built to be very sturdy and robust.  The original 400 and 800 models are like tanks.  While the XL models represent Atari's effort at cost reduction, the company still could not bring themselves to cheapen the construction to the same degree as other cmputer systems.  They do not have overheating problems common to other retro computers.  Though the Ataris sold fewer units than other computers, fully working computers are still easy to find today.

The Atari 8-bit computers are the evolutionary step between the Atari 2600 video game system and the Amiga computers.  The custom graphics and hardware in the three systems share design similarities, because they shared the same hardware engineers.  When one is familiar with the custom chipsets of the three systems it is easy to see An Atari computer as the 8-bit version of an Amiga, or as a more powerful and easier to program 2600.

Considering the Atari was designed in the 70s it has remarkably flexible graphics that in some aspects would not be exceeded by other computers until the Amigas appeared.  Without utilizing any interrupts or complex timing tricks the display hardware can inherently do the following:

- Fully programmable playfield via a Display List that enables mixing graphics modes with no interrupts or CPU intervention.

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
