/** -------------------Lexer of Valentin and Axel----------------------**/

/* Definition section*/

%{
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

char* list of tokens;
%}

/*Rule section*/

%%
LET IT BE {   ;}
PAPERBACK WRITER {   ;}
IMAGINE {   ;}
WAIT {   ;}
FOR NO ONE {   ;}
TILL THERE WAS YOU {   ;}
YES IT IS {   ;}
NO REPLY {   ;}
I WILL BE BACK {   ;}
COME TOGETHER {   ;} 
TWO OF US {   ;}
%%

/*Code section*/



int main()
{
    yylex();
    return 0;
}
