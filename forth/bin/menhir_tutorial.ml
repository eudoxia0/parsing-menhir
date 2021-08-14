open Menhir_tutorial_core.Ast
open Menhir_tutorial_core.ParserInterface

let rec repl _ =
  print_string "> ";
  let input = read_line () in
  let program = parse_program input in
  let output = dump_program program in
  print_endline output;
  print_endline "";
  repl ()

let _ = repl ()
