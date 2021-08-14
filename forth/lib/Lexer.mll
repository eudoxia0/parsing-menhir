{
open Lexing
open Parser

let advance_line lexbuf =
  let pos = lexbuf.lex_curr_p in
  let pos' = { pos with
    pos_bol = lexbuf.lex_curr_pos;
    pos_lnum = pos.pos_lnum + 1
  } in
  lexbuf.lex_curr_p <- pos'
}

let digit = ['0'-'9']
let sign = ['-' '+']
let exponent = ['e' 'E']

let int_constant = sign? digit+

let float_constant = sign? digit+ '.' digit+ (exponent sign? digit+)?

let whitespace = [' ' '\t']+

(* Rules *)

rule token = parse
  | int_constant { INT_CONSTANT (int_of_string (Lexing.lexeme lexbuf)) }
  | float_constant { FLOAT_CONSTANT (float_of_string (Lexing.lexeme lexbuf)) }
  (* etc. *)
  | whitespace { token lexbuf }
  | eof { EOF }
  | _ { raise (Failure ("Character not allowed in source text: '" ^ Lexing.lexeme lexbuf ^ "'")) }
