%{
#include "beatles.tab.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int linenumber = 1;
%}

%%

"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }
"|"    { return ABS; }

[0-9]+ { return NUMBER; }
"\n"    { linenumber+=1; return EOL; }
[ \t]  { /* ignore whitespace */ }
"$".*  /* ignore comments */


"=="    {return EQUAL; }
"!="    {return DIFF; }
"<"     {return SUP; }
"<"     {return INF; }
"<="    {return INFEQ; }
">="    {return SUPEQ; }

"("     { return OP; }
")"     { return CP; }
"]"		{ return OBRACK; }
"["		{ return CBRACK; }
"{"		{ return OBRACE; }
"}"		{ return CBRACE; }
";"		{ return SEMI; }
"."		{ return DOT; }
","		{ return COMMA; }
"="		{ return ASSIGN; }



""  {return OR; }
""  {return AND;}
""  {return IF; }
""  {return ELSE; }
""  {return WHILE;}
""  {return FOR; }
""  {return RETURN; }
""  {return BREAK; }
""  {return CHAR; }
""  {return INT; }
""  {return FLOAT; }
""  {return DOUBLE; }
""  {return RETURN; }
%%

