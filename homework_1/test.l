%{            //全局声明部分
/*林木100 linux
www.linmu100.com
*/
#include <stdio.h>  

extern char *yytext;
extern FILE *yyin;
int sem_count = 0;

%}


%%
[a-zA-Z][a-zA-Z0-9]*    {printf("WORD[%s] ", yytext);}
[a-zA-Z0-9\/.-]+        printf("FILENAME ");
\"                      printf("QUOTE ");
\{                      printf("OBRACE ");
\}                      printf("EBRACE ");
;                       {sem_count++; printf("SEMICOLON ");}
\n                      printf("\n");
[ \t]+                  /* ignore whitespace */;
%%


int main(int avgs, char *avgr[]) 
{
    yyin = fopen(avgr[1], "r");
    if (!yyin)
    {
        return 0;
    }
    yylex();
    printf("sem_count : %d\n", sem_count);
    fclose(yyin);

    return 1;
}
