%{
#include <stdio.h>
#include <string.h>
 
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
} 
  
int main()
{
        yyparse();
} 

%}

%token tMAIN 
%token tOB 
%token tCB 
%token tOP 
%token tCP 
%token tNL
%token tPLUS   
%token tMINUS  
%token tCROSS   
%token tDIV   
%token tEQU   
%token tCOMA  
%token tSC    
%token<intValue> tINTEGER 
%token<stringValue> tNAME
%token tCONST 
%token tINT   
%token tPRINT 
%right tEQU
%left tPLUS tMINUS
%left tCROSS tDIV

%union 
{
    int intValue;
    char *stringValue;
}

%%
input   : tINT tMAIN tOP tCP tOB body tCB {printf("main \n"); }
        ;   

body    :   line tSC body
        |   line tSC
        ; 

line    :   declaration
        |   affectation
        |   tPRINT tOP tNAME tCP
        ;

declaration : tINT tNAME 
            | tCONST tINT tNAME
            ;

affectation : tNAME tEQU math 
            ; 

math    :   value tCROSS math {printf("multipass \n") ;}
        |   value tDIV math {printf("division \n") ;}
        |   value tPLUS math {printf("addition \n") ;}
        |   value tMINUS math {printf("soustraction \n") ;}
        |   tMINUS value {printf("moins\n") ;} %prec tCROSS
        |   value                   
        ;

value   : tINTEGER {printf("int %d \n",yylval.intValue) ;}
        | tNAME {printf("variable %s \n", yylval.stringValue) ;}
        ;
