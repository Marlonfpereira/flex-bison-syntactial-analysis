%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	int lineno = 1;
	void ret_print(char *token_type);
	void yyerror();
%}

NUM       		[0-9]+(\.[0-9]+)?
ID				[a-zA-Z_][a-zA-Z0-9_]*
TIPO			"int"|"float"
OpRel			"<"|"<="|">"|">="|"=="|"!="

OpExp			"+"|"-"
OpTer			"*"|"/"

%%

"while"		{ret_print("T_while");}
"if"		{ret_print("T_if");}
{TIPO}		{ret_print("T_Tipo");}

{NUM}		{ret_print("T_NUM");}
{ID}		{ret_print("T_ID");}
{OpRel}		{ret_print("T_OpRel");}
{OpExp}		{ret_print("T_OpExp");}
{OpTer}		{ret_print("T_OpTer");}

"!"			{ret_print("T_Not");}
"("			{ret_print("T_EPar");}
")"			{ret_print("T_DPar");}
"{"			{ret_print("T_EChv");}
"}"			{ret_print("T_DChv");}
";"			{ret_print("T_PVirg");}
"="			{ret_print("T_Igual");}

[ \t\r\f]+  /* eat up whitespace */
"\n"		{lineno++;}

.           { yyerror("Unrecognized character"); }
%%

void ret_print(char *token_type){
    printf("yytext: %s\ttoken: %s\tline: %d\n", yytext, token_type, lineno);
}
 
void yyerror(char *message){
    printf("Error: \"%s\" in line %d. Token = %s\n", message, lineno, yytext);
    exit(1);
}
 
int main(int argc, char *argv[]){
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
    return 0;
}
