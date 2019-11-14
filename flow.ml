open Graph

(*renvoi true si l contient n*)
let contains l n = 
  let rec loop = function
    |x::rest -> if (n=x) then true else (loop rest)
    |_ -> false
  in loop l



let neighbour g id = (* 'a graph -> 'a' -> 'a' list *)
  (* retourne une liste de touts les voisins d'un node id dans le graph g
    parcours tout les arcs de g avec G.iter 
    verifie avec un predicat bidon (fun id1 id2 -> id1 = id) prend un arc et verifie si la source est id
    (on peut utiliser List.cons sur le iter mais il faut raouter la dimention du predicat )

    TO DO
  *)

let flow_var g idlist = (*(float*float) graph ->  id list -> float *)

let variation_graph g = (*(float*float) graph -> float graph *) 





let find_path g forbidden id1 id2  = ()
  (*acu = liste de node, last = dernier node ajoute
  iter sur tous les nodes du graphe si un arc existe 
  (pas forbidden et pas deja dans la liste) on lajoute et iteration suivante
  arret : last = destination id2 -> acu 
  
  PB : iter => recursion en arbre sur chaque node possible, il faut garder uniquement 
  le premier chemin trouvé ? le plus court (nb de nodes)? pb au moment du dépilement

  let rec find_next acu last = ??
  
  il faut une pile,
  il faut labeliser les sommets ou utiliser une liste d'association
  entre les sommets et des labels (liste de LabeledId)
  ensuite on empile le permier sommet du graph
  et tant que la pile n'est pas vide on explore la tete de la fille 
  en enfilan les fils de chaques noeux si ils ne sont pas marqués
  
  on retourne l'etat du lablel de destination a la fin de l'algo
  on arrete si on explore id2
    *)

