(* bin/menhir_tutorial.ml *)
open Menhir_tutorial_core.Ast
open Menhir_tutorial_core.ParserInterface

let pop = function
  | [] -> raise (Failure "Stack is empty")
  | first::rest -> (first, rest)

let push v s = v :: s

let rec eval_program program stack =
  match program with
  | [] ->
     stack
  | head::rest ->
     let stack = (match head with
                  (* Constants are self-evaluating *)
                  | Int i -> push (Int i) stack
                  | Float i -> push (Float i) stack
                  | Word s ->
                     (match s with
                      | "ADD" -> oper (+.) stack
                      | "SUB" -> oper (-.) stack
                      | "MUL" -> oper ( *. )  stack
                      | "DIV" -> oper (/.) stack
                      | _ -> raise (Failure ("Unknown word: " ^ s))))
     in
     eval_program rest stack

and oper f stack =
  let (rhs, stack) = pop stack in
  let (lhs, stack) = pop stack in
  let lhs = as_float lhs
  and rhs = as_float rhs in
  let res = Float (f lhs rhs) in
  push res stack

and as_float = function
  | Int i -> float_of_int i
  | Float f -> f
  | Word _ -> raise (Failure "Not a number.")

let rec repl _ =
  print_string "> ";
  let input = read_line () in
  let (Program program) = parse_program input in
  try
    let result = eval_program program [] in
    let output = dump_program (Program result) in
    print_endline output;
    print_endline "";
    repl ()
  with (Failure msg) ->
    print_endline msg;
    repl()

let _ = repl ()
