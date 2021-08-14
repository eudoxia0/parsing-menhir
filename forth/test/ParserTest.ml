open OUnit2
open Menhir_tutorial_core.Ast
open Menhir_tutorial_core.ParserInterface

let peq (s: string) (v: 'a) =
  assert_equal v (parse_program s)

let test_parse_int_constants _ =
  peq "0" (Program [IntConstant 0]);
  peq "123" (Program [IntConstant 123]);
  peq "+123" (Program [IntConstant 123]);
  peq "1000" (Program [IntConstant 1000]);
  peq "-0" (Program [IntConstant 0]);
  peq "-123" (Program [IntConstant (-123)])

let suite =
  "Parser tests" >::: [
      "Integer constants" >:: test_parse_int_constants
    ]

let _ = run_test_tt_main suite
