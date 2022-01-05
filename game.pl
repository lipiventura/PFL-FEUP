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


showTopBoard(S,1):- nl,
            write('           Player '), write(1), write(' Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            doChanging(S,SNew,p1,p2),
            showTopBoard(SNew,2).

showTopBoard(S,2):- nl,
            write('           Player '), write(2), write(' Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            doChanging(S,SNew,p2,p1),
            showTopBoard(SNew,1).

doChanging(S,SNew,P,P2):- repeat,
                       rowSelection(Row),
                       columnSelection(Column),
                       masterRule(S,Row,Column,P,P2),
                       changeBoard(S,SNew,Row,Column,P).

masterRule(S,Row,Column,P,P2):- checkAll(S,Row,Column,P2);
                                \+ checkAll(S,Row,Column,P2), \+ checkAll(S,Row,Column,P).


showArcade(9,[]).
showArcade(N,[H|T]):- alphabet(A,N),write(' '),write(A),write(' | '),
                      showLine(H),
                      nl,write('___|___|___|___|___|___|___|___|___|'),nl,
                      N1 is N + 1,
                      showArcade(N1,T).

showLine([]).
showLine([H|T]):- showChar(C,H),
                  write(C),write(' | '),
                  showLine(T).

alphabet(A,1):- A = 'a'.
alphabet(A,2):- A = 'b'.
alphabet(A,3):- A = 'c'.
alphabet(A,4):- A = 'd'.
alphabet(A,5):- A = 'e'.
alphabet(A,6):- A = 'f'.
alphabet(A,7):- A = 'g'.
alphabet(A,8):- A = 'h'.

showChar(C,empty):- C = ' '.
showChar(C,p1):- C = 'X'.
showChar(C,p2):- C = 'O'.

%Row or Column Selection

rowSelection(Row):- write('Insert Row '),
                    read(Input),
                    (alphabet(Input,R) ->
                    Row is R;
                    nl,write('Insert Row Again (Correctly) '),
                    rowSelection(Row)).

columnSelection(Column):- write('Insert Column '),
                          read(Input),
                          ((Input >= 1, Input =< 8) ->
                          Column is Input;
                          nl,write('Insert Column Again (Correctly) '),
                          columnSelection(Column)).

%Replace Elements

changeList([H|T],[Value|T],1,Value) :- H = empty.
changeList([H|T],[H|T2],Column,Value):- Column > 1,
                                        Column2 is Column - 1,
                                        changeList(T,T2,Column2,Value).

changeBoard([H|T],[H2|T],1,Column,Value):- changeList(H,H2,Column,Value).
changeBoard([H|T],[H|T2],Row,Column,Value):- Row > 1,
                                             Row2 is Row - 1,
                                             changeBoard(T,T2,Row2,Column,Value).

%Rules

getRCs(Row,Row2,Row3,Column,Column2,Column3):- Row2 is Row + 1,
                                                Row3 is Row - 1,
                                                Column2 is Column + 1,
                                                Column3 is Column - 1.

checkAll(S,1,1,Value):- checkBoard(S,1,2,Value), checkBoard(S,2,1,Value).
checkAll(S,1,8,Value):- checkBoard(S,1,7,Value), checkBoard(S,2,8,Value).
checkAll(S,8,1,Value):- checkBoard(S,8,2,Value), checkBoard(S,7,1,Value).
checkAll(S,8,8,Value):- checkBoard(S,8,7,Value), checkBoard(S,7,8,Value).

checkAll(S,1,Column,Value):- Column2 is Column + 1, Column3 is Column - 1,
                             checkBoard(S,2,Column,Value),checkBoard(S,1,Column2,Value),checkBoard(S,1,Column3,Value).
checkAll(S,8,Column,Value):- Column2 is Column + 1, Column3 is Column - 1,
                             checkBoard(S,7,Column,Value),checkBoard(S,8,Column2,Value),checkBoard(S,8,Column3,Value).
checkAll(S,Row,1,Value):- Row2 is Row + 1, Row3 is Row - 1,
                          checkBoard(S,Row,2,Value),checkBoard(S,Row2,1,Value),checkBoard(S,Row3,1,Value).
checkAll(S,Row,8,Value):- Row2 is Row + 1, Row3 is Row - 1,
                          checkBoard(S,Row,7,Value),checkBoard(S,Row2,8,Value),checkBoard(S,Row3,8,Value).
                        
checkAll(S,Row,Column,Value):- Row2 is Row + 1,Row3 is Row - 1,Column2 is Column + 1,Column3 is Column - 1,
                               checkBoard(S,Row2,Column,Value),
                               checkBoard(S,Row3,Column,Value),
                               checkBoard(S,Row,Column2,Value),
                               checkBoard(S,Row,Column3,Value).

checkList([H|T],1,Value):- \+ H = Value.
checkList([H|T],Column,Value):- Column > 1,
                                     Column2 is Column - 1,
                                     checkList(T,Column2,Value).

checkBoard([H|T],1,Column,Value):- checkList(H,Column,Value).
checkBoard([H|T],Row,Column,Value):- Row > 1,
                                     Row2 is Row - 1,
                                     checkBoard(T,Row2,Column,Value).

%consult('/Users/diogofilipe/Desktop/PFL/PROLOG/game.pl'). 


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
