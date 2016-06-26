
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
let last_ticks = ref 0
let fps = 1000 / 25

let get_time () =
	Sdltimer.get_ticks ()

let  wait_one_sec prev_time =
	let curr_time_fps = get_time () in
    let diff_time_fps = curr_time_fps - !last_ticks in
    let delay = fps - diff_time_fps in
    print_endline ("DELAY : " ^ string_of_int(delay) ^ " ___ diff curr-last = " ^ (string_of_int diff_time_fps));
    let tmp = if delay > 0
              then delay
              else if (fps - delay) > 0
              then (fps - delay)
              else fps in
    Sdltimer.delay tmp;
    last_ticks := curr_time_fps + tmp;
    let curr_time_sec = get_time () in
	if (curr_time_sec - prev_time) >= 1000
    then true
	else false

let do_action action creature =
	match action with
	| "eat" -> print_endline "action eat"; creature#eat 
	| "bath" -> print_endline "action bath"; creature#bath
	| "thunder" -> print_endline "action thunder"; creature#thunder
	| "kill" -> print_endline "action kill"; creature#kill
	| "sleep" -> print_endline "action sleep"; creature#sleep
	| "save_and_quit" -> print_endline "action save_and_quit"; ignore (Save.save creature); creature (* TODO: test the save return value *)
(* 	| "sing" -> creature#sing  *)
	| _ -> print_endline "action other"; creature


let rec main_loop creature creature_state prev_time =
	match creature_state with
	| false ->
			begin
				Display.display_actions 1;
				Display.display_end ();
				Display.update_display ();
				let input = Display.get_event () in
				if (input = "yes")
					then play_new_game ()
				else ()
			end
	| true	->
			begin 
				Display.display_creature ();
				Display.display_meters creature#get;
				Display.display_actions 0;
				Display.update_display ();
				let player_action = Display.get_event ()
				in let new_creature = do_action player_action creature
				in
				begin
					(* wait_one_sec timestamp;  *)
					if (wait_one_sec prev_time)
					then
						begin
							let creature_x = new_creature#decre_health in
                            last_ticks := get_time ();
							main_loop creature_x creature_x#is_alive !last_ticks(* (get_timestamp ()) *)
						end
					else
						main_loop new_creature new_creature#is_alive prev_time (* (get_timestamp ()) *)
				end
			end
and
play_new_game () =
    last_ticks := get_time ();
	let creature_bis = new Creature.creature 100 100 100 100 in
	main_loop creature_bis creature_bis#is_alive (!last_ticks)

let () =
	Init.init ();

    last_ticks := get_time ();	
	let creature = ( match Save.load with
	| None -> new Creature.creature 100 100 100 100
	| Some (creature) -> creature
	) in
	main_loop creature creature#is_alive (!last_ticks); (* (get_timestamp ()) *)
	Display.quit ()