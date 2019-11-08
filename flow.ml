open Graph

(*renvoi true si l contient n*)
let contains l n = 
  let rec loop = function
    |x::rest -> if (n=x) then true else (loop rest)
    |_ -> false
  in loop l



let find_path g forbidden id1 id2  = ();;
