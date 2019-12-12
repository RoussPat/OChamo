open Gfile
open Tools
open Flow
open MoneySharing

let (a,b,c) = MoneySharing.from_file "input.txt" ;;
Printf.printf "Total dépenses = %d\n%!" c ;;
MoneySharing.resolv (a,b,c)
