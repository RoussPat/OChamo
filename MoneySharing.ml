open Graph
open Tools
open Flow
open Gfile

type person = string

type transaction = (person*int)

let add_transaction l person ammount = 
  let rec  loop acu = function
    |[]->acu
    |(p,a)::rest -> if (p=person) then loop ((p,a+ammount)::acu)  rest 
                                else loop ((p,a)::acu) rest 
  in 
    loop [] l
;;


let read_transaction n tot_list tot line =
  (*Printf.printf "new transaction at line %s\n%!" line;*)
	try Scanf.sscanf line "t %s %d" (fun pers ammount -> ((n,(add_transaction tot_list  pers ammount),  tot+ammount)))
	with e -> Printf.printf "Cannot read transaction in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    	failwith "from_file" ;;

let read_Pers tot_list line =
  (*Printf.printf "new persone at line %s\n%!" line;*)
	try Scanf.sscanf line "p %s" (fun name -> (name,0)::tot_list)
	with e ->  
		Printf.printf "Cannot read person name in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    	failwith "from_file" ;;


let read_comment n tot_list2 tot2 line =
  try Scanf.sscanf line " %%" n, tot_list2, tot2
  with _ ->
    Printf.printf "Unknown line:\n%s\n%!" line ;
    failwith "from_file"




let from_file path =
  let infile = open_in path in
  (* Read all lines until end of file. 
   * n is the current node counter. *)
  let rec loop n tot_list tot =
    try
      let line = input_line infile in

      (* Remove leading and trailing spaces. *)
      let line = String.trim line in

      let (n2,tot_list2, tot2) =
        (* Ignore empty lines *)
        if line = "" then (n,tot_list, tot)

        (* The first character of a line determines its content : n or e. *)
        else match line.[0] with
          | 't' -> (read_transaction n tot_list tot line)
          | 'p' -> (n+1),(read_Pers tot_list line), tot 

          (* It should be a comment, otherwise we complain. *)
          | _ -> (read_comment n tot_list tot line)
      in      
      loop n2 tot_list2 tot2

    with End_of_file ->(n,tot_list,tot) (* Done *)
  in
  let final_result = loop 0 [] 0 in
  close_in infile ;
  final_result
  
let rec print_tot_list l = match l with
 |[] -> Printf.printf "\n%!"
 |(name,ammount)::rest -> Printf.printf "[nom = %s : %d€] " name ammount ; print_tot_list rest
;;

let get_name_by_id l id = 
  let rec loop acu lis id1= match lis with
    |[] -> "test" (*failwith (Printf.sprintf "Name not found id= %d" id)*)
    |(name,ammount)::rest -> if (acu == id) then name ^" ("^(string_of_int id)^")" else loop (acu+1) rest id1
  in
  loop 0 l id

let print_debts g name_list n=
  let curried x = if ((x!=n) && (x!=(n+1)))
      then ((Printf.printf "%s doit :\n" (get_name_by_id name_list x) );
      (List.iter (fun (id, (ammount,_)) -> if ((id!=n) && (id!=(n+1))) then (Printf.printf "%d € a %s\n%!" ammount (get_name_by_id name_list id)) else ()) (Graph.out_arcs g x));
      (Printf.printf "\n%!"))
      else Printf.printf "" in
  Graph.n_iter g curried;;



let resolv (n,tot_list,tot) = 
	let tot_list2 = List.map (fun (x,a)->(x,(a-((int_of_float ((float_of_int tot)/.(float_of_int n))))))) tot_list in
	let rec create_graph n1 g = match n1 with
		|0 -> g
		|k -> create_graph (k-1) (new_node g (k-1)) 
	in 
	let graph = (create_graph n empty_graph) in
	let add_arcs g label = 
		Graph.n_fold g (fun gr1 id1 -> Graph.n_fold gr1 (fun gr2 id2 -> if id1 = id2 then gr2 else (Graph.new_arc gr2 id1 id2 (0,label))) gr1) g
	in
	let graph_with_arc = new_node (new_node (add_arcs graph tot) (n)) (n+1) in
	let rec do_final_graph g k l= match l with 
		|[] -> g
	  |(_,ammount)::rest-> if ammount > 0 then do_final_graph (new_arc g (n) k (0,ammount)) (k+1) rest else do_final_graph (new_arc g k (n+1) (0,-ammount)) (k+1) rest
	in
	let final_graph = do_final_graph graph_with_arc 0 tot_list2 in
	let (solved_Graph,flow) = (ford_fulkerson final_graph (n) (n+1)) in
  let str_result = int_int_graph_to_string_graph solved_Graph in
  Gfile.export "MoneySharing_result.dot" str_result ;
  Sys.command ("dot -Tsvg MoneySharing_result.dot > ./TestToExport/MoneySharing_result.svg");
  (*Printf.printf "FLOW = %d\n%!" flow;*)
	print_debts solved_Graph tot_list n ;;
  


