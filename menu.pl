menu:- showMenu,
       read(Input),
       optionMenu(Input).


optionMenu(1):- initial_state(S), display_game(S).
optionMenu(2):- initial_state(S), showTopBoardOpt2(S,1).
optionMenu(3):- false.
optionMenu(4):- demoMenu.
optionMenu(5):- false.

demoMenu:- showDemoMenu,
           read(Input),
           optionDemoMenu(Input).

optionDemoMenu(1):- intermidiate_state(S), display_game(S).
optionDemoMenu(2):- final_state(S), display_game(S).
optionDemoMenu(3):- menu. 

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
                write('|                      2) Player vs Computer                     |'),nl,
                write('|                      3) Computer vs Computer                   |'),nl,
                write('|                      4) Demo                                   |'),nl,
                write('|                      5) Exit                                   |'),nl,
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
