open Graph
open Tools
open Flow

type person = string

type transaction = (person*int)

val add_transaction: transaction list -> person -> int -> transaction list

val read_transaction: int -> transaction list -> int -> string -> int*(transaction list)*int

val read_Pers: transaction list -> string -> transaction list

val from_file : string -> int*(transaction list)*int

val resolv: int*(transaction list)*int-> unit

val get_name_by_id: transaction list ->  int -> person
 
val print_debts: (int*int) graph -> transaction list -> int -> unit