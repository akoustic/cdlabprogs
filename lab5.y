%{
#include "stdio.h"
#include "stdlib.h"
%}

%token ID NUM SPACE
%right '='
%left '+' '-'
%left '*' '/'
%left UMINUS
%%

S : ID{push();} SPACE '='{push();} SPACE E{codegen_assign();}
   ;
E : E  '+'{push();}  T{codegen();}
   | E  '-'{push();}  T{codegen();}
   | T
   ;
T : T  '*'{push();}  F{codegen();}
   | T  '/'{push();} F{codegen();}
   | F
   ;
F : '(' E ')'
   | '-'{push();} F{codegen_umin();} %prec UMINUS
   | ID{push();}
   | NUM{push();}
   ;
%%

/*
for compiling c lex.yy.c y.tab.c -ll -lncurses -o assemblytc
add the -lncurses
*/

// #include "lex.yy.c"
#include<ctype.h>
#include<stdio.h>
#include<string.h>
#include<curses.h>

// stuff from lex that yacc needs to know about:
extern int yylex();
extern int yyparse();
extern char* yytext;

char st[100][10];
int top=0;
char i_[2]="0";
char temp[1]="a";
int tempchar = 97;
char icode[10][30], str[20],  opr[10];
int ptr = 0;

main(){
 	printf("Enter the expression : ");
 	yyparse();
	int i = 0;
	strcpy(icode[ptr++], "exit");
	printf("\n Target code generation");
	
	i = 0;
	do
	{
		strcpy(str, icode[i]);
		switch(str[3])
		{
			case '+' :  strcpy(opr, "ADD");  break;
			case  '-' : strcpy(opr, "SUB"); break;
			case  '*' : strcpy(opr, "MUL"); break;
			case  '/' : strcpy(opr,  "DIV"); break;
		}
		printf("\n\tMOV %c,R%d", str[2], i);
		if(str[4] >='a' && str[4] <='z')printf("\n\t%s %c,R%d", opr, str[4], i);
		printf("\n\tMOV R%d,%c", i,str[0]);
 	}while(strcmp(icode[++i], "exit") !=  0);
	getch();

	printf("\n");

 }

push()
{
  strcpy(st[++top],yytext);
 }

codegen()
 {
 strcpy(temp, "t");
 //strcat(temp,i_);
temp[0] = (char)tempchar;
  printf("%s = %s %s %s\n",temp,st[top-2],st[top-1],st[top]);

	sprintf(icode[ptr++],  "%s=%s%s%s\n",temp,st[top-2],st[top-1],st[top]);
  top-=2;
 strcpy(st[top],temp);
tempchar++;
 i_[0]++;
 }

codegen_umin()
 {
 strcpy(temp,"t");
 // strcat(temp,i_);
temp[0] = (char)tempchar;
 printf("%s = -%s\n",temp,st[top]);
sprintf(icode[ptr++],  "%s=-%s\n",temp,st[top]);
 top--;
 strcpy(st[top],temp);
tempchar++;
 i_[0]++;
 }

codegen_assign()
 {
 printf("%s = %s\n",st[top-2],st[top]);
sprintf(icode[ptr++], "%s=%s\n",st[top-2],st[top] );
 top-=2;
 }

 int yyerror(char* s) {
	printf("\nExpression is invalid\n");
}
