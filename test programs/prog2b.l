/* program to validate and evaluate simple infix expression involving operators +,*,-,/ */
/* to run - lex prog.l; yacc -d prog.y; cc lex.yy.c y.tab.c; ./a.out */
/* input - 2*3+8/2 */
%{
#include <stdio.h>
#include "y.tab.h"
#include <stdlib.h>
%}


%%
\+ return '+';
\- return '-';
\* return '*';
\/ return '/';
\( return '(';
\) return ')';
[0-9]+ {yylval = atoi(yytext); return NUM;}
. {return yytext[0];}
"\n" {return 0;}
%%
