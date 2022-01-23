menu:- showMenu,
       read(Input),
       optionMenu(Input).


optionMenu(1):- final_state(S), display_game(S).
optionMenu(2):- final_state(S), display_game_AI(S,1).
optionMenu(3):- final_state(S), display_game_AI(S,2).
optionMenu(4):- final_state(S), display_game_only_AI(S).
optionMenu(5):- demoMenu.
optionMenu(6):- abort.
optionMenu(A):- nl,write('Insert a Valid Option '),read(Input),optionMenu(Input).

demoMenu:- showDemoMenu,
           read(Input),
           optionDemoMenu(Input).

optionDemoMenu(1):- intermidiate_state(S), display_game(S).
optionDemoMenu(2):- final_state(S), display_game(S).
optionDemoMenu(3):- menu. 
optionDemoMenu(A):- nl,write('Insert a Valid Option '),read(Input),optionDemoMenu(Input).

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
                write('|                      4) Computer vs Computer                   |'),nl,
                write('|                      5) Demo                                   |'),nl,
                write('|                      6) Exit                                   |'),nl,
                write('|                                                                |'),nl,
                write('|                      --INSERT OPTION--                         |'),nl,
                write('|                                                                |'),nl,
                write(' ----------------------------------------------------------------'),nl,nl.


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
            write('|                      1) Intermidiate State                     |'),nl,
            write('|                      2) Final State                            |'),nl,
            write('|                      3) Back                                   |'),nl,
            write('|                      --INSERT OPTION--                         |'),nl,
            write('|                                                                |'),nl,
            write(' ----------------------------------------------------------------'),nl,nl.
