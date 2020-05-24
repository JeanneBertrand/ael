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
    tOP = 261,
    tCP = 262,
    tNL = 263,
    tPLUS = 264,
    tMINUS = 265,
    tCROSS = 266,
    tDIV = 267,
    tEQU = 268,
    tCOMA = 269,
    tSC = 270,
    tINTEGER = 271,
    tIF = 272,
    tELSE = 273,
    tNAME = 274,
    tCONST = 275,
    tINT = 276,
    tPRINT = 277
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tOB 259
#define tCB 260
#define tOP 261
#define tCP 262
#define tNL 263
#define tPLUS 264
#define tMINUS 265
#define tCROSS 266
#define tDIV 267
#define tEQU 268
#define tCOMA 269
#define tSC 270
#define tINTEGER 271
#define tIF 272
#define tELSE 273
#define tNAME 274
#define tCONST 275
#define tINT 276
#define tPRINT 277

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 51 "gram.y" /* yacc.c:1909  */

    int intValue;
    char *stringValue;

#line 103 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
