%{
open Ast
%}

%token <int> INT_CONSTANT
%token <float> FLOAT_CONSTANT
%token EOF

/* Types */

%type <Ast.program> program

%start program

%%

program:
  | atom* EOF { Program $1 }
  ;

atom:
  | INT_CONSTANT { IntConstant $1 }
  | FLOAT_CONSTANT { FloatConstant $1 }
  ;
