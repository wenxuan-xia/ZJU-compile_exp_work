%{
#include<stdio.h>
#include<ctype.h>
int chars=0;   
int words=0;  
int lines=1;   
%}

final [\n]
letter [A-Za-z]
digit [0-9]
word ({letter}|{digit})+

%%
{final}             {lines++;}              
{letter}            {chars++;}  
{digit}             {chars++;}         
{word}              {words++;} 

%%
int main(int avgs, char *avgr[])
{
    yyin = fopen(avgr[1], "r");
    if (!yyin)
    {
        return 0;
    }
    yylex();
    fclose(yyin);

    return 1;
}

