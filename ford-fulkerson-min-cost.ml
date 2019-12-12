open Gfile
open Tools
open Fcost

(*./ford-fulkerson graphe source puit *)
let g = initialise_flow_graph_min_cost ((Sys.argv).(1)) ;;
let var_graph = variation_graph g ;;
Gfile.export "var_graph.dot" (gmap var_graph (fun (x,c) -> string_of_int x));;
let (result,d,c) = (ford_fulkerson_min_cost g (int_of_string((Sys.argv).(2))) (int_of_string((Sys.argv).(3))));;
let str_result = int_int_int_graph_to_string_graph result ;;
Gfile.export (((Sys.argv).(1))^"_flow_cost_result.dot") str_result ;;
Printf.printf ("flow max = %d\n%!") d;;
Printf.printf ("Min cost = %d\n%!") c;;
