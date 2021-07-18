%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
%}

%start S

%%
S: X Z;
X: 'a'X'b'|;
Z: 'b'Z'c'|;
%%
int main(){
    printf("Enter string: ");
    yyparse();
    printf("\nValid string\n");
}
int yyerror(){
    printf("Invalid.\n");
    exit(0);
}