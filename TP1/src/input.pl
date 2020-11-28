readRow(NextRow):-
	write('Choose a row:\n'),
	read(Row),
	checkRow(Row, NextRow).
	
readColumn(NextColumn):-
	write('Choose a column:\n'),
	read(Column),
	checkColumn(Column, NextColumn).
	

checkRow(1, NextRow):-
	NextRow = 1.

checkRow(2, NextRow):-
	NextRow = 2.

checkRow(3, NextRow):-
	NextRow = 3.

checkRow(4, NextRow):-
	NextRow = 4.

checkRow(5, NextRow):-
	NextRow = 5.

checkRow(6, NextRow):-
	NextRow = 6.

checkRow(_Row, NextRow):-
	write('Invalid row! Select again!\n'),
	readRow(NextRow).



checkColumn('A', NextColumn):-
	NextColumn = 1.
checkColumn(a, NextColumn):-
	NextColumn = 1.
	
checkColumn('B', NextColumn):-
	NextColumn = 2.
checkColumn(b, NextColumn):-
	NextColumn = 2.
	
checkColumn('C', NextColumn):-
	NextColumn = 3.
checkColumn(c, NextColumn):-
	NextColumn = 3.
	
checkColumn('D', NextColumn):-
	NextColumn = 4.
checkColumn(d, NextColumn):-
	NextColumn = 4.
	
checkColumn('E', NextColumn):-
	NextColumn = 5.
checkColumn(e, NextColumn):-
	NextColumn = 5.
	
checkColumn('F', NextColumn):-
	NextColumn = 6.
checkColumn(f, NextColumn):-
	NextColumn = 6.

checkColumn(_Column, NextColumn):-
	write('Invalid column! Select again!\n'),
	readColumn(NextColumn).
