/* c program which is a lr0parser. grammar is given and parser is coded as per the grammar
input string is provided as input and parsing table is generated according to that */

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
  
int z = 0, stackptr = 0, stringptr = 0, stringlen = 0;
  
char string[16], ac[20], stack[15], act[10]; 
  

void check()
{
    int flag=0;
    for(;;){

        strcpy(ac,"REDUCE TO S -> ");  
            
        for(z = 0; z < stringlen; z++)
        {
            if(stack[z] == 'a' && stack[z + 1] == 'S' && stack[z + 2] == 'b' && stack[z + 3] == 'b') 
            {
                printf("\t%saSbb", ac);
                stack[z] = 'S';
                stack[z + 1] = '\0';
                stack[z + 2] = '\0';
                stack[z + 3] = '\0';
                printf("\n$%s\t%s$\t", stack, string);
                stackptr = stackptr - 3;
                flag=1;
            }
            
        }
            
        for(z = 0; z < stringlen; z++)
        {
            if(stack[z] == 'a' && stack[z + 1] == 'b' && stack[z + 2] == 'b') 
            {
                printf("\t%sabb", ac);
                stack[z] = 'S';
                stack[z + 1] = '\0';
                stack[z + 2] = '\0';
                printf("\n$%s\t%s$\t", stack, string);
                stackptr = stackptr - 2;
                flag=1;
            }
            
        }
        if(flag==0){
            break;
        }
        else{
            flag=0;
        }
    }
    return ;
}
  
int main()
{
    //printf("GRAMMAR is -\nE->2E2 \nE->3E3 \nE->4\n");
    //printf("GRAMMAR is -\nE->E+E \nE->E/E \nE->E*E \nE->a|b\n");
    printf("GRAMMAR is -\nS->aSbb|abb");    
      
    strcpy(string,"aabbbb"); 
    stringlen=strlen(string); 
    strcpy(act,"SHIFT"); 
    printf("\nStack \t Input \t\tAction"); 
    printf("\n$ \t %s$ ", string); 
      

    for(stackptr = 0; stringptr < stringlen; stackptr++, stringptr++) 
    {
        printf("\t%s", act); 
        stack[stackptr] = string[stringptr];     
        stack[stackptr + 1] = '\0';
        string[stringptr]=' ';
        printf("\n$%s \t %s$ ", stack, string); 
        check(); 
    }
    check(); 
    if(stack[0] == 'S' && stack[1] == '\0') 
        printf("\nAccepted\n");
    else
        printf("\nReject\n");
}