%{
open Ast
%}

%token <string> INT_CONSTANT
%token EOF

/* Types */

%type <Ast.ast> ast

%start ast

%%

ast:
  | INT_CONSTANT EOF { IntConstant $1 }
  ;
