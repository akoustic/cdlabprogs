/* program to translate the for loop expressions to a quadruple intermediate form (e.g. three-address code) */
/* to run - like any other yacc prog; */
/* input for(i=0;i==b;i=i+1) a=a+b; */
%{
    #include "y.tab.h"
    extern yylval;
%}
alpha [A-Za-z]
digit [0-9]

%%

[\t \n]
for             return FOR;
{digit}+    return NUM;
{alpha}({alpha}|{digit})* return ID;
"<="         return LE;
">="         return GE;
"=="         return EQ;
"!="          return NE;
"||"            return OR;
"&&"         return AND;
.                return yytext[0];
%%

