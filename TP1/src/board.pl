initialBoard([
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty]
]).


symbol(empty, S):- S= '.'.
symbol(red, S):- S= 'X'.
symbol(blue, S):- S= 'O'.

/*Since the game itself doesn't have square notation, we decided to adopt the chess notation, meaning that rows are designated by numbers and columns by letters, from left to right and bottom to top*/
printBoard(X):-
    nl,
    write('   | A | B | C | D | E | F |\n'),
    write('---|---|---|---|---|---|---|\n'),
    printMatrix(X, 1).

/*How to add notation to both sides of the board (?????)*/
printMatrix([], 7).
printMatrix([H|T], X):-
	write(' '),
	write(X),
    write(' | '),
	X1 is X + 1,
    printLine(H),
    nl,
	write('---|---|---|---|---|---|---|\n'),
    printMatrix(T, X1).

printLine([]).
printLine([H|T]):-
	symbol(H, S),
    write(S),
    write(' | '),
    printLine(T).