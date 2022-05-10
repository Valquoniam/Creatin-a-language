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
"\n"    { linenumber++; return EOL; }
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



"TWO OF US"  {return OR; }
"COME TOGETHER"  {return AND;}
"IMAGINE"  {return IF; }
"WAIT"  {return ELSE; }
""  {return THEN; }
"TILL THERE WAS YOU"  {return WHILE;}
"FOR NO ONE"  {return FOR; }
"I'LL BE BACK"  {return RETURN; }
""  {return BREAK; }
""  {return CHAR; }
""  {return INT; }
""  {return FLOAT; }
""  {return DOUBLE; }
"I'LL BE BACK"  {return RETURN; }
"YES IT IS"  {return TRUE; }
"NO REPLY"  {return FALSE; }
%%

