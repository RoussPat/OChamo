open Graph
open Tools
open Flow


let add_transaction l person ammount = 
  let loop acu = function
    |[]->acu
    |(p,a)::rest -> if (p=person) then loop ((p,a+ammount)::acu)  rest 
                                else loop ((p,a)::acu) rest 
  in 
    loop [] l


let read_transaction tot_list tot line = 
	try Scanf.sscanf line "t %s %f" (fun pers ammount -> ((add_transaction tot_list  pers ammount,  tot+ammount))
	with e-> 
		Printf.printf "Cannot read transaction in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    	failwith "from_file" ;;

let read_Pers tot_list line =
	try Scanf.sscanf line "p %s" (fun name -> (name,0.0)::tot_list)
	with e ->  
		Printf.printf "Cannot read person name in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    	failwith "from_file" ;;


let read_comment graph line =
  try Scanf.sscanf line " %%" graph
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
        if line = "" then (n, graph)

        (* The first character of a line determines its content : n or e. *)
        else match line.[0] with
          | 't' -> n,(read_transaction tot_list tot line)
          | 'p' -> (n+1),(read_Pers tot_list line), tot 

          (* It should be a comment, otherwise we complain. *)
          | _ -> (n, read_comment graph line)
      in      
      loop n tot_list2 tot2 pers_list

    with End_of_file ->(n,tot_list,tot) (* Done *)
  in

  let final_result = loop 0 [] 0.0 in
  
  close_in infile ;
  resolv final_result
  
let resolv (n,tot_list,tot) = 
	let tot_list2 = List.map (fun (x,a)->(x,(a-(tot/n)))) tot_list in
	let create_graph n g = match n with
		|0 -> g
		|k -> create_graph (new_node g (k-1)) (k-1)
	in 
	let graph = new (create_graph n empty_graph) in
	let add_arcs g labels = 
		Graph.n_fold g (fun gr1 id1 -> Graph.n_fold gr1 (fun gr2 id2 -> if id1 = id2 then gr2 else (Graph.new_arc gr2 id1 id2 (0,label)))) g
	in
	let graph_with_arc = new_node (new_node (add_arcs graph tot) (n)) (n+1) in
	let rec do_final_graph g k = match tot_list2 with 
		|[] -> g
		|(_,ammount)-> if n >0 then do_final_graph (new_arc (n) k (0.0,ammount)) (k+1) else do_final_graph (new_arc k (n+1) (0.0,ammount)) (k+1)
	in
	let final_graph = do_final_graph graph_with_arc 0 in
	let (solved_Graph,flow) = ford_fulkerson final_graph (n) (n+1) in
	print_debts solved_Graph tot_list n ;;

let get_name_by_id l id = 
	let loop acu = function
		|[] -> failwith "Name not found"
		|(name, _)::rest -> if acu = id then name else loop (acu+1) rest
	in
	loop 0 l


let print_debts g name_list n=
	Graph.n_iter g (fun x -> if((x!=n) and x!=(n+1)) 
							then Printf.printf "%s doit"  get_name_by_id name_list x ;
								List.iter (Graph.out_arcs g x) 
								(fun (id, (ammount,_)) -> Printf.printf " %d € a %s\n%!" ammount (get_name_by_id name_list id));
								Printf.printf "\n%!"
								else ())