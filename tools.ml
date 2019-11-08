

let clone_nodes gr = (*'a graph -> 'b graph*)
	Graph.n_fold gr Graph.new_node Graph.empty_graph 

let gmap gr f =(*'a graph -> ('a -> 'b) -> 'b graph*)
	Graph.e_fold gr (fun gr id1 id2 a -> Graph.new_arc gr id1 id2 (f a)) Graph.empty_graph

let add_arc g id1 id2 n = (*int graph -> id -> id -> int -> int graph*)
	match (Graph.find_arc g id1 id2) with
		|None -> Graph.new_arc g id1 id2 n
		|Some(x) -> Graph.new_arc g id1 id2 (x+n)
