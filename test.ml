open Gfile
open Tools
open Flow

let g1 = (Gfile.from_file "graph1");;
let n1 = neighbours g1 1;;
let n2 = neighbours g1 2;;

let f id = Printf.printf ("%d ") id;;
List.iter f n1 ;;
Printf.printf "\n%!" ;;
List.iter f n2 ;;
Printf.printf "\n%!" ;;


(* TESTS GFILE
   Gfile.write_file "graph2" (clone_nodes g1);;
   Gfile.export "graph3" g1;;
   Gfile.write_file "graph4" (gmap g1 (fun x -> (x ^ "POUET")));;

   let g2 = gmap g1 (fun x -> int_of_string x);;
   let g3 = Tools.add_arc g2 3 1 3;;
   let g4 = Tools.add_arc g3 3 5 3;;
   let g5 = gmap g4 (fun x -> string_of_int x);;
   Gfile.write_file "graph6" g5;;
*)

(* TESTS NEIGHBOURS*)

