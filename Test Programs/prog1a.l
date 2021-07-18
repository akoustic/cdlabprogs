/* code to recognize spaces, letters, words in a sentence WARNING: does not work on trailing spaces */ 
/* to run - lex prog.l; lex.yy.c -ll; ./a.out */
%{
#include<stdio.h>
int words = 0;
int letters = 0;
int spaces = 0;
int tabcount=0;
int linecount=0;
%}
%%
[' ']+ {spaces++;}
\n {linecount++;}
[a-zA-Z0-9]+ {words++;letters+=yyleng;}
%%
int main(int argc, char* argv[])
{
	printf("Enter the string : ");
	int ret = yylex();
	printf("\nLex returned %d\n",ret);
	printf("Number of letters : %d.\n", letters);
	printf("Number of spaces : %d.\n", spaces);
	printf("Number of words : %d.\n", words);
	printf("Number of lines : %d.\n", linecount);
}
