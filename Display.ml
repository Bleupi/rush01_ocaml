let rec print lst =
  match lst with
  | [] -> print_char '\n'
  | (stat, value)::t -> print_string (stat ^ " : " ^ (string_of_int value) ^ " "); print t

let clear_win () = print_string "\n\n"; print_endline "clear_win"
let create_win () = print_endline "create_win"
let display_gameover () = print_endline "----- false ------";print_endline "display_gameover"
let display_new_game () = print_endline "display_new_game"
let display_creature creature = print_endline "display_creature" ;print_endline (creature#to_string)
let display_meters l = print l 
let display_save_and_quit () = print_endline "display_save_and_quit"

let rec display_actions l = 
	match l with
	| [] -> print_string ""
	| hd::bd -> print_endline hd; display_actions bd
let display_button_save_and_quit () = print_endline "display_button_save_and_quit"
let get_event () = Random.self_init (); Random.int 5 