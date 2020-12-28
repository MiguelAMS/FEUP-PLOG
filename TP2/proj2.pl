:-use_module(library(clpfd)).
:-use_module(library(lists)).

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

constrainSum([], _).
constrainSum([H|T], Value):-
    sum(H, #=, Value),
    constrainSum(T, Value).

cnote(Input, Value, Output):-
    flatten(Input, Vars), % Flatten the input, [[x,y,z], [x1,y1,z1], [x2,y2,z2]] = [x,y,z,x1,y1,z1,x2,y2,z2]
    write('Input Vars: '), write(Vars), nl,
    nth1(1, Input, Row), % Row = [x,y,z]
    length(Row, N), % NxN board
    Total is N*N,
    write('Input N: '), write(N), nl, write('Input NxN: '), write(Total), nl,
    length(Output, Total), % Output now has length Total
    domain(Output, 1, Value), % Values from Output in 1..100
    unflatten(Output, 1, N, [], Rows), % Reverse operation of flatten
    write('Output Rows: '), write(Rows), nl,
    transpose(Rows, Cols), % Gives us Cols, since we need both Rows and Cols to be = Value 
    write('Output Cols: '), write(Cols), nl,
    constrainSum(Rows, Value), % Constrains the sum of both
    constrainSum(Cols, Value), % Rows and Cols to Value
    labeling([], Output).