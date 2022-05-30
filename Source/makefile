compileAndRun: compile

compile: Lexer.l Parser.y interpreter.c ast.c sym_table.c
	bison -d Parser.y
	flex Lexer.l
	gcc -g sym_table.c interpreter.c ast.c lex.yy.c Parser.tab.c -lm -o ../Beatles

bison: Parser.y
	bison -d Parser.y

flex: Lexer.lex Parser.tab.h
	flex Lerxer.l

clean: lex.yy.c Parser.tab.h Parser.tab.c
	rm lex.yy.c Parser.tab.h Parser.tab.c

