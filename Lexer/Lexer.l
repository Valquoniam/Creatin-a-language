%{

%}

%%

   /* Recognizing numbers */
   
[-]?[0-9]+ {yylval= atoi(yytext); return INT;} 
[-]?[0-9]+\.[0-9]+ { yylval = atof(yytext); return FLOAT; }