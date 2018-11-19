module FP = Z3.FloatingPoint

let mk_float sym ctx =
  let open Z3 in
  Expr.mk_const ctx (Symbol.mk_string ctx sym) (FP.mk_sort_64 ctx)

let check_problem () =
  let ctx = Z3.mk_context [("model", "true"); ("proof", "true"); ("unsat_core", "true")] in
  let round = FP.RoundingMode.mk_rne ctx in
  let x = mk_float "x" ctx in
  let y = mk_float "y" ctx in
  let x_p_y = FP.mk_add ctx round x y in
  let x_d_y = FP.mk_div ctx round x y in
  let x_s = FP.mk_sqrt ctx round x in
  let d_p_s = FP.mk_add ctx round x_s x_d_y in
  let prob = FP.mk_eq ctx x_p_y d_p_s in
  let solver = Z3.Solver.mk_solver ctx None in
  Z3.Solver.add solver [prob];
  match Z3.Solver.check solver [] with
  | _ -> print_endline "finished"
  | exception Z3.Error e ->
     print_endline ("caught Z3.Error: " ^ e)

let () =
  let mem = try Sys.argv.(1) with _ -> "400" in
  Z3.set_global_param "memory_max_size" mem;
  check_problem ();
  flush_all ()
