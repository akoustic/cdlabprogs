%{
#include <stdio.h>
#include <stdlib.h>
%}

%token TYPE ID NUM RETURN
%right '='
%left '+' '-'
%left '*' '/'
%left '!'

%%
S : FUN {printf("Input accepted\n"); exit(0);}
FUN : TYPE ID '(' PARAMS ')' '{' BODY '}';
PARAMS : PARAMS ',' TYPE ID
    | TYPE ID
    |;         
BODY : BODY BODY
    | PARAMS ';'
    | E ';'        
    | RETURN E ';'
    |;              
E : ID '=' E
    | E '+' E
    | E '-' E
    | E '*' E
    | E '/' E       
    | ID
    | NUM   
    ;
%%

int main() {
	printf("Enter the function : \n");
	yyparse();
}

/* For printing error messages */
int yyerror(char* s) {
	printf("\nExpression is invalid\n");
}
