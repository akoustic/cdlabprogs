/* program to obtain valid infix expression */
%{
    #include<stdio.h>
    #include"y.tab.h"
    int opcount =0;
    int idcount =0;
    int numcount =0;
    int keywcount=0;
%}

int "int"
float "float"
for "for"
if "if"
else "else"
break "break"
continue "continue"
while "while"
char "char"
return "return"

%%
({int}|{float}|{for}|{if}|{else}|{break}|{while}|{char}|{break}|{continue}|{return}) {keywcount++;printf("\nKeyword = %s ",yytext);}
(\+|\-|\/|\*) {opcount++;printf("\nOperator = %s ",yytext);}
[a-zA-Z][a-zA-Z0-9]* {idcount++;printf("\nIdentifier = %s ",yytext);}
[0-9]+ {numcount++;printf("\nNumber = %s ",yytext);}
\n {return 0;}
%%

int main(int argc, char* argv[])
{
	printf("Enter the string : ");
	int ret = yylex();
	printf("\nLex returned %d\n",ret);
	printf("Number of operators : %d.\n", opcount);
	printf("Number of identifiers : %d.\n", idcount);
	printf("Number of keywords : %d.\n", keywcount);
	printf("Number of numbers : %d.\n", numcount);
}