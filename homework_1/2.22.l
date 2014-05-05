%{
#include <stdio.h>
#include <ctype.h>
extern char *yytext;
extern FILE *yyin;
int sem_count = 0;

%}


%%

[\/\*.*\*\/] {printf("%s",toupper(yytext) );}
[\\\\[^\d\n]*] {printf("%s", toupper(yytext));}

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

