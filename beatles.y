%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex();
void yyerror(char *s);
extern int linenumber;
%}

%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token OP CP
%token IF ELSE WHILE FOR
%token AND OR
%token IF ELSE WHILE 


%%

calclist: /* nothing */
 | calclist exp EOL { printf("= %d\n", $2); } 
 ;

exp: factor       
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: term       
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term: NUMBER  
 | ABS term   { $$ = $2 >= 0? $2 : - $2; }
 | OP exp CP {$$ = $2;}
 ;



IfElse : IF OP condition CP OBRACE statement CBRACE
 | IF OP condition CP OBRACE statement CBRACE ELSE OBRACE statement CBRACE

condition : exp SUP exp
 | exp INF exp {$$ = $1}
 | exp INFEQ exp {$$ = $1}
 | exp SUPEQ exp {$$ = $1}
 ;



%%
int main(int argc, char **argv)
{
  yyparse();
}

void yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}