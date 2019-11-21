open Graph

(* A path is a list of nodes. *)
type path = id list

val add_arc_flow: (int*int*int) graph -> id -> id -> int -> (int*int*int) graph

val neighbours: (int*int) graph -> id -> (id*int) list 

val flow_var: (int*int) graph ->  path -> int (*pour un graphe et un chemain danse ce graph retourne la variation de flot sur ce chemain*) 

val variation_graph: (int*int*int) graph -> (int*int) graph (*retourne le graphe d'ecart d'un graph donné*)

val apply_flow_var: (int*int*int) graph -> path -> int -> (int*int*int) graph (*applique une reduction ou augmetation de flot sur un chemain donné pour un graph donné*)

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
 *)
val find_path: (int*int) graph -> id list -> id -> id -> (path*int) option


(*ford_fulkerson g source puit
	retourne le graphe g avec le flot max à cout min possible sur ce graphe, 
	et le débit et coût total associé
	pour un sommet source et puit donné
	arc : (int*int) = (flot*capacité*coût)
	*)
 val ford_fulkerson_min_cost: (int*int*int) graph -> id -> id -> (((int*int*int) graph)*int*int)