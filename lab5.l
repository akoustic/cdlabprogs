/* program to generate target code (in assembly language) using compiler construction tools <taken from  the 4th lex file> */
%{
#include "y.tab.h"
extern int  yylval;
%}

ALPHA [A-Za-z]
DIGIT [0-9]
%%

{ALPHA}({ALPHA}|{DIGIT})* return ID;
{DIGIT}+ {yylval=atoi(yytext); return NUM;}
[ ] { return SPACE; }
[\n\t] yyterminate();
. return yytext[0];
%%
