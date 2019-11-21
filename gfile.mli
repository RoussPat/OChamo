(* Read a graph from a file,
 * Write a graph to a file. *)

open Graph

type path = string


val initialise_flow_graph: string -> (int*int) graph 

val initialise_flow_graph_min_cost: string -> (int*int*int) graph 

val int_int_graph_to_string_graph: (int*int) graph -> string graph

val int_int_int_graph_to_string_graph: (int*int*int) graph -> string graph


(* Values are read as strings. *)
val from_file: path -> string graph

(* Similarly, we write only a string graph.
 * If necessary, use gmap (to be written by you) to prepare the input graph. *)
val write_file: path -> string graph -> unit

val export : path -> string graph -> unit



(* The format of files is compatible with the files generated by:
   https://www-m9.ma.tum.de/graph-algorithms/flow-ford-fulkerson/index_en.html
*)
