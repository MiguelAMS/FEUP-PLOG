readRow(Row, NextRow):-
	write('Choose a row:\n'),
	read(Row),
	correctRow(Row, NextRow).
	
readColumn(Column, NextColumn):-
	write('Choose a column:\n'),
	read(Column),
	correctColumn(Column, NextColumn).
	

correctRow(1, NextRow):-
	NextRow = 1.

correctRow(2, NextRow):-
	NextRow = 2.

correctRow(3, NextRow):-
	NextRow = 3.

correctRow(4, NextRow):-
	NextRow = 4.

correctRow(5, NextRow):-
	NextRow = 5.

correctRow(6, NextRow):-
	NextRow = 6.

correctRow(_Row, NextRow):-
	write('Invalid input! Select again!\n'),
	readRow(Row, NextRow).


correctColumn('A', NextColumn):-
	NextColumn = 1.
correctColumn('a', NextColumn):-
	NextColumn = 1.
	
correctColumn('B', NextColumn):-
	NextColumn = 2.
correctColumn('b' , NextColumn):-
	NextColumn = 2.
	
correctColumn('C', NextColumn):-
	NextColumn = 3.
correctColumn('c', NextColumn):-
	NextColumn = 3.
	
correctColumn('D', NextColumn):-
	NextColumn = 4.
correctColumn('d', NextColumn):-
	NextColumn = 4.
	
correctColumn('E', NextColumn):-
	NextColumn = 5.
correctColumn('e', NextColumn):-
	NextColumn = 5.
	
correctColumn('F', NextColumn):-
	NextColumn = 6.
correctColumn('f', NextColumn):-
	NextColumn = 6.

correctColumn(_Column, NextColumn):-
	write('Invalid input! Select again!\n'),
	readColumn(Column, NextColumn).
