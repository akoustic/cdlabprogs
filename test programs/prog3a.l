/* program to count single and multiline comments and remove them */
/* to run - same as any lex prog; create input.c and output.c*/
%{
#include<stdio.h>
int singcomments=0,multicomments=0,flag=0;
%}

%%
\/\/.* {if(flag==0)singcomments++;}
\/\* {if(flag==0)flag=1;}
\*\/ {if(flag==1){multicomments++;flag=0;}}
. {if(flag==1);else{fprintf(yyout,"%s",yytext);}}
%%

int main(void){
    yyin=fopen("comment_input.c","r+");
    yyout=fopen("comment_output.c","w");
    yylex();
    printf("\nThe no. of single comments %d and multiline comments are %d\n",singcomments,multicomments);
}