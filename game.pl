%Mitozo
%Se a peça contata a adversária, deve também contatar uma sua.
%Objetivo é que antes de o tabuleiro estar completo, o advesário não consiga por mais nada.

play:- menu.

initial([empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty]).

currentState(S):- S = [[empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty]].

showTopBoard:- nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            currentState(S),
            showArcade(1,S).

showArcade(9,[]).
showArcade(N,[H|T]):- alphabet(N,A),write(' '),write(A),write(' | '),
                      showLine(H),
                      nl,write('___|___|___|___|___|___|___|___|___|'),nl,
                      N1 is N + 1,
                      showArcade(N1,T).

showLine([]).
showLine([H|T]):- showChar(C,H),
                  write(C),write(' | '),
                  showLine(T).

alphabet(1,A):- A = 'A'.
alphabet(2,A):- A = 'B'.
alphabet(3,A):- A = 'C'.
alphabet(4,A):- A = 'D'.
alphabet(5,A):- A = 'E'.
alphabet(6,A):- A = 'F'.
alphabet(7,A):- A = 'G'.
alphabet(8,A):- A = 'H'.

showChar(C,empty):- C = ' '.
showChar(C,p1):- C = 'X'.
showChar(C,p2):- C = 'O'.


%Aesthetic

menu:- showMenu,
       read(Input),
       optionMenu(Input).

optionMenu(1):- showTopBoard.
optionMenu(2):- false.

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
                write('|                      1) Play the Game                          |'),nl,
                write('|                      2) Exit                                   |'),nl,
                write('|                                                                |'),nl,
                write('|                      --INSERT OPTION--                         |'),nl,
                write('|                                                                |'),nl,
                write(' ----------------------------------------------------------------'),nl,nl.
