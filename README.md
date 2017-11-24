# Connect4
Small iOS app in the making for Connect 4 with a twist


Four modes:

Standard:

Player vs Player
  Take turns competing against your friends on the same device. First is red and second is yellow. The player to connect four of their own pieces in a row first, wins.

Player vs AI
  Play against the mini-max algorithm of depth 3. This AI will play according to the "best" possible move up to 3 full turns into the future. When the future weights are all equal or less than 0, then the AI will play in column 4, then 3, then 5, then 2, then 6, then 1, then 7. These are considered default weight 0 moves.
  
Special (Not yet implemented):

Player vs Player
  Same as above with special moves implemented
  
Player vs AI
  Same as above but with extra branching for the special moves.
