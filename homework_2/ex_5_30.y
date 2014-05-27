
%{
#include<stdio.h>
#include<ctype.h>
%}

%token NUMBER
%token POINT
%token INT
%token FLT

%%
command: int_exp    {printf("%d\n", $1);}
       | flt_exp    {printf("%f\n", $1);}
       ;

int_exp: int_exp '+' int_term {$$ = $1 + $3;}
       | int_exp '-' int_term {$$ = $1 - $3;}
       | int_term {$$ = $1;}
       ;

flt_exp: int_exp '+' flt_term {$$ = $1 + $3;}
       | flt_exp '+' int_term {$$ = $1 + $3;}
       | flt_exp '+' flt_term {$$ = $1 + $3;}
       | int_exp '-' flt_term {$$ = $1 - $3;}
       | flt_exp '-' int_term {$$ = $1 - $3;}
       | flt_exp '-' flt_term {$$ = $1 - $3;}
       | flt_term {$$ = $1;}

int_term: int_term '*' int_factor {$$ = $1 * $3;}
        | int_factor {$$ = $1;}
        ;

flt_term: flt_term '*' int_factor {$$ = $1 * $3;}
        | int_term '*' flt_factor {$$ = $1 * $3;}
        | flt_term '*' flt_factor {$$ = $1 * $3;}
        | flt_factor {$$ = $1;}
        ;
        
int_factor: INT {$$ = $1;}
          | '(' int_exp ')' {$$ = $2;}
          ;

flt_factor: FLT {$$ = $1;}
          | '(' flt_exp ')' {$$ = $2;}
          ;


%%

main() {
    return yyparse();
}

int yylex(void) {
    int c;
    int flt_flag;

    while((c = getchar()) == ' ');
    flt_flag = 0;
    if ( isdigit(c) ) {
        while ( ((c=getchar()) != ' ') && (c != '\n')) {
            if (c != '.') {
                flt_flag = 1;
            }
        }
        ungetc(c, stdin);
        while ( ((c=getchar()) != ' ') && (c != '\n')) {
            ungetc(c, stdin);
            ungetc(c, stdin);
        }
        c = getchar();
    }
    
    if (flt_flag) {
        return(INT);
    } else {
        return(FLT);
    }
}


int yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}
