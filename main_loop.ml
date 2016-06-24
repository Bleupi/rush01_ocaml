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



let main_loop 