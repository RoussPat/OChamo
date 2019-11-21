open Graph
open Tools

type path = id list

let listprint id = Printf.printf ("%d ") id;;


let rec add_arc_flow g id1 id2 amount = (*(int*int) graph -> id -> id -> int -> (int*int) graph *)
  match (Graph.find_arc g id1 id2) with
    |None -> add_arc_flow g id2 id1 (-1*amount) 
    |Some((x,cap)) -> Graph.new_arc g id1 id2 ((x+amount),cap);;

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



let flow_var g idlist =(*int graph ->  path -> int *)
  let rec inner acu l = match l with
    |[] -> failwith "not possible"
    |[x]-> acu
    |x::(y::rest) -> (match List.find(fun (a,_) -> a=y) (Graph.out_arcs g x) with
      |_,z -> if z < acu then inner z (y::rest) else inner acu (y::rest) ) 
  in
  inner 4611686018427387903 idlist ;;


let variation_graph gr = (*(int*int) graph -> int graph *) 
  let g2 = Graph.e_fold gr (fun g id1 id2 (a,b) -> if (b-a) != 0 then(Graph.new_arc g id1 id2 (b-a)) else g) (clone_nodes gr)  in
  Graph.e_fold gr (fun g id1 id2 (a,b) -> if a != 0 then (Graph.new_arc g id2 id1 a) else g ) g2 
;;

let apply_flow_var gr idlist amount = (*(int*int) graph -> path -> int -> (int*int) graph*)
  let rec inner l g = match l with
    |[]->failwith "not possible"
    |[x]-> g
    |x::(y::rest) -> (inner (y::rest) (add_arc_flow g x y amount)) (*on ajouter la somme "ammout" des arc de la liste de node idlist dans l'ordre *)
  in
  inner idlist gr;;

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
      else loop_on_neighbours (neighbours g current_node)

  in
    match( loop_next_node [id1] id1 ) with
    |None -> None
    |Some(l) -> Some(List.rev (l))


let ford_fulkerson g puit source=
  let rec inner g d =
  let var_graph = (variation_graph g) in
    match (find_path var_graph [] puit source) with
      | None -> (g,d)
      | Some(x) -> (let delta = (flow_var var_graph x) in 
                    List.iter listprint x ;Printf.printf "| avec flot D = %d\n%!" delta ; inner (apply_flow_var g x delta) (d+delta))
  in
  inner g 0 ;;