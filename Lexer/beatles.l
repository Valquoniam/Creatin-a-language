%{
#include "beatles.tab.h"

int linenumber=1;

%}

%%

"$".*"\n"   
"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }
"|"    { return ABS; }
[-]?[0-9]+ { yylval = atoi(yytext); return NUMBER; }
\n     { linenumber++; return EOL; }
[ \t]  { /* ignore whitespace */ }


"if"    {return IF;}
"=="    {return EQUAL; }
"!="    {return DIFF; }
">"     {return SUP; }
"<"     {return INF; }
"<="    {return INFEQ; }
">="    {return SUPEQ; }

"("     { return OP; }
")"     { return CP; }
"]"	{ return OBRACK; }
"["	{ return CBRACK; }
"{"	{ return OBRACE; }
"}"	{ return CBRACE; }
";"	{ return SEMI; }
"."	{ return DOT; }
","	{ return COMMA; }
"="	{ return ASSIGN; }

.

%%