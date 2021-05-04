/* program that identifies Function Definition and Body xof C language */
%{
    #include "y.tab.h"
    extern yylval;
%}

alpha [A-Za-z]
digit [0-9]

%%
[\t \n] ;
int|float|void|char {return TYPE};
return {return RETURN};
{digit}+ {return NUM};
{alpha}({alpha}|{digit})* {return ID};
. {return yytext[0]};
%%