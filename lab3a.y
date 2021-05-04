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
S : ST {printf("\n Number of for loops %d\n",count); exit(0);}
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

int main() {
	printf("Enter the expression: \n");
	yyparse();
}

/* For printing error messages */
int yyerror(char* s) {
	printf("\nExpression is invalid\n");
}
