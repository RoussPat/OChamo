open Graph
open Tools
open Flow


let demandeNoms n = 
	Printf.printf "Il y a donc %d peronnes dans le groupe\n%!" n;
	let rec inner k l = match k with
		|0 -> l 
		|_ -> ( Printf.printf "Entrez le nom de la personne %d\n%!" (n-k+1) ;
		 inner (k-1) ((Scanf.scanf "%s" (fun x->x))::l)) 
	in
	inner n [] ;;

let test =1 ;;
Printf.printf "Bienvenue dans notre application de MoneySharing\n Le but de cette application est de repartir equitablement les depences au sein d'un groupe\n %!" ;;
Printf.printf "Entrez le nombre de personnes dans le groupe\n%!";;
let nbPers = Scanf.scanf "%d" (fun x->x);;
Printf.printf "N= %d \n%!" nbPers ;;
let noms = demandeNoms nbPers;;
Printf.printf "%s\n%!" (List.hd noms);;

