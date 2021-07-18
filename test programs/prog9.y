%{
#include <stdio.h>
#include <stdlib.h>
%}
%token ID NUM FOR LE GE EQ NE OR AND
%right '='
%left OR AND
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'

%%

S       : FOR '(' E ';'{lab1();} COMPARE {lab2();}';' E {lab3();}')' E';'{lab4(); exit(0);}
         ;
E       : V '='{push();} E{codegen_assign();}
         | E '+'{push();} E{codegen();}
         | E '-'{push();} E{codegen();}
         | E '*'{push();} E{codegen();}
         | E '/'{push();} E{codegen();}
         | '(' E ')'
         | '-'{push();} E{codegen_umin();} %prec UMINUS
         | V
         | NUM{push();}
         ;
V       : ID {push();}
         ;

COMPARE : E '<' E
   | E '>' E
   | E LE E
   | E GE E
   | E EQ E
   | E NE E
   ;

%%

#include<ctype.h>
// stuff from lex that yacc needs to know about:
extern int yylex();
extern int yyparse();
extern char* yytext;
char st[100][10];
int label[20];
int top=0;
char i_[2]="0";
char temp[2]="t";

int lno=0,ltop=0;
int start=1;

main()
{
    printf("Enter the expression: ");
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
    printf("%s = %s %s %s\n",temp,st[top-2],st[top-1],st[top]);
    top-=2;
    strcpy(st[top],temp);
    i_[0]++;
}

codegen_umin()
{
    strcpy(temp,"t");
    strcat(temp,i_);
    printf("%s = -%s\n",temp,st[top]);
    top--;
    strcpy(st[top],temp);
    i_[0]++;
}

codegen_assign()
{
    printf("%s = %s\n",st[top-2],st[top]);
    top-=2;
}
lab1()
{
    printf("L%d: \n",lno++);
}
lab2()
{
    strcpy(temp,"t");
    strcat(temp,i_);
    printf("%s = not %s\n",temp,st[top]);
    printf("if %s goto L%d\n",temp,lno);
    i_[0]++;
    label[++ltop]=lno;
    lno++;
    printf("goto L%d\n",lno);
    label[++ltop]=lno;
    printf("L%d: \n",++lno);
 }
lab3()
{
    int x;
    x=label[ltop--];
    printf("goto L%d \n",start);
    printf("L%d: \n",x);
   
}

lab4()
{
    int x;
    x=label[ltop--];
    printf("goto L%d \n",lno);   
    printf("L%d: \n",x);
}

int yyerror(char* s) {
	printf("\nExpression is invalid\n");
}