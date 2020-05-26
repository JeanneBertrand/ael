/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tMAIN = 258,
    tOB = 259,
    tCB = 260,
    tCP = 261,
    tNL = 262,
    tPLUS = 263,
    tMINUS = 264,
    tCROSS = 265,
    tDIV = 266,
    tEQU = 267,
    tCOMA = 268,
    tSC = 269,
    tINTEGER = 270,
    tIF = 271,
    tELSE = 272,
    tWHILE = 273,
    tOP = 274,
    tNAME = 275,
    tCONST = 276,
    tINT = 277,
    tPRINT = 278
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tOB 259
#define tCB 260
#define tCP 261
#define tNL 262
#define tPLUS 263
#define tMINUS 264
#define tCROSS 265
#define tDIV 266
#define tEQU 267
#define tCOMA 268
#define tSC 269
#define tINTEGER 270
#define tIF 271
#define tELSE 272
#define tWHILE 273
#define tOP 274
#define tNAME 275
#define tCONST 276
#define tINT 277
#define tPRINT 278

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 50 "gram.y" /* yacc.c:1909  */

    int intValue;
    char *stringValue;

#line 105 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
