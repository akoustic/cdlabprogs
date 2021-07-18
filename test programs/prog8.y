%{
#include <stdio.h>
#include <stdlib.h>
%}

%token ID NUM
%right '='
%left '+' '-'
%left '*' '/'
%left UMINUS
%%

S : E
;
E : E '+'{push();} T{codegen();}
   | E '-'{push();} T{codegen();}
   | T
   ;
T : T '*'{push();} F{codegen();}
   | T '/'{push();} F{codegen();}
   | F
   ;
F : '(' E ')'
   | '-'{push();} F{codegen_umin();} %prec UMINUS
   | NUM{push();}
   ;
%%

#include <stdio.h>
#include <string.h>
// stuff from lex that yacc needs to know about:
extern int yylex();
extern int yyparse();
extern char* yytext;
// #include "lex.yy.c"
#include<ctype.h>
char st[100][10];
int top=0;
char i_[2]="0";
char temp[2]="t";

int main()
 {
 printf("Enter the expression : ");
 yyparse();
 }

push()
{
  strcpy(st[++top],yytext);
 }

codegen()
 {
 strcpy(temp,"t");
 strcat(temp,i_);
  printf("%s %s %s   %s\n",st[top-1],st[top-2],st[top],temp);
  top-=2;
 strcpy(st[top],temp);
 i_[0]++;
 }

codegen_umin()
 {
 strcpy(temp,"t");
 strcat(temp,i_);
 printf("- %s     %s\n",st[top],temp);
 top--;
 strcpy(st[top],temp);
 i_[0]++;
 }

 int yyerror(char* s) {
	printf("\nExpression is invalid\n");
}