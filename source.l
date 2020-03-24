/*définitions*/

DIGIT   [0-9]
EXP [eE][-+]?{DIGIT}+
NAME    ^[a-zA-Z][a-zA-Z0-9_]+
%{
#include "y.tab.h"
/*
#define tMAIN 42
#define tOB 10
#define tCB 11
#define tOP 12
#define tCP 13
#define tNL 14
#define tPLUS   20 
#define tMINUS  21 
#define tCROSS  22  
#define tDIV    23
#define tEQU    24
#define tCOMA   30
#define tSC     31
#define tINTEGER    40
#define tFLOAT  41
#define tNAME   43
#define tCONST  50
#define tINT    51
#define tPRINT  88
*/
%}

%%

main  {
            printf("Main\n"); 
            return tMAIN ;
        }

\{   {
        printf("Open bracket\n"); 
        return tOB ;
    }

\}   {
        printf("Closing bracket\n"); 
        return tCB ;
    }

\(   {
        printf("Open parenthesis\n"); 
        return tOP ;
    }

\)   {
        printf("Closing parenthesis\n"); 
        return tCP ;
    }

\+  { 
        printf("Plus\n"); 
        return tPLUS ;
    }

\-  {
        printf("Minus\n"); 
        return tMINUS ; 
    }

\*  {
        printf("Cross\n"); 
        return tCROSS ;
    }

\/   {
        printf("Divide\n"); 
        return tDIV ;
    }

=   {
        printf("Equal\n"); 
        return tEQU ; 
    }

[\b\t]+ {
            printf("\b");
        }
[\n]+ {
            printf("\n"); 
        }
,  {
        printf("Coma\n");
        return tCOMA ;
    }

;  {
        printf("Semicolon\n");
        return tSC ;
    }

{DIGIT}+     | 
{DIGIT}+{EXP}   {
                   printf("Integer %s\n", yytext); 
                   yylval.intValue = atoi(yytext);
                   return tINTEGER;
                }

const   {
            printf("const\n") ;
            return tCONST ; 
        } 

int    {
            printf("Integer\n");
            return tINT;
       }

printf  {
            printf("printf\n");
            return tPRINT;
        }

{NAME}  {
            printf("Name %s\n", yytext);
            yylval.stringValue = yytext ; 
            return tNAME ;
        }

    
%% 


















