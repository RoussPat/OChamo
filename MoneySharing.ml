open Graph
open Tools
open Flow



let read_transaction tot_list tot line = 
	try Scanf.sscanf line "t %s %f" (fun pers ammount -> ((SETTER_EMMA,(tot6+ammount))
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

    with End_of_file ->(tot_list,tot,pers_list) (* Done *)
  in

  let final_result = loop 0 [] 0.0 in
  
  close_in infile ;
  resolv final_result
  
