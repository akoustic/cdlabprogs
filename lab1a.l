/* code to count vowels and consonants
%{

#include<stdio.h>
int consonants = 0;
int vowels = 0;

%}

/* Regular definitions */

vowel [a|e|i|o|u|A|E|I|O|U]
consonant [a-zA-Z]

/* Rules section start here*/

%%

{vowel} {vowels++;}
{consonant} {consonants++;}

%%

/* Auxillary functions start here */

int main(void)
{
    printf("Enter the string : ");
	int ret = yylex();
	printf("\nLex returned %d\n",ret);
    yylex();
    printf("Consonants : %d, Vowels : %d\n", consonants, vowels);
    return 1;
}


