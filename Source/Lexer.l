%{
  #include <stdlib.h>
  #include "ast.h"
  #include "Parser.tab.h"

  extern void yyerror(char *);

  int yylineno;              // Number of the line
  int yycolno = 1;           // Number of the character

  char buf[256]; // Buffer for reading string.
  char *s;
%}

%option noyywrap
%x STRING
%%

"imagine"    { yycolno += 8; return IF; }
"wait"  { yycolno += 4; return ELSE; }
"till there was you" { yycolno += 18; return WHILE; }
"for no one"  { yycolno += 10; return LOOP; }
"paperback writer" { yycolno += 16; return PRINT; }
"hey jude"   { yycolno += 8; return DEF; }

"come together" {yycolno += 13; return AND; }
"two of us"     {yycolno += 9 ; return OR; }

"yes it is" {yycolno += 9; return TRUE; }
"no reply"  {yycolno += 8; return FALSE; }

"read_i"  { yycolno += 6; return READ_INT; }
"read_r"  { yycolno += 6; return READ_REAL; }
"read_s"  { yycolno += 6; return READ_STR; }

"<"   { yycolno++; return LT; }
">"   { yycolno++; return GT; }
"<="  { yycolno += 2; return LTE; }
">="  { yycolno += 2; return GTE; }
"=="  { yycolno += 2; return EQ; }
"!="  { yycolno += 2; return NEQ; }
"%"   { yycolno += 1; return MOD; }

\"            { BEGIN STRING; s = buf; yycolno++; }

<STRING>\\n   { *s++ = '\n'; yycolno++;}
<STRING>\\\"  { *s++ = '\"'; yycolno++;}
<STRING>\"    { yycolno += 1;
                *s = 0;
                BEGIN 0;
                yylval.string = strdup(buf);
                return STR;
              }
<STRING>\n    { printf("invalid string"); exit(1); }
<STRING>.     { yycolno++; *s++ = *yytext; }

[a-zA-Z_][a-zA-Z_]* {
                    yycolno++;
                    yylval.string = strdup(yytext);
                    return ID;
                    }

[0-9]+\.[0-9]+      {
                    yycolno++;
                    yylval.realval = atof(yytext);
                    return REAL;
                    }

[0-9]+  {
        yycolno++;
        yylval.ival = atoi(yytext);
        return INT;
        }

[-+*/()\[\]{}=;:\^,] {yycolno++; return *yytext; }

\n    { yylineno++; yycolno = 1; return EOL; }

[ \t]+  yycolno++; /* Ignore Whitespaces! */

. { yycolno++; yyerror("Unrecognised Symbol!"); }

%%
