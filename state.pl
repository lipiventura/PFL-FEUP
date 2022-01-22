initial_state(S):- S = [[empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty]].

intermidiate_state(S):- S = [[p1,p1,p2,empty,empty,empty,empty,empty],
        [p1,p2,p2,empty,empty,empty,p2,empty],
        [empty,p2,p2,p2,empty,empty,p2,empty],
        [p1,p1,empty,empty,empty,empty,empty,empty],
        [empty,p1,empty,empty,empty,empty,empty,empty],
        [p1,empty,p1,empty,empty,empty,empty,empty],
        [empty,p1,empty,empty,p1,empty,p1,empty],
        [p2,empty,empty,empty,empty,empty,empty,p2]].

final_state(S):- S = [[p1,p1,p2,p2,p2,empty,empty,empty],
        [p1,p2,p2,p2,p2,p2,p2,empty],
        [p2,p2,p2,p2,p2,p2,p2,empty],
        [p1,p1,p1,p1,p1,p1,p2,empty],
        [p1,p1,p2,p2,p2,p1,p2,empty],
        [p1,p1,p1,p2,p1,p2,p1,p2],
        [empty,p1,p1,p1,p1,p1,p1,p2],
        [p2,p1,p1,p2,p1,p1,p1,p2]].


display_game(S):-
        showTopBoard(S,1).

display_game_AI(S):-
        showTopBoardOpt2(S,1).

display_game_only_AI(S):-
        showTopBoardOpt3(S,1).


showTopBoard(S,1):- nl,
            write('           Player '), write(1), write(' Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            gameNotOver(S,p1,p2),
            doChanging(S,SNew,p1,p2),
            showTopBoard(SNew,2).

showTopBoard(S,2):- nl,
            write('           Player '), write(2), write(' Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            gameNotOver(S,p2,p1),
            doChanging(S,SNew,p2,p1),
            showTopBoard(SNew,1).

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



playerID(p1,1).
playerID(p2,2).


gameNotOver(S,P,P2):- playableColumn(S,1,1,P,P2,0,N2),
                      playableColumn(S,2,1,P,P2,0,N3),
                      playableColumn(S,3,1,P,P2,0,N4),
                      playableColumn(S,4,1,P,P2,0,N5),
                      playableColumn(S,5,1,P,P2,0,N6),
                      playableColumn(S,6,1,P,P2,0,N7),
                      playableColumn(S,7,1,P,P2,0,N8),
                      playableColumn(S,8,1,P,P2,0,N9),
                      N10 is N2 + N3, N11 is N10 + N4,
                      N12 is N11 + N5,N13 is N12 + N6,
                      N14 is N13 + N7,N15 is N14 + N8,
                      X is N15 + N9,handleN(S,P2,X).

handleN(S,P,0):- nl,write('               Game Over!                 '),nl,
               game_over(S,P),
               nl,play.


game_over(S,P):- emptyRow(S,1,1,empty), nl,write('               It\'s a Tie!               ').
game_over(S,P):- nl,write('              Player '),playerID(P,N),write(N),write(' Won!             ').


handleN(S,P,X):- true.               

doChanging(S,SNew,P,P2):- repeat,
                       rowSelection(Row),
                       columnSelection(Column),
                       masterRule(S,Row,Column,P,P2),
                       changeBoard(S,SNew,Row,Column,P).



showTopBoardOpt2(S,1):- nl,
            write('           Player '), write(1), write(' Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            gameNotOver(S,p1,p2),
            doChanging(S,SNew,p1,p2),
            showTopBoardOpt2(SNew,2).

showTopBoardOpt2(S,2):- nl,
            write('           Computer Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            listOfAll(S,SNew,p2,p1,X),
            canProceed(S),
            showTopBoardOpt2(SNew,1).


showTopBoardOpt3(S,1):- nl,
            write('           Computer 1 Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            listOfAll(S,SNew,p1,p2,X),
            canProceed(S),
            showTopBoardOpt3(SNew,2).

showTopBoardOpt3(S,2):- nl,
            write('           Computer 2 Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            listOfAll(S,SNew,p2,p1,X),
            canProceed(S),
            showTopBoardOpt3(SNew,1).
