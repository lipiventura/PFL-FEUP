# PFL Project - Mitozo

## Group Mitozo_3

Diogo Martins - up201806280

Manuel Moreira - up201402718

Maria Francisca Almeida - up201806398

## Instalation and Execution

## Game Description

Mitozo is an abstract strategy game for two players, one with the white pieces and the other with the black pieces, in an eight by eight regular square board.

Starting with an empty board, both players take turns in placing one piece on the board. The main rule of the game is that if the piece to be placed is going to contact the opponent, it also must contact a previous piece from the player.

The game ends when it is impossible for a player to place a piece anywhere on the board following the rule previously mentioned before the board is full.

## Game Logic

### Internal Representation of the Game State

We represent the game state with a list of lists that have the same dimensions of the board Mitozo in played in (8x8).

Each row of the board has three different states.
It can be empty, wich means there are no pieces on that square at the moment, a p1 that represents player 1 and a p2 that represents player 2.

In the next three subsections we have the internal state representation ate different moments of the game.

#### Initial Representation

The predicate responsible for the drawing of the board is called display_game(GameState) calling another predicate to draw every line of the board. Mitozo is a game played only in an eight by eight board, so we don't have the need to have varying sizes of the board.

![display_game](https://user-images.githubusercontent.com/39671616/150494666-90d954f8-5db3-40b9-aa90-7bc8cb83e2a3.PNG)

The initial board is a list of empty cells as there are no pieces placed at the beggining of the game.

![Initial Game State](https://user-images.githubusercontent.com/39671616/148704376-2608d467-f020-4ada-b225-bc5dde2c895f.png)


#### Intermediate Representation

After some pieces placed, we can see some p1's and p2's in the board.

![Intermidiate Game State](https://user-images.githubusercontent.com/39671616/148705786-dc3eacf3-b7b2-413c-acac-260823406e2a.png)


#### Final Representation

In this game state, player 2 won by making sure player 1 has no more legal moves.

![image](https://user-images.githubusercontent.com/39671616/148705855-2a667902-b37f-4afa-8fc2-36fa7c53f7fa.png)




### Visualization of the Game State

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

### How to Move

### End of Game

Mitozo ends when the board is full (draw) or a player cannot make a move on his turn. We mplemented a predicate game_over(GameState, Player) that is called when there are no more moves for that player to exit the game loop and display a Game Over message. This predicate is as follows.

![game_over](https://user-images.githubusercontent.com/39671616/150495941-65767106-f62b-478c-9975-4d943f28e295.PNG)

We keep the game loop going while there are still moves left to play using another preicate called gameNotOver(GameState, Player, Player). When this predicate returns false, the game loop stops and calls the predicate game_over via a handler.

![gameNotOver](https://user-images.githubusercontent.com/39671616/150496717-9735d2f7-47d7-4df6-ba00-5b2e5e58e13a.PNG)

### List of Valid Moves
To check if a move is valid, we use the function check/5 that evaluates the board (through masterRule/5 and checkboard/4). In masterRule/5, we use the function checkAll/4 to check if a move is valid according to the game rules. Then with checkBoard/4, we check the value of the place where we want to play (if it's empty and checks the master Rule).

### Evaluation of the Game State

### Computer's Move
To implement the Computer's moves, we used the previously described functions to list all the possible moves for the computer. According to the level we're in, the computer will choose the move. In the "easy" level, the computer just chooses a random move in the available moves. But the next level is a little more complicated.

## Conclusion
The board game Mitozo was succesfully developed in the Prolog Language. We can play against another player (Player vs Player) or against the "Computer" (Player vs Computer), since an autonomous player has been implemented with dificulty levels.
However, this work turned to be quite a challenge due to the fact that Prolog differs from the usual imperative programming. Nevertheless, we are now a step closer to become great programmers due to our incresead knowledge in the Prolog Language.


