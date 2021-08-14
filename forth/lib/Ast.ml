type atom =
  | IntConstant of int
  | FloatConstant of float
  | Atom of string

type program = Program of atom list
