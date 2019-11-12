open Graph

type labledId = {
  id:id;
  bool:marked;
}

(*renvoi true si l contient n*)
let contains l n = 
  let rec loop = function
    |x::rest -> if (n=x) then true else (loop rest)
    |_ -> false
  in loop l

let labelfind l id = 
  let rec inner l = match l with
    |x::rest -> if (id=x.id) then x else inner l
    |_ -> false
  in 
  inner l ;;

let unlabel labeledlist = 
  let inner acu l =
    match l with 
    |[] -> acu
    |x::rest -> inner x.id::acu rest
  in
  inner [] labeledlist ;;

let voisin g id = (* 'a graph -> 'a' -> 'a' list *)
  (* retourne une liste de touts les voisins d'un node id dans le graph g
    parcours tout les arcs de g avec G.iter 
    verifie avec un predicat bidon (fun id1 id2 -> id1 = id) prend un arc et verifie si la source est id
    (on peut utiliser List.cons sur le iter mais il faut raouter la dimention du predicat )

    TO DO
  *)

let rmmarked idlist labeledlist = (*Pirvate*)
  (* retire toute les occurences de noeux marqués dans labeledlist de la list idlist et la retourne*)
  let rec inner acu idlist = 
    match idlist with
      |[] -> acu
      |x::rest -> (let k = labelfind labeledlist x in 
        if k.marked then inner acu rest else inner (x::acu) rest)
    in
  inner [] idlist ;;


let find_path g forbidden id1 id2  = ()
  (*acu = liste de node, last = dernier node ajoute
  iter sur tous les nodes du graphe si un arc existe 
  (pas forbidden et pas deja dans la liste) on lajoute et iteration suivante
  arret : last = destination id2 -> acu 
  
  PB : iter => recursion en arbre sur chaque node possible, il faut garder uniquement 
  le premier chemin trouvé ? le plus court (nb de nodes)? pb au moment du dépilement

  let rec find_next acu last = ??
  
  il faut une pile,
  il faut labeliser les sommets ou utiliser une liste d'assotiation
  entre les sommets et des labels (liste de LabeledId)
  ensuite on empile le permier sommet du graph
  et tant que la pile n'est pas vide on explore la tete de la fille 
  en enfilan les fils de chaques noeux si ils ne sont pas marqués
  
  on retourne l'etat du lablel de destination a la fin de l'algo


  IMPROUMENTS: on arrete si on explore id2
    *)
    let lablist = (* ...*) in

    let rec explorer id = 
    lablist[id].marked = true ; 

    Pile.push (rmmarked (voisin g id));;


