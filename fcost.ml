open Graph
open Tools

type path = id list

let listprint id = Printf.printf ("%d ") id;;


let rec add_arc_flow g id1 id2 amount = (*(int*int*int) graph -> id -> id -> int -> (int*int*int) graph *)
  match (Graph.find_arc g id1 id2) with
    |None -> add_arc_flow g id2 id1 (-1*amount) 
    |Some((x,cap,cost)) -> Graph.new_arc g id1 id2 ((x+amount),cap,cost);;

(*renvoi true si l contient n*)
let contains l n = 
  let rec loop = function
    |x::rest -> if (n=x) then true else (loop rest)
    |_ -> false
  in loop l



let neighbours g id = (* (int*int) graph -> id -> (id*int) list  *)
  (* retourne une liste de touts les voisins d'un node id dans le graph g
    parcours tout les arcs de g avec G.iter *)
  let arcs = Graph.out_arcs g id in
  List.map (fun (x, (k,c)) -> (x,c)) arcs



let flow_var g idlist =(*(int*int*int) graph ->  path -> int *)
  let rec inner acu l = match l with
    |[] -> failwith "not possible"
    |[x]-> acu
    |x::(y::rest) -> (match List.find(fun (a,_) -> a=y) (Graph.out_arcs g x) with
      |(_,(z,_)) -> if z < acu then inner z (y::rest) else inner acu (y::rest) ) 
  in
  inner 4611686018427387903 idlist ;;


let variation_graph gr = (*(int*int*int) graph -> (int*int) graph *) 
  let g2 = Graph.e_fold gr (fun g id1 id2 (a,b,c) -> if (b-a) != 0 then(Graph.new_arc g id1 id2 ((b-a),c)) else g) (clone_nodes gr)  in
  Graph.e_fold gr (fun g id1 id2 (a,b,c) -> if a != 0 then (Graph.new_arc g id2 id1 (a,-1*c)) else g ) g2 
;;

let apply_flow_var gr idlist amount = (*(int*int*int) graph -> path -> int -> (int*int*int) graph*)
  let rec inner l g = match l with
    |[]->failwith "not possible"
    |[x]-> g
    |x::(y::rest) -> (inner (y::rest) (add_arc_flow g x y amount)) (*on ajouter la somme "ammout" des arc de la liste de node idlist dans l'ordre *)
  in
  inner idlist gr;;

(* cherche un chemin entre id1 et id2, retourne Some(id list, cost) si il existe, None sinon*)
let find_path g forbidden id1 id2  =
  
  let rec loop_next_node list_id current_node current_cost= 
    (*appel recursif sur les voisins du noeud courant*)
    let rec loop_on_neighbours n = match n with
      |[] -> None
      |(x,c)::rest -> if (contains list_id x || contains forbidden x)
                then loop_on_neighbours rest
                else match (loop_next_node (x::list_id) x (current_cost + c)) with
                  |None -> loop_on_neighbours rest
                  |Some((l, cost)) -> match (loop_on_neighbours rest) with (*compare le cout pour retourner le chemin de cout min*)
                    |None -> Some(l,cost)
                    |Some((l2, cost2)) -> if (cost < cost2) then Some((l, cost)) else Some((l2, cost2))
    in
 
      if (current_node = id2)
      then Some((list_id, current_cost))
      else
          loop_on_neighbours (neighbours g current_node)

  in
    match( loop_next_node [id1] id1 0 ) with
    |None -> None
    |Some((l,c)) -> Some(List.rev (l), c)


let ford_fulkerson_min_cost g puit source=
  let rec inner g d c =
  let var_graph = (variation_graph g) in
    match (find_path var_graph [] puit source) with
      | None -> (g,d,c)
      | Some((x,k)) -> (let delta = (flow_var var_graph x) in 
                    (*List.iter listprint x ;Printf.printf "| avec var flot D = %d et cout = %d\n%!" delta k;*) inner (apply_flow_var g x delta) (d+delta) (c+(k*delta)))
  in
  inner g 0 0;;



