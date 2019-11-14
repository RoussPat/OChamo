open Graph

(*renvoi true si l contient n*)
let contains l n = 
  let rec loop = function
    |x::rest -> if (n=x) then true else (loop rest)
    |_ -> false
  in loop l



let neighbour g id = (* 'a graph -> 'a' -> 'a' list *)
  (* retourne une liste de touts les voisins d'un node id dans le graph g
    parcours tout les arcs de g avec G.iter *)
  let arcs = Graph.out_arcs g id in
  List.map (fun (x, y) -> x) arcs

let flow_var g idlist = (*(float*float) graph ->  id list -> float *)

let variation_graph g = (*(float*float) graph -> float graph *) 




(* cherche un chemin entre id1 et id2, retourne Some(id list) si il existe, None sinon*)
let find_path g forbidden id1 id2  =
  
  let rec loop_next_node list_id current_node = 
    (*appel recursif sur les voisins du noeud courant*)
    let rec loop_on_neighbours neighbours = match neighbours with
      |[] -> None
      |x::rest -> if (contains list_id x || contains forbidden x)
                then None
                else match (loop_next_node x::list_id x) with
                  |None -> loop_on_neighbours rest
                  |X -> X
    in
 
      if (currend_node = id2)
      then Some(list_id)
      else
        let neighbours_of_current_node = neighbour g x 
        in
          loop_on_neighbours neighbours_of_current_node
  in
    loop_next_node [] x 
