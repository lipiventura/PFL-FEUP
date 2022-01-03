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

showTopBoard(S,P):- nl,
            write('           Player '), write(P), write(' Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            rowSelection(Row),
            columnSelection(Column),
            changeBoard(S,SNew,Row,Column,p1),
            showTopBoard(SNew,P).

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

%Row or Column Selection

rowSelection(Row):- write('Insert Row '),
                    read(Input),
                    (alphabet(R,Input) ->
                        Row = R;
                        rowSelection(Row)
                    ).

columnSelection(Column):- write('Insert Column '),
                          read(Input),
                          Column is Input.

%Replace Elements

changeList([_H|T],[Value|T],1,Value).
changeList([H|T],[H|T2],Column,Value):- Column > 1,
                                        Column2 is Column - 1,
                                        changeList(T,T2,Column2,Value).

changeBoard([H|T],[H2|T],1,Column,Value):- changeList(H,H2,Column,Value).
changeBoard([H|T],[H|T2],Row,Column,Value):- Row > 1,
                                             Row2 is Row - 1,
                                             changeBoard(T,T2,Row2,Column,Value).

%Aesthetic

menu:- showMenu,
       read(Input),
       optionMenu(Input).

optionMenu(1):- currentState(S), showTopBoard(S,1).
optionMenu(2):- false.
optionMenu(3):- false.
optionMenu(4):- false.

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
                write('|                      4) Exit                                   |'),nl,
                write('|                                                                |'),nl,
                write('|                      --INSERT OPTION--                         |'),nl,
                write('|                                                                |'),nl,
                write(' ----------------------------------------------------------------'),nl,nl.
