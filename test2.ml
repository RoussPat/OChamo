open Gfile
open Tools
open Flow

(*let g1 = (Gfile.from_file "graph1");;
Printf.printf ("L1\n%!");;
let g2 = gmap g1 (fun x -> int_of_string x);;
Printf.printf ("L2\n%!");;
let g3 = gmap g2 (fun x -> (0,x));;
Printf.printf ("L3\n%!");;
let g4 = variation_graph g3 ;;
Printf.printf ("L4\n%!");;
let Some(p) = find_path g4 [1] 0 5 ;;

let f id = Printf.printf ("%d ") id;;
List.iter f p ;;
Printf.printf "\n%!" ;;

let gfinal2 = gmap g4 (fun x -> (string_of_int x)) ;;
Gfile.export "graphequarts.dot" gfinal2;;

let a =
 match (find_path g4 [1] 0 5) with 
 |Some(x) -> flow_var g4 x 
 |None -> 0 ;;
Printf.printf ("%d\n%!") a;;
let a = flow_var g4 [0;3;1;4;5];;
Printf.printf ("%d\n%!") a;;

let gfinal1 = gmap g3 (fun (a,b) -> ("\"" ^ (string_of_int a)  ^ "/" ^ (string_of_int b) ^ "\""));;

Gfile.export "graphflots.dot" gfinal1;;*)

let g = initialise_flow_graph ((Sys.argv).(1)) ;;
let var_graph = variation_graph g ;;
Gfile.export "var_graph.dot" (gmap var_graph (fun x -> string_of_int x));;
let (result,d) = (ford_fulkerson g (int_of_string((Sys.argv).(2))) (int_of_string((Sys.argv).(3))));;
let str_result = int_int_graph_to_string_graph result ;;
Gfile.export "result.dot" str_result ;;
Printf.printf ("flow max = %d\n%!") d;;
Sys.command ("dot -Tsvg result.dot > ./TestToExport/"^((Sys.argv).(1))^"_result.svg");;
Sys.command ("dot -Tsvg var_graph.dot > ./TestToExport/"^((Sys.argv).(1))^"_var.svg");;
