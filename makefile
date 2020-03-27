comp: source.l gram.y tablesymbole.c
	lex source.l 
	yacc -d gram.y 
	gcc lex.yy.c y.tab.c tablesymbole.c -ly -ll -o compilo