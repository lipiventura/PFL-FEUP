# PFL Project - Mitozo

## Group Mitozo_3

Diogo Martins - up201806280

Manuel Moreira - up201402718

Maria Francisca Almeida - up201806398

## Instalation and Execution
To run our game, you need to follow these very simple steps:
1. Open SICStus Prolog comand line;
2. In the file menu, choose option 'Consult' and choose the game.pl file;
3. type 'play.' in the SICStus console;
4. Choose the game mode and have fun.

## Game Description

Mitozo is an abstract strategy game for two players, one with the white pieces and the other with the black pieces, in an eight by eight regular square board.

Starting with an empty board, both players take turns in placing one piece on the board. The main rule of the game is that if the piece to be placed is going to contact the opponent, it also must contact a previous piece from the player.

The game ends when it is impossible for a player to place a piece anywhere on the board following the rule previously mentioned before the board is full.

### Menu
After calling the play/0 predicate, our application displays a main menu with the following options: <br>
![main_menu](https://user-images.githubusercontent.com/50628491/150694824-ac350ab0-a0c5-4629-8677-749de55c2d87.png) <br>
In the first 5 options, you can choose the game mode, alongside the difficulty of the Computer, and in the 6th option, you can choose Demo versions to fast forward the game: <br>
![demo_menu](https://user-images.githubusercontent.com/50628491/150696127-b6863806-2667-40d4-aa07-31156287cc3a.png) <br>
For example, if you choose the option 'Final state (C vs C)', the application will show you a board with a final state of the game in mode Computer vs Computer. <br>
![image](https://user-images.githubusercontent.com/50628491/150696302-59e7f435-3fc7-447b-857e-f0c4801c7c0e.png) <br>
We used the Demo option to, mainly, evaluate our game_over function and to check if, towards the end, our game was still functional. <br>
Finally, by choosing option 7, you can either go back to main menu if you are in the Demo menu and to exit our application if you are in the main menu.
During the game, if you want to quit and go back to the main menu, you only need to input 'r'.

## Game Logic

### Internal Representation of the Game State

We represent the game state with a list of lists that have the same dimensions of the board Mitozo played in (8x8).

Each row of the board has three different states.
It can be empty, wich means there are no pieces on that square at the moment, a p1 that represents player 1 and a p2 that represents player 2.

In the next three subsections we have the internal state representation at different moments of the game.

#### Initial Representation

The predicate responsible for the drawing of the board is called display_game(+GameState), that calls another predicate to draw every line of the board. Mitozo is a game played only in an eight by eight board, so we don't have the need to have different sizes of the board.

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

The game ended with the victory of player 2 and a message appears so the players can know the game is over and who won.

![image](https://user-images.githubusercontent.com/39671616/148706111-d2d41cf4-3c49-40b2-8284-b4646ba09c68.png)

### How to Move
Against Computer: To choose your move, you simply have to follow the instructions printed on the console. The console will print a message asking for you to choose the Row and Column where you want to play. After the masterRuleAI/5 is verified, the program calls the predicate move(+GameState, +Move, -NewGameState, +Player). This function calls changeBoard/5 to register your move in the board.

![move](https://user-images.githubusercontent.com/39671616/150687484-af19398e-b15e-45e4-b497-7580a23bf0e4.PNG)

Against Player: The process is similiar to the computer, however the process behind the moves are a little bit diferent. We start by calling the function doChanging/4, in which it repeats a cycle unitl the move is valid. First we use rowSelection/1 and columnSelection/1 for the player to input their move adn checks if the move is out of bounds. If not, then we check if the move is valid in the game rules with masterRuleAI/5. If everything is valid then we execute changeBoard/5 to register the move in the board.


### End of Game

Mitozo ends when the board is full (draw) or a player cannot make a move on his turn. We implemented a predicate game_over(+GameState, +Player) that is called when there are no more moves for that player to exit the game loop and display a Game Over message. This predicate is as follows.

![game_over](https://user-images.githubusercontent.com/39671616/150495941-65767106-f62b-478c-9975-4d943f28e295.PNG)

We keep the game loop going while there are still moves left to play using the predicate called valid_moves/2. When this functions returns an empty list, then there are no more possible moves, meaning the game is over, which is detected by predicate handleList/5 when the player that looses is the Computer, and handlePlayerList/5 for the P vs P mode. Both of them call the game_over/2 predicate mentioned.

### List of Valid Moves

The list of valid moves is created by the predicate valid_moves(+GameState, -Moves). This predicate returns the valid moves still available to play (if there are any) and also appends them to a list. The list of moves is composed of a list with the moves available to play by player 1 and 2, being that the player 1 moves are inside of a list. The list has lists with the column and row of a move.

![valid_moves](https://user-images.githubusercontent.com/39671616/150687146-5e07f32f-941a-4288-b115-af28ea1434fd.PNG)


### Evaluation of the Game State
We evaluate the Game State using two functions. First we use valid_moves/2 to obtain a list of every possible play for the two players, keeping them in the L parameter. Then, with checkBestOption(+State,-NewState,+List,+Player,+N,+Move) we check the number of moves left to the opponent for each play available in L. This predicate takes each move available, uses the predicate move/4 to get the state if that move was done, and with that state calls predicate valid_moves/2 to get the list of valid moves of the opposite player if the move was done, and then bestOptions/8 helps identify the move that would make the opposite player have the least available moves. The predicate bestOptions/8 calls predicate checkBestOption/6, being this a cycle that ends when the whole list of available moves is analyzed.


### Computer's Move
To implement the Computer's moves, we used valid_moves/2 to list all the possible moves for the computer. According to the level we're in, the computer will choose the move. In the "easy" level, the computer just chooses a random move in the available moves. But the next level is a little more complicated. In this level, the AI evaluates the number of moves left, i.e., for each available play, the AI evaluates the moves his opponent has left, choosing to play in the spot that leaves fewer options to the opponent. To accomplish this, a predicate choose_move(+GameState, +Level, -Move) is needed and calls the list of valid moves to choose from. Then handleList(+State,-NewState,+Level,+Player,+List) calls predicate move/4 for the level "easy", and checkBestOption/6 for "hard".

![choose_move](https://user-images.githubusercontent.com/39671616/150687609-4c9836d1-6aad-4579-aa44-cefda57ca1b2.PNG)



## Conclusion
The board game Mitozo was succesfully developed in the Prolog Language. We can play against another player (Player vs Player) or against the "Computer" (Player vs Computer), since an autonomous player has been implemented with dificulty levels. And if you want, you can watch the computer playing against itself (Computer vs Computer).
However, this work turned to be quite a challenge due to the fact that Prolog differs from the usual imperative programming. Nevertheless, we are now a step closer to become great programmers due to our incresead knowledge in the Prolog Language.

## Bibliography
Mitozo game - https://boardgamegeek.com/boardgame/338168/mitozo <br>
Prolog help - https://swi-prolog.org
