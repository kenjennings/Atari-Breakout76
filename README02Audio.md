# Atari-Breakout76 AUDIO

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Display Asset Estimation]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README01AssetEstimation.md "Display Asset Estimation" ) | [. . . README . . .]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README" ) | [Gameplay . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README03Gameplay.md "Gameplay" ) 

---

**AUDIO**:

So far three apparent sounds ....

The individual tones were isolated from a YouTube video of gameplay on actual hardware.  The mono waveform was analyzed in Audacity and the loudest/dominant frequency is reported below.

Object  | Sound  | Pitch/Freq
------- | ----------- | ---------
Paddle  | High        | B6/2000 Hz 
Borders | Medium      | B5/987 Hz
Bricks  | Low         | B4/488 Hz

The score counter increment relates to the sounds played. One strike on a Yellow Brick causes one point added to the score, and one tone.  One strike to a Green Brick adds three points to the score, and plays three tones. And so forth: Five tones for Orange, and 7 tones for Red.  

The change in score is immediate, but the tones play while the ball continues moving.  The ball movement does not stop for the audio. The multiple-tone playback will need to be multi-tasking to continue.

Some emulators play a  tone with a slight warble, click, or interruption in the audio.  This could be an artifact of slow emulation of the hardware rather than actual hardware behavior.

---

**PREVIOUS SECTION** | **Back To START** | **NEXT SECTION**
:--- | :---: | ---:
[:arrow_left: . . . Display Asset Estimation]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README01AssetEstimation.md "Display Asset Estimation" ) | [. . . README . . .]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README.md "README" ) | [Gameplay . . . :arrow_right:]( https://github.com/kenjennings/Atari-Breakout76/blob/master/README03Gameplay.md "Gameplay" ) 
