%{
#include <stdio.h>  
#include <ctype.h>
extern char *yytext;
extern FILE *yyin;
int sem_count = 0;

%}


%%

[\/\*.*\*\/] {printf("%s",toupper(yytext) )}
[\\\\[^\d\n]*] {printf("%d", toupper(yytext))}

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
