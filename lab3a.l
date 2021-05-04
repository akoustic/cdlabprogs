/* program to recognize a nested (minimum 3 levels) FOR loop statement for C language */
%{
    #include "y.tab.h"
    extern yylval;
%}

alpha [A-Za-z]
digit [0-9]

%%
for {return FOR;}
{digit}+ {return NUM;}
{alpha}({alpha}|{digit})* {return ID;}
"<=" {return LE;}
">=" {return GE;}
"==" {return EQ;}
"!=" {return NE;}
. {return yytext[0];}
%%