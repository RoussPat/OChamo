open Gfile
open Tools
open Flow

let g = initialise_flow_graph ((Sys.argv).(1)) ;;
let var_graph = variation_graph g ;;
Gfile.export "var_graph.dot" (gmap var_graph (fun x -> string_of_int x));;
let (result,d) = (ford_fulkerson g (int_of_string((Sys.argv).(2))) (int_of_string((Sys.argv).(3))));;
let str_result = int_int_graph_to_string_graph result ;;
Gfile.export "result.dot" str_result ;;
Printf.printf ("flow max = %d\n%!") d;;
Sys.command ("dot -Tsvg result.dot > ./TestToExport/"^((Sys.argv).(1))^"_result.svg");;
Sys.command ("dot -Tsvg var_graph.dot > ./TestToExport/"^((Sys.argv).(1))^"_var.svg");;
