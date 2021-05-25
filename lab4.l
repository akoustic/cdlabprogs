/* program to translate the language constructs to an intermediate form (e.g. three-address code) */
%{
    #include "y.tab.h"
    extern yylval;
%}
ALPHA [A-Za-z]
DIGIT [0-9]
%%

{ALPHA}({ALPHA}|{DIGIT})* return ID;
{DIGIT}+ {yylval=atoi(yytext); return NUM;}
[\n\t] yyterminate();
. return yytext[0];
%%