# Atari-Breakout76 AUDIO

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Display Asset Estimation]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README01AssetEstimation.md "Display Asset Estimation" ) | [. . . README . . .]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README" ) | [Gameplay . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README03Gameplay.md "Gameplay" ) 

---

**AUDIO**:

So far three apparent sounds ....

The individual tones were isolated from a YouTube video of gameplay on actual hardware.  The mono waveform was analyzed in Audacity and the loudest/dominant frequency is determined to be the correct tone.  

Analysis in Audacity was a very dodgy process.  I expected to find a sine or square wave, but in two out of three samples there is an amazing amount of noise.  Only the sample for the Border has a nice, recognizeable sine wave.  The sample for the Paddle barely has shape. The sample for the Bricks/score increment seems like a very sloppy triangle or sawtooth.  

Based on how well the shape for the Border tone appears I theorize that the Breakout hardware has an oscillator/clock to generate the Border sound and then applies other digital logic to manipulate that into the higher and lower frequencies for the Paddle and Brick/Score sounds.

I wrote a test program on the Atari that repeatedly plays short tones and uses the keyboard to change the pitch.  While running this program I also played the game samples in Audacity and compared the tones from the Atari to the Breakout game.  This confirmed the dominant pitch reported in Audacity is the correct tone.

In the end, the guessing session determined:   

Object  | Sound  | Pitch/Freq | Duration | POKEY AUDF at 64KHz
--- | --- | --- | ---- | ---
Paddle  | High    | B6/2010 Hz | 31 ms (2 frames)  | 15
Borders | Medium  | B5/987 Hz | 85 ms (5 frames) | 31
Bricks/Score | Low     | B4/488 Hz | 31 ms (2 frames) | 64

The score counter increment relates to the sounds played. One strike on a Yellow Brick causes one point added to the score, and one tone.  One strike to a Green Brick adds three points to the score, and plays three tones. And so forth: Five tones for Orange, and 7 tones for Red.  

The change in score is immediate, but the tones play while the ball continues moving.  The ball movement does not stop for the audio. The multiple-tone playback will need a multi-tasking sound system to allow game movement to continue simultaneously during sound management over multiple frames.

---

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Display Asset Estimation]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README01AssetEstimation.md "Display Asset Estimation" ) | [. . . README . . .]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README" ) | [Gameplay . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README03Gameplay.md "Gameplay" ) 
