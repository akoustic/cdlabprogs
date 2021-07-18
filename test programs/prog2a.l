/* code to recognize zero, negative, positive integers and fractions in a sentence */
/* to run - lex prog.l; cc lex.yy.c -ll; ./a.out */
%{
#include<stdio.h>
int posint = 0;
int negint = 0;
int posfrac = 0;
int negfrac = 0;
int zero=0;
%}
%%
\+?[1-9]+ {posint++;}
-[1-9]+ {negint++;}
\+?[1-9]+\/\+?[1-9]+ {posfrac++;}
-[1-9]+\/-[1-9]+ {posfrac++;}
-[1-9]+\/[1-9]+ {negfrac++;}
\+?[1-9]+\/\-[1-9]+ {negfrac++;}
[\+|-]?0(\/?[\+|-]?[1-9]+)? {zero++;}
"\n" {return 0;}
%%
int main(){
	printf("Enter the number  : ");
	yylex();
	printf("\nIt is zero : %d.\n",zero);
	printf("Negative integers is : %d.\n", negint);
	printf("Positive integers is : %d.\n", posint);
	printf("Positive fractions is : %d.\n", posfrac);
	printf("Negative fractions is : %d.\n",negfrac);
}
