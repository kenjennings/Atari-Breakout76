# Atari-Breakout76 GAMEPLAY

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Audio]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README02Audio.md "Audio" ) | [. . . README . . .]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README" ) | [Implementation . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04Implementation.md "Implementation" ) 

---

**GAMEPLAY**:

**OVERVIEW**:

This is a brutal game of violence and terror*.  The game is simple in concept and unforgiving in execution.  Conceived at a time when most "arcade" games were electromechanical tests of skill this game is designed to suction a quarter out of the player's pocket as fast as the player's feeble skills permit.  A typical player is not expected to clear all the bricks from one screen, much less two. In fact, the real game hardware only lasts through the second screen and then glitches out after that.

(* not really)

The game begins at a difficulty level any child could handle and quickly progresses to a speed only the twitchiest paddle jockey can survive.  But, oddly, people still love to play this game and to be humiliated by it over and over.  This is a good indicator that the game play is nicely balanced between human play time vs difficulty progression.  An easy game becomes boring.  A game perceived as impossible or that feels like it cheats the player discourages repeat play.  Many games with poor play planning simply overwhelm the player with enemies to the point where it is literally impossible to progress or win by either a human or a computer.  However, the mechanics of Breakout make it feel like it is the player's responsibility for losing the game, not that the game robbed the player.  The player can clearly see the ball, but doesn't turn the Paddle controller in time to hit the Ball.  The player is trying to hit the Ball on the edge of the Paddle to change the Ball's direction and misses.  The only one to blame is the player.

Breakout is so often immitated, because the game concept is so simple.  Breakout implementations have been a frequent rite of passage for thousands of programmers from beginners learning programming to experienced programmers learning a new language, to commercial game production houses looking to squeeze more money from a concept that refuses to die.  But, as often as not, the result can be poor or clumsy compared to the original Breakout.  Programmers, especially new ones, often over-think the game play and implement behavior that is not in the game.  Simple alterations in the game play can make the game too easy to be interesting.  Sloppy play handling and inconsistent collision detection can make the game too difficult to be playable.  The arcade game playability topics are visited below. . .  


**SERVE**:


**BRICKS, POINTS**:


**PADDLE**


**REBOUNDs, COLLISIONS**:

The arcade implementation is simple: 
- When the Ball strikes the Left or Right vertical borders the Ball is deflected in the horizontal directions.  
- When the Ball strikes a Brick it is deflected in the opposite vertical direction.  
- After striking a Brick the Ball will not be deflected by another Brick until it first rebounds from the Top Border or the Paddle.

Most of the time the Breakout game behavior requires the player rebound the Ball with the Paddle for each Brick destroyed. 

Many implementations overthink the collision behavior and make everything deflect the ball all the time.  This allows the ball to rebound repetetively between bricks.  At the least it severely reduces the game difficulty depriving the player of an authentic Breakout experience.  In some situations these games have a ball size, brick size, and motion direction that can work together to trap a ball in the line between two rows creating a zipper effect that wipes out two rows at a time.

---

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Audio]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README02Audio.md "Audio" ) | [. . . README . . .]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README" ) | [Implementation . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README04Implementation.md "Implementation" ) 
