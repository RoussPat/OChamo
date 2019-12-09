open Gfile
open Tools
open Flow
open MoneySharing

let (a,b,c) = MoneySharing.from_file "input.txt" ;;
Printf.printf "n= %d\n%!" c ;;
MoneySharing.resolv (a,b,c)
