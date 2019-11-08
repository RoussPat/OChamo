open Graph

(*renvoi true si l contient n*)
let contains l n = 
  let rec loop = function
    |x::rest -> if (n=x) then true else (loop rest)
    |_ -> false
  in loop l



let find_path g forbidden id1 id2  = ()
  (*acu = liste de node, last = dernier node ajoute
  iter sur tous les nodes du graphe si un arc existe 
  (pas forbidden et pas deja dans la liste) on lajoute et iteration suivante
  arret : last = destination id2 -> acu 
  
  PB : iter => recursion en arbre sur chaque node possible, il faut garder uniquement 
  le premier chemin trouvé ? le plus court (nb de nodes)? pb au moment du dépilement

  let rec find_next acu last = ??
    *)
