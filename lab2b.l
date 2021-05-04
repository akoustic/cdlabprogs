/* program to obtain result from infix expression */
%{
    #include "y.tab.h"
    extern yylval;
%}
%%
[a-zA-Z][a-zA-Z0-9]* { return ID; }
[0-9]+ {yylval = atoi(yytext);
        return NUMBER;
        }
[ \t]+ ;
\n { return 0; }
. { return yytext[0]; }
%%