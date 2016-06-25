
(* 
	create_obj
	while(1)
	clear_win
	display_perso
	display_meters
	display_action
	get_input
	-> obj = action 
	wait fps
	if (!obj.getState)
		-> display_gameover
		-> display_new_game
		-> get_input

*)

(* let get_timestamp = 
	??????

let  wait_one_sec timestamp = 
	Unix.sleepf ( ) //mettre calcul pour une seconde, il faut que cela soit un float, en dessous de 0, ce sont des fractions de secondes
	??? Sdltimer.get_ticks ??? *)
let  wait_one_sec timestamp =
	Random.self_init ();
	Random.bool ()

let do_action action creature =
	match action with
	| 0 -> print_endline  "action eat"; creature#eat 
	| 1 -> print_endline  "action bath"; creature#bath
	| 2 -> print_endline  "action thunder"; creature#thunder
	| 3 -> print_endline  "action kill"; creature#kill
	| 4 -> print_endline  "action save_and_quit"; Display.display_save_and_quit (); creature
	| _ -> print_endline  "action other"; creature


let rec main_loop creature creature_state =
	match creature_state with 
	| false -> 
			begin
				Display.display_gameover ();
				Display.display_new_game ();
				let input = Display.get_event () in 
				if (input = 5)
					then play_new_game ()
				else ()
			end
	| true	-> 
			begin 
				Display.clear_win ();
				Display.display_creature creature;
				Display.display_meters creature#get;
				Display.display_actions creature#get_actions;
				Display.display_button_save_and_quit ();
				let player_action = Display.get_event ()
				in let new_creature = do_action player_action creature
				in
				begin  
					(* wait_one_sec timestamp;  *)
					if (wait_one_sec 0)
					then
						begin 
							let creature_x = new_creature#decre_health in 
							main_loop creature_x creature_x#is_alive (* (get_timestamp ()) *)
						end
					else
						main_loop new_creature new_creature#is_alive (* (get_timestamp ()) *)

				end
			end
and 
play_new_game () =
	let creature_bis = new Creature.creature 100 100 100 100 in
	main_loop creature_bis creature_bis#is_alive

let () =
	Display.create_win ();
	let creature = new Creature.creature 100 100 100 100 in 
		main_loop creature creature#is_alive (* (get_timestamp ()) *)