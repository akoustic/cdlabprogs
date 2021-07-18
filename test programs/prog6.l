/* program to translate the language constructs to quadruple intermediate form (e.g. three-address code) */
/* to run - like any other yacc prog; */
/* input a=b-c+d*8 */
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