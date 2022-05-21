%{
#include <stdio.h>
int yylex();
void yyerror(char *s);
extern FILE *yyin;

%}

%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token OP CP
%token IF
%token OBRACE CBRACE OBRACK CBRACK
%token SEMI DOT COMMA ASSIGN
%token EQUAL DIFF SUP INF INFEQ SUPEQ

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
 
%%
int main(int argc, char **argv)
{
  int flag;
  yyin = fopen(argv[1], "r");
  flag = yyparse();
  fclose(yyin);
    
  return flag;
}

void yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}