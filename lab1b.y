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
    printf("\nEnter string: ");
    yyparse();
    printf("\n Valid string\n");
}
int yyerror(){
    printf("INVALID!!!\n");
    exit(0);
}