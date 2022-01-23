%pede input, menu principal
menu:- showMenu,
       read(Input),
       optionMenu(Input).

%opções de jogo do menu principal
optionMenu(1):- initial_state(S), display_game(S).
optionMenu(2):- initial_state(S), display_game_AI(S,1).
optionMenu(3):- initial_state(S), display_game_AI(S,2).
optionMenu(4):- initial_state(S), display_game_only_AI(S,1).
optionMenu(5):- initial_state(S), display_game_only_AI(S,2).
optionMenu(6):- demoMenu.
optionMenu(7):- abort.
optionMenu(A):- nl,write('Insert a Valid Option '),read(Input),optionMenu(Input).

%pede input, menu demo
demoMenu:- showDemoMenu,
           read(Input),
           optionDemoMenu(Input).

%opções de jogo do menu da demo
optionDemoMenu(1):- intermidiate_state(S), display_game(S).
optionDemoMenu(2):- final_state(S), display_game(S).
optionDemoMenu(3):- intermidiate_state(S), display_game_AI(S,2).
optionDemoMenu(4):- final_state(S), display_game_AI(S,2).
optionDemoMenu(5):- intermidiate_state(S), display_game_only_AI(S,2).
optionDemoMenu(6):- final_state(S), display_game_only_AI(S,2).
optionDemoMenu(7):- menu. 
optionDemoMenu(A):- nl,write('Insert a Valid Option '),read(Input),optionDemoMenu(Input).

%output do menu principal
showMenu:- nl,nl, 
                write(' ----------------------------------------------------------------'),nl,
                write('|  __    __     __     ______   ______     ______     ______     |'),nl,
                write('| /\\ "-./  \\   /\\ \\   /\\__  _\\ /\\  __ \\   /\\___  \\   /\\  __ \\    |'),nl,
                write('| \\ \\ \\-./\\ \\  \\ \\ \\  \\/_/\\ \\/ \\ \\ \\/\\ \\  \\/_/  /__  \\ \\ \\/\\ \\   |'),nl,
                write('|  \\ \\_\\ \\ \\_\\  \\ \\_\\    \\ \\_\\  \\ \\_____\\   /\\_____\\  \\ \\_____\\  |'),nl,
                write('|   \\/_/  \\/_/   \\/_/     \\/_/   \\/_____/   \\/_____/   \\/_____/  |'),nl,
                write('|                                                                |'),nl,
                write('|                                                                |'),nl,
                write('|                                                                |'),nl,
                write('|                      1) Player vs Player                       |'),nl,
                write('|                      2) Player vs Computer (Easy)              |'),nl,
                write('|                      3) Player vs Computer (Hard)              |'),nl,
                write('|                      4) Computer vs Computer (Easy)            |'),nl,
                write('|                      5) Computer vs Computer (Hard)            |'),nl,
                write('|                      6) Demo                                   |'),nl,
                write('|                      7) Exit                                   |'),nl,
                write('|                                                                |'),nl,
                write('|                      --INSERT OPTION--                         |'),nl,
                write('|                                                                |'),nl,
                write(' ----------------------------------------------------------------'),nl,nl.

%output do menu da demo
showDemoMenu:- nl,nl, 
            write(' ----------------------------------------------------------------'),nl,
            write('|  __    __     __     ______   ______     ______     ______     |'),nl,
            write('| /\\ "-./  \\   /\\ \\   /\\__  _\\ /\\  __ \\   /\\___  \\   /\\  __ \\    |'),nl,
            write('| \\ \\ \\-./\\ \\  \\ \\ \\  \\/_/\\ \\/ \\ \\ \\/\\ \\  \\/_/  /__  \\ \\ \\/\\ \\   |'),nl,
            write('|  \\ \\_\\ \\ \\_\\  \\ \\_\\    \\ \\_\\  \\ \\_____\\   /\\_____\\  \\ \\_____\\  |'),nl,
            write('|   \\/_/  \\/_/   \\/_/     \\/_/   \\/_____/   \\/_____/   \\/_____/  |'),nl,
            write('|                                                                |'),nl,
            write('|                                                                |'),nl,
            write('|                                                                |'),nl,
            write('|                      1) Intermidiate State (P vs P)            |'),nl,
            write('|                      2) Final State (P vs P)                   |'),nl,
            write('|                      3) Intermidiate State (P vs C)            |'),nl,
            write('|                      4) Final State (P vs C)                   |'),nl,
            write('|                      5) Intermidiate State (C vs C)            |'),nl,
            write('|                      6) Final State (C vs C)                   |'),nl,
            write('|                      7) Back                                   |'),nl,
            write('|                                                                |'),nl,
            write('|                      --INSERT OPTION--                         |'),nl,
            write('|                                                                |'),nl,
            write(' ----------------------------------------------------------------'),nl,nl.
