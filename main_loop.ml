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

let play_new_game () =
	let creature_bis = create_creature () in
	main_loop creature (creature.is_alive ()) 

let do_action action creature =
	match action with
	| 0 -> creature.eat ()
	| 1 -> creature.bath ()
	| 2 -> creature.thunder ()
	| 3 -> creature.kill ()
	| 4 -> save_and_quit creature


let rec main_loop creature creature_state =
	match creature_state with 
	| false -> 
			begin
				Display.display_gameover ()
				Display.display_new_game ()
				let input = Display.get_input () in 
				if (input = 5)
					then play_new_game ()
				else ()
			end
	| true	-> 
			begin 
				Display.clear_win ()
				Display.display_creature creature
				Display.display_meters creature.get_meters
				Display.display_actions creature.actions 
				Display.display_button_save_and_quit ()
				let player_action = Display.get_event ()
				in let new_creature = do_action player_action creature
				in main_loop new_creature (new_creature.is_alive ()) 
			end


let () =
	Display.create_win
	let creature = create_creature () in 
		main_loop creature (creature.is_alive ()) 