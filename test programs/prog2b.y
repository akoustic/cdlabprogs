%{
#include <stdio.h>
#include <stdlib.h>
extern int yylval;
int yylex();
int yyerror();
%}

%token ID NUM
%left '+' '-'
%left '*' '/'

%start S

%%
S : E {printf ("\nResult: %d", $1);} ;
E : E '+' E {$$ = $1 + $3;}
  | '(' E ')' {$$ = $2;}
  | E '*' E {$$ = $1 * $3;}
  | E '/' E {$$ = $1 / $3;}
  | E '-' E {$$ = $1 - $3;}
  | '-' NUM {$$ = -$2;}
  | NUM {$$ = $1;} ;
%%

int yyerror () {
    printf ("\nInvalid string");
    exit(0);
}

int main ()
{
    printf ("Enter the string : ");
    yyparse();
    printf ("\nAccepted!");
}

