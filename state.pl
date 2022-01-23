%Estado inicial do jogo
initial_state(S):- S = [[empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty],
        [empty,empty,empty,empty,empty,empty,empty,empty]].

%Estado intermediário do jogo
intermidiate_state(S):- S = [[p1,p1,p2,empty,empty,empty,empty,empty],
        [p1,p2,p2,empty,empty,empty,p2,empty],
        [empty,p2,p2,p2,empty,empty,p2,empty],
        [p1,p1,empty,empty,empty,empty,empty,empty],
        [empty,p1,empty,empty,empty,empty,empty,empty],
        [p1,empty,p1,empty,empty,empty,empty,empty],
        [empty,p1,empty,empty,p1,empty,p1,empty],
        [p2,empty,empty,empty,empty,empty,empty,p2]].

%Estado final do jogo
final_state(S):- S = [[p1,p1,p2,p2,p2,empty,empty,empty],
        [p1,p2,p2,p2,p2,p2,p2,empty],
        [p2,p2,p2,p2,p2,p2,p2,empty],
        [p1,p1,p1,p1,p1,p1,p2,empty],
        [p1,p1,p2,p2,p2,p1,p2,empty],
        [p1,p1,p1,p2,p1,p2,p1,p2],
        [empty,p1,p1,p1,p1,p1,p1,p2],
        [p2,p1,p1,p2,p1,p1,p1,p2]].

%display do jogo player vs player
display_game(S):-
        showTopBoard(S,1).

%display do jogo player vs computer
display_game_AI(S,Level):-
        showTopBoardOpt2(S,Level,1).

%display do jogo computer vs computer
display_game_only_AI(S,Level):-
        showTopBoardOpt3(S,Level,1).


%parte de cima do jogo player vs player quando é a vez do jogador 1
showTopBoard(S,1):- nl,
        write('           Player '), write(1), write(' Playing'),nl, 
        write('                                    '),nl,
        write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
        write('---|---|---|---|---|---|---|---|---|'),nl,
        showArcade(1,S),nl,
        valid_moves(S,[H|T]),
        handlePlayerList(S,P,H),       
        doChanging(S,SNew,p1,p2),
        showTopBoard(SNew,2).


%parte de cima do jogo player vs player quando é a vez do jogador 2
showTopBoard(S,2):- nl,
        write('           Player '), write(2), write(' Playing'),nl, 
        write('                                    '),nl,
        write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
        write('---|---|---|---|---|---|---|---|---|'),nl,
        showArcade(1,S),nl,
        valid_moves(S,[H|T]),
        handlePlayerList(S,P,T),
        doChanging(S,SNew,p2,p1),
        showTopBoard(SNew,1).


%parte de cima do jogo player vs computer quando é a vez do jogador 1
showTopBoardOpt2(S,Level,1):- nl,
            write('           Player '), write(1), write(' Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            valid_moves(S,[H|T]),
            handlePlayerList(S,P,H),
            doChanging(S,SNew,p1,p2),
            showTopBoardOpt2(SNew,Level,2).

%parte de cima do jogo player vs computer quando é a vez do jogador 2
showTopBoardOpt2(S,Level,2):- nl,
            write('           Computer Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            choose_move(S,Level,[H|T]),
            handleList(S,SNew,Level,p2,T),
            canProceed(S),
            showTopBoardOpt2(SNew,Level,1).

%parte de cima do jogo computer vs computer quando é a vez do jogador 1
showTopBoardOpt3(S,Level,1):- nl,
            write('           Computer 1 Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            choose_move(S,Level,[H|T]),
            handleList(S,SNew,Level,p1,H),
            canProceed(S),
            showTopBoardOpt3(SNew,Level,2).

%parte de cima do jogo computer vs computer quando é a vez do jogador 2
showTopBoardOpt3(S,Level,2):- nl,
            write('           Computer 2 Playing'),nl, 
            write('                                    '),nl,
            write('   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |'),nl,
            write('---|---|---|---|---|---|---|---|---|'),nl,
            showArcade(1,S),nl,
            choose_move(S,Level,[H|T]),
            handleList(S,SNew,Level,p2,T),
            canProceed(S),
            showTopBoardOpt3(SNew,Level,1).

%mostra o resto do jogo (arcada)
showArcade(9,[]).
showArcade(N,[H|T]):- alphabet(A,N),write(' '),write(A),write(' | '),
                showLine(H),
                nl,write('___|___|___|___|___|___|___|___|___|'),nl,
                N1 is N + 1,
                showArcade(N1,T).

%mostra cada linha e as peças nela
showLine([]).
showLine([H|T]):- showChar(C,H),
                write(C),write(' | '),
                showLine(T).

%permite obter o jogador com base no ID ou o ID com base no jogador
playerID(p1,1).
playerID(p2,2).

%deteta quando a lista de valid moves está vazia (e o jogo chegou ao fim assim sendo)
handlePlayerList(S,P,[]):- nl,write('               Game Over!                 '),nl, inverse(P,P2), game_over(S,P2),nl.
handlePlayerList(S,P,X).

%final do jogo, diz quem ganhou e retorna ao menu
game_over(S,P):- emptyRow(S,1,1,empty), nl,write('               It\'s a Tie!               '),nl,nl, returnToMenu.
game_over(S,P):- nl,write('              Player '),playerID(P,N),write(N),write(' Won!             '),nl,nl, returnToMenu.
game_over_AI(S,P):- nl,write('              Computer Won!             '),nl,nl, returnToMenu.

