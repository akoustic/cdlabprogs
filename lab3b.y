%{
#include <stdio.h>
#include <stdlib.h>
%}

%token ID NUM FOR WHILE IF LE GE EQ NE TYPE RETURN
%right '='
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%left '!'

%%
S : FUN {printf("Input accepted\n"); exit(0);}

FUN : TYPE ID '(' PARAMS ')' '{' BODY '}';

PARAMS : PARAMS ',' TYPE ID
    | TYPE ID
    | ;    

BODY : BODY BODY
    | PARAMS ';'
    | E ';'        
    | RETURN E ';'
    | FLOOP
    | WLOOP 
    | IFCONDITION
    | ; 
    
FLOOP : FOR'(' E ';' COMPARE ';' E ')'  '{' BODY '}'

WLOOP : WHILE '(' COMPARE ')' '{' BODY '}'

IFCONDITION : IF '(' COMPARE ')' '{' BODY '}'  
        
E : ID '=' E
    | ID '+' '=' E
    | E '+' E
    | E '-' E
    | E '*' E
    | E '/' E       
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
	FILE *myfile = fopen("functiondefinitionfile.c", "r");
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