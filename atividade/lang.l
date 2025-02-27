%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	int lineno = 1;
	void ret_print(char *token_type);
    
    #define YYSTYPE double
    #include "lang.tab.h"
%}

NUM       		[0-9]+(\.[0-9]+)?
ID				[a-zA-Z_][a-zA-Z0-9_]*
TIPO			"int"|"float"
OpRel			"<"|"<="|">"|">="|"=="|"!="

OpExp			"+"|"-"
OpTer			"*"|"/"

%%

"while"		{return T_while;}
"if"		{return T_if;}
{TIPO}		{return T_Tipo;}

{NUM}		{return T_NUM;}
{ID}		{return T_ID;}
{OpRel}		{return T_OpRel;}
{OpExp}		{return T_OpExp;}
{OpTer}		{return T_OpTer;}

"!"			{return T_Not;}
"("			{return T_EPar;}
")"			{return T_DPar;}
"{"			{return T_EChv;}
"}"			{return T_DChv;}
";"			{return T_PntVirg;}
"="			{return T_Igual;}

[ \t\r\f]+  /* eat up whitespace */
"\n"		{lineno++;}

.           { printf("Fatal error: \"Unrecognized character\" in line %d. Token = %s\n", lineno, yytext); exit(1); }
%%

void ret_print(char *token_type){
    printf("yytext: %s\ttoken: %s\tline: %d\n", yytext, token_type, lineno);
}