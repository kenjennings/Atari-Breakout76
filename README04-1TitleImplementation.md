# Atari-Breakout76 TITLE SCREEN ATARI PARTS

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Choosing Atari Parts]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04Implementation.md "Choosing Atari Parts") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") | [Game Screen Atari Parts . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04-2GameImplementation.md "Game Screen Atari Parts") 

---

**TITLE SCREEN ATARI PARTS**

The Breakout arcade game does not have a title or configuration screen.  The title graphics are on the physical cabinet.  Physical buttons manage the number of players and game initiation.

However, the Atari computer imitation of Breakout is free from the pay-for-play requirement and it can add configurability to game parameters.  This requires a minimal user interface which is best separated from the main game screen.  A separate set up screen also provides an opportunity for title graphics, or at least larger, titling text.

Top of screen banner: The Breakout cabinet art does not use many colors -- primarily Yellow, Red, Black, White plus a limited amount of Purple and a darker shade of Yellow.  Doing something with these colors in a title would be simple. 

ANTIC graphics mode D (two scan line/pixel) and mode E (one scan line/pixel) both display 160 pixels/color clocks per line in four colors, so both could display a color-reduced version of the picture.  

Also, ANTIC text modes 4 and 5 display four colors in each character matrix with an option of swapping one color with a different color register.  This could allow retaining a fifth color (Purple) for the title screen.

Alternatively, a simple title using large text modes 6 or 7 would be acceptable.

The configuration should be pre-set to the options closest to the arcade game experience.   Possible options may include:
- Number of balls: 1, 3, 5 (default), 7 
- Starting speed: slow (default), medium, fast
- Speed increments: none, 2 hits, 4 hits (default), 6 hits, 8 hits 
- Paddle size change: Yes (default), No.
- Paddle sizes: 10cc/5cc, 8cc/4cc, 6cc/3cc (default), 5cc/3cc, 4cc/2cc 
- Ball Size: 1x1, 2x2 (default), 3x3
- Number of Players: 1 (default), 2

Basic input controls on the Title/Configuration screen:
- Option key: Move to next item
- Select key: Change item value
- Start key: Start game
- Paddle button: Start game

Paddle rotation may also be used to select the values.  Without a "Back" button it is not practical to represent heirarchical input.  So, the entire set of configurable items would be treated as a flat list for the sake of paddle input.  The paddle position would move immediately to any item on the list and the paddle button chooses the selection.  The interface code will need to enforce mutual exclusion of choices under the same configuration item. 

---

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Choosing Atari Parts]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04Implementation.md "Choosing Atari Parts") | [. . . README . . .](https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README") | [Game Screen Atari Parts . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04-2GameImplementation.md "Game Screen Atari Parts") 
