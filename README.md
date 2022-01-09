# PFL Project - Mitozo

## Group Mitozo_3

Diogo Martins - up201806280

Manuel Moreira - up201402718

## Instalation and Execution

## Game Description

Mitozo is an abstract strategy game for two players, one with the white pieces and the other with the black pieces, in an eight by eight regular square board.

Starting with an empty board, both players take turns in placing one piece on the board. The main rule of the game is that if the piece to be placed is going to contact the opponent, it also must contact a previous piece from the player.

The game ends when it is impossible for a player to place a piece anywhere on the board following the rule previously mentioned before the board is full.

## Game Logic

### Internal Representation of the Game State

We represent the game state with a list of lists that have the same dimensions of the board Mitozo in played in (8x8).

Each row of the board has three different states.
It can be empty, wich means there are no pieces on that square at the moment, a p1 that represents a white piece (player 1) and a p2 that represents the black piece (player 2).

In the next three subsections we have the internal state representation ate different moments of the game.

#### Initial Representation

The initial board is a list of empty cells as there are no pieces placed at the beggining of the game.

![Initial Game State](https://user-images.githubusercontent.com/39671616/148704376-2608d467-f020-4ada-b225-bc5dde2c895f.png)


#### Intermediate Representation

After some pieces placed, we can see some p1's and p2's in the board.

![Intermidiate Game State](https://user-images.githubusercontent.com/39671616/148705786-dc3eacf3-b7b2-413c-acac-260823406e2a.png)


#### Final Representation

In this game state, player 2 won by making sure player 1 has no more legal moves.

![image](https://user-images.githubusercontent.com/39671616/148705855-2a667902-b37f-4afa-8fc2-36fa7c53f7fa.png)




## Visualization of the Game State

The visualization of the game state is made using ASCII characters printed on the console.
The empty cells in the code are represented by an empty cell, player 1 pices by an X and player 2 pieces by an O.


#### Initial Board Visualization

At the beggining of the game, all cells are empty.

![image](https://user-images.githubusercontent.com/39671616/148706016-dd5e24d0-8d7a-456f-8a67-593246f81c8b.png)


#### Intermediate Board Visualization

The intermidiate state we chose is seen by the user as follows.

![image](https://user-images.githubusercontent.com/39671616/148706069-fa28ae0c-dd0a-4d6e-a09b-2b94ebdbeba1.png)


#### Final Board Visualization

The game ended with the victory of player 2 and a message appears so the players can know the game ended and who won.

![image](https://user-images.githubusercontent.com/39671616/148706111-d2d41cf4-3c49-40b2-8284-b4646ba09c68.png)
