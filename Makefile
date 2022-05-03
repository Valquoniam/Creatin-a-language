Beatles: 
	bison -d beatles.y
	flex beatles.l
	gcc -o $@ beatles.tab.c lex.yy.c -lfl
