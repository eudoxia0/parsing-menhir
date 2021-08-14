%{
open Ast
%}

%token <int> INT_CONSTANT
%token <float> FLOAT_CONSTANT
%token <string> WORD
%token EOF

/* Types */

%type <Ast.program> program

%start program

%%

program:
  | atom* EOF { Program $1 }
  ;

atom:
  | INT_CONSTANT { Int $1 }
  | FLOAT_CONSTANT { Float $1 }
  | WORD { Word $1 }
  ;
