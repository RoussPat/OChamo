open Graph
open Tools

type path = id list

(*renvoi true si l contient n*)
let contains l n = 
  let rec loop = function
    |x::rest -> if (n=x) then true else (loop rest)
    |_ -> false
  in loop l



let neighbours g id = (* a graph -> id -> id list  *)
  (* retourne une liste de touts les voisins d'un node id dans le graph g
    parcours tout les arcs de g avec G.iter *)
  let arcs = Graph.out_arcs g id in
  List.map (fun (x, y) -> x) arcs



let flow_var g idlist =(*(int*int) graph ->  id list -> int *)
  let inner acu l = match l with
    |[] -> failwith "not possible"
    |[x]-> acu
    |x::(y::rest) -> (match List.find(fun (a,_) -> a=y) (Graph.out_arcs g x) with
      |_,(a,b) -> if (b-a) < acu then inner (b-a) (y::rest) else inner acu (y::rest) ) 
  in
  inner int.infinity(*and beyond*) idlist ;;


let variation_graph gr = (*(int*int) graph -> int graph *) 
  let g2 = Graph.e_fold gr (fun g id1 id2 (a,b) -> Graph.new_arc g id1 id2 (b-a)) (clone_nodes gr) in
  Graph.e_fold g2 (fun g id1 id2 (a,b) -> Graph.new_arc g id2 id1 a) g2
;;


(* cherche un chemin entre id1 et id2, retourne Some(id list) si il existe, None sinon*)
let find_path g forbidden id1 id2  =
  
  let rec loop_next_node list_id current_node = 
    (*appel recursif sur les voisins du noeud courant*)
    let rec loop_on_neighbours n = match n with
      |[] -> None
      |x::rest -> if (contains list_id x || contains forbidden x)
                then loop_on_neighbours rest
                else match (loop_next_node (x::list_id) x) with
                  |None -> loop_on_neighbours rest
                  |x -> x
    in
 
      if (current_node = id2)
      then Some(list_id)
      else
          loop_on_neighbours (neighbours g current_node)

  in
    match( loop_next_node [id1] id1 ) with
    |None -> None
    |Some(l) -> Some(List.rev (l))


