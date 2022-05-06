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

 if_statement:
  IF LPAREN expression RPAREN tail else_if optional_else
  {
    $$ = new_ast_if_node($3, $5, elsifs, elseif_count, $7);
    elseif_count = 0;
    elsifs = NULL;
  }
  | IF LPAREN expression RPAREN tail optional_else
  {
    $$ = new_ast_if_node($3, $5, NULL, 0, $6);
  }
%%
int main(int argc, char **argv)
{
  yyparse();
}

void yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}