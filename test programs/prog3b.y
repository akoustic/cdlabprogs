%{
#include <stdio.h>
#include <stdlib.h>
int count=0;
%}

%token ID NUM FOR LE GE EQ NE
%right '='
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%left '!'

%%
S : ST {printf("Number of for loops %d\n",count); exit(0);}
ST : FOR'(' E ';' COMPARE ';' E ')' BOD {count++;} ;

BOD : '{' BODY '}'
        | E';'
        | ST
        | ;
BODY : BODY BODY
           | E ';'       
           | ST
           | ;
       
E : ID '=' E
    | E '+' E
    | E '-' E
    | E '*' E
    | E '/' E
    | E '+' '+'
    | E '-' '-'
    | ID 
    | NUM
    ;
   
COMPARE : E '<' E
   | E '>' E
   | E LE E
   | E GE E
   | E EQ E
   | E NE E
   ;   
%%
#include <stdio.h>
// stuff from lex that yacc needs to know about:
extern int yylex();
extern int yyparse();
extern FILE *yyin;

int main() {
	// open a file handle to a particular file:
	FILE *myfile = fopen("forloopfile.c", "r");
	// make sure it is valid:
	if (!myfile) {
		printf("\nCannot open file\n");
        exit(-1);
	}
	// set lex to read from it instead of defaulting to STDIN:
	yyin = myfile;
	
	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));
}

/* For printing error messages */
int yyerror(char* s) {
	printf("\nExpression is invalid\n");
}
