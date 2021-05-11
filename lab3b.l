/* program that identifies Function Definition of C language */
%{
    #include "y.tab.h"
    extern yylval;
%}

alpha [A-Za-z]
digit [0-9]

%%
for {return FOR;}
while {return WHILE;}
if {return IF;}
[\t \n] ;
int|float|void|char {return TYPE;}
return {return RETURN;}
{digit}+ {return NUM;}
{alpha}({alpha}|{digit})* {return ID;}
"<=" {return LE;}
">=" {return GE;}
"==" {return EQ;}
"!=" {return NE;}
. {return yytext[0];}
%%