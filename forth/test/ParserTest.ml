open OUnit2
open Menhir_tutorial_core.Ast
open Menhir_tutorial_core.ParserInterface

let peq (s: string) (v: 'a) =
  assert_equal v (parse_program s)

let test_parse_int_constants _ =
  peq "0" (Program [Int 0]);
  peq "123" (Program [Int 123]);
  peq "+123" (Program [Int 123]);
  peq "1000" (Program [Int 1000]);
  peq "-0" (Program [Int 0]);
  peq "-123" (Program [Int (-123)])

let test_parse_float_constants _ =
  peq "0.0" (Program [Float 0.0]);
  peq "123.0" (Program [Float 123.0]);
  peq "+123.0" (Program [Float 123.0]);
  peq "1000.0" (Program [Float 1000.0]);
  peq "-123.0" (Program [Float (-123.0)]);
  peq "123.0e6" (Program [Float 123.0e6]);
  peq "123.0e-6" (Program [Float 123.0e-6]);
  peq "-123.0e6" (Program [Float (-123.0e6)]);
  peq "-123.0e-6" (Program [Float (-123.0e-6)])

let test_parse_words _ =
  peq "TEST" (Program [Word "TEST"]);
  peq "TEST-PROGRAM" (Program [Word "TEST-PROGRAM"]);
  peq "TEST-123" (Program [Word "TEST-123"])

let test_parse_programs _ =
  peq "TEST 3.14   123 -3.4" (Program [Word "TEST"; Float 3.14; Int 123; Float (-3.4)]);
  peq "A 1 B" (Program [Word "A"; Int 1; Word "B"])

let suite =
  "Parser tests" >::: [
      "Integer constants" >:: test_parse_int_constants;
      "Float constants" >:: test_parse_float_constants;
      "Words" >:: test_parse_words;
      "Programs" >:: test_parse_programs
    ]

let _ = run_test_tt_main suite
