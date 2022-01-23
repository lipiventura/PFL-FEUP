%para obter nr equivalente à letra dada por user para ser mais fácil de usar nos predicados
alphabet(A,1):- A = 'a'.
alphabet(A,2):- A = 'b'.
alphabet(A,3):- A = 'c'.
alphabet(A,4):- A = 'd'.
alphabet(A,5):- A = 'e'.
alphabet(A,6):- A = 'f'.
alphabet(A,7):- A = 'g'.
alphabet(A,8):- A = 'h'.

%com base no jogador diz o char da peça
showChar(C,empty):- C = ' '.
showChar(C,p1):- C = 'X'.
showChar(C,p2):- C = 'O'.