type atom =
  | Int of int
  | Float of float
  | Word of string

type program = Program of atom list

let dump_atom = function
  | Int i ->
     "Int " ^ string_of_int i
  | Float f ->
     "Float " ^ string_of_float f
  | Word s ->
     "Word \"" ^ s ^ "\""

let dump_program (Program atoms) =
  "[" ^ (String.concat ", " (List.map dump_atom atoms)) ^ "]"
