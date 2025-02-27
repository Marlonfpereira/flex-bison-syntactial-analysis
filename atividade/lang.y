%{
#include <math.h>
#include <stdio.h>
#define YYSTYPE double
int yyerror (char const *s);
extern int yylex (void);
extern int lineno;
%}

%token T_while
%token T_if
%token T_Tipo
%token T_NUM
%token T_ID
%token T_OpRel
%token T_OpExp
%token T_OpTer
%token T_Not
%token T_EPar
%token T_DPar
%token T_EChv
%token T_DChv
%token T_PntVirg
%token T_Igual

%define parse.error verbose
%start Programa

%%

Programa: DeclLista
DeclLista: Decl DeclLista 
| Cmd CmdLista 
| ;

Decl: T_Tipo T_ID T_PntVirg
| T_Tipo T_ID T_Igual Expressao T_PntVirg
;

CmdLista: Cmd CmdLista
| ;

Cmd: T_ID T_Igual Expressao T_PntVirg
| T_if T_EPar ExpressaoRel T_DPar T_EChv CmdLista T_DChv
| T_while T_EPar ExpressaoRel T_DPar T_EChv CmdLista T_DChv
;

Expressao: Expressao T_OpExp Termo
| Termo
;

Termo: Termo T_OpTer Fator
| Fator
;

Fator: T_EPar Expressao T_DPar
| T_NUM
| T_ID
| T_Not Fator
;

ExpressaoRel: Expressao T_OpRel Expressao

%%

int yyerror(char const *s) {
  printf("%s at line %d\n", s, lineno); return 1;
}

int main() {
    int ret = yyparse();
    if (ret){
	fprintf(stderr, "%d error found.\n",ret);
    } else {
        fprintf(stderr, "Finished succesfully!\n");
    }
    return 0;
}
