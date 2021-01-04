:-use_module(library(clpfd)).
:-use_module(library(lists)).

reset_timer :- statistics(walltime,_).	
print_time :-
	statistics(walltime,[_,T]),
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.

printBoard(Board):-
    nl,
    nth1(1, Board, Row),
    length(Row, Length),
    write('|'),
    print_separator(0, Length),
    nl,
    printMatrix(Board, 0, Length).

%prints the current game matrix in a board-like way
printMatrix([], _, _).
printMatrix([H|T], X, Length):-
    write('|'),
    X1 is X+1,
    printLine(H),
    nl,
    write('|'),
    print_separator(0, Length),
    nl,
    printMatrix(T, X1, Length).

%prints a matrixs line
printLine([]).
printLine([H|T]):-
    printElement(H),
    printLine(T).

printElement(H):-
    H < 10,
    write('    '),
    write(H),
    write(' |').
printElement(H):-
    H >= 10,
    H < 100,
    write('   '),
    write(H),
    write(' |').
printElement(H):-
    H >= 100,
    H < 1000,
    write('  '),
    write(H),
    write(' |').
printElement(H):-
    H >= 1000,
    write(' '),
    write(H),
    write(' |').

print_separator(Length, Length).
print_separator(Aux, Length):-
    write('------|'),
    NewAux is Aux+1,
    print_separator(NewAux, Length).


flatten([], []) :- !. 
flatten([L|Ls], FlatL) :-
    !,
    flatten(L, NewL),
    flatten(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatten(L, [L]).


unflatten([], _, _,_ , []).
unflatten([H|T], N, N, CurrentRow, [NewCurrentRow|Rest]):-
    append(CurrentRow, [H], NewCurrentRow),
    unflatten(T, 1, N, [], Rest).
unflatten([H|T], CurrentN, N, CurrentRow, Final):-
    append(CurrentRow, [H], NewCurrentRow),
    NewCurrentN is CurrentN + 1,
    unflatten(T, NewCurrentN, N, NewCurrentRow, Final).


constrainSum([], _). %Solution must have sum equal to Value
constrainSum([H|T], Value):-
    sum(H, #=, Value),
    constrainSum(T, Value).


restriction(Var, Aux):- %Solution must contain digit Aux
    Var mod 10 #= Aux.
restriction(Var, Aux):-
    Var #> 0,
    Rest #= Var // 10,
    restriction(Rest, Aux).

addRestrictions([],_,_).
addRestrictions([H|T], Vars, Index):-
    nth1(Index, Vars, Aux), %Value of the input
    restriction(H, Aux),
    NewIndex is Index + 1,
    addRestrictions(T, Vars, NewIndex).


solution(Input, No, Value, Output):- %Board NxM ????? Only works on NxN boards right?
    unflatten(Input, 1, No, [], Matrix),
    nth1(1, Matrix, Col), % Row = [x,y,z]
    length(Col, N),
    Total is N*N, % NxN board
    length(Output, Total), % Output now has length Total
    domain(Output, 1, Value), % Values from Output in 1..100
    unflatten(Output, 1, N, [], Rows), % Reverse operation of flatten
    transpose(Rows, Cols), % Gives us Cols, since we need both Rows and Cols to be = Value 
    constrainSum(Rows, Value),
    constrainSum(Cols, Value),
    addRestrictions(Output, Input, 1),
    labeling([], Output).

cnote(Input, No, Value):-
    unflatten(Input, 1, No, [], Matrix),
    nl, write('Matrix: '), nl,
    printBoard(Matrix),
    nth1(1, Matrix, Row),
    length(Row, Length),
    reset_timer, %start timer before solution
    solution(Input, No, Value, Output),
    unflatten(Output, 1, Length, [], Result),
    write('Result: '), nl,
    printBoard(Result),
    print_time, nl,
    fd_statistics.

%cnoteGenerate(Length, Value, Output)

%cnoteRandom(Length, Value, Output)

%cnoteUnique(Length, Value, Output)