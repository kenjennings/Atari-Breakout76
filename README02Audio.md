# Atari-Breakout76 AUDIO

**AUDIO**:

So far three apparent sounds ....

| Object  | Sound Pitch |
| ------- | ----------- |
| Paddle  | High        | 
| Borders | Medium      | 
| Bricks  | Low         | 

The score counter increment relates to the sounds played. One strike on a Yellow Brick causes one point added to the score, and one tone.  One strike to a Green Brick adds three points to the score, and plays three tones. And so forth: Five tones for Orange, and 7 tones for Red.  

The change in score is immediate, but the tones play while the ball continues moving.  The ball movement does not stop for the audio. The multiple-tone playback will need to be multi-tasking to continue.

Some emulators play a  tone with a slight warble, click, or interruption in the audio.  This could be an artifact of slow emulation of the hardware rather than actual hardware behavior.
