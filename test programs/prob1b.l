/* program to match a^nb^m+nc^m string */
/* to run - lex prog.l; yacc -d prog.y; cc lex.yy.c y.tab.c -ll; ./a.out */
%{
#include "y.tab.h"
%}
%%
"a" { return 'a';}
"b" { return 'b';}
"c" { return 'c';}
. return yytext[0];
\n return 0;
%%