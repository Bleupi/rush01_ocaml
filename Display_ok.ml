let pika = "ressources/pikachu.png"
let eat_button = "ressources/eat_button.png"
let pikattf = "ressources/pika.TTF"
let pikamp3 = "ressources/pika.mp3"
(* 
let create_button text =
	let button = Sdlloader.load_image button_base in
	let b_dim = Sdlvideo.surface_dims button in
	let b_w = match b_dim with | (w,_,_) -> w in
	let b_h = match b_dim with | (_,h,_) -> h in

	let font = Sdlttf.open_font pikattf 24 in
	let text = Sdlttf.render_text_blended font text ~fg:Sdlvideo.white in
	let text_dim = Sdlttf.size_text text in
	let t_w = match text_dim with | (w,_) -> w in
	let t_h = match text_dim with | (_,h) -> h in


	let position_of_text = Sdlvideo.rect  () in

	Sdlvideo.blit_surface ~src:text ~dst:button ();
	button
 *)
let bt_lst = [new Button.eat 150 150; new Button.bath 350 150 ;new Button.thunder 150 150; new Button.kill 350 150 ;new Button.sleep 150 150; new Button.sing 350 150; new Button.save_and_quit 150 150]
let bt_end_lst = []


let get_event () =
		match Sdlevent.wait_event () with
			| evt -> match evt with
						| Sdlevent.MOUSEBUTTONDOWN { Sdlevent.mbe_x = x ; Sdlevent.mbe_y = y ; mbe_button = b } -> 
								let rec check_buttons lst = match lst with
									| hd::tl -> 
									if (hd#is_in_bound x y)
									then hd#name 
									else check_buttons tl
									| [] -> ""
								in check_buttons bt_lst

						| Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } -> "quit and save" (* A REMPLACER PAR LE BON NOM*)

						| _ -> ""

let display_meters states_lst = 
	let x =  10 in 
	let y = 10 in 
	let rec blit_states lst x y = match lst with
		| (s, value)::tail -> (new State.state s x y value)#blit_to_surface screen; blit_states tail (x+150) (y)
		| [] -> ()
	in
	blit_states states_lst x y;


let rec display_actions flag =
	let rec blit_buttons lst = 
	match lst with
	| hd::tail -> hd#blit_to_surface screen; blit_buttons tail
	| [] -> ()
	in
	if (flag = 0) 
	then blit_buttons bt_lst
	else blit_buttons bt_end_lst

let display_creature () = 
	let image = Sdlloader.load_image pika in
	Sdlvideo.blit_surface ~dst_rect:position_of_image ~src:image ~dst:screen ()




let run () =
	let image = Sdlloader.load_image pika in
	let music = Sdlmixer.load_music pikamp3 in
	let dim = Sdlvideo.surface_dims image in 
	let width = match dim with | (w,_,_) -> w in
	let height = match dim with | (_,h,_) -> h in
	let position_of_image = Sdlvideo.rect 0 0 300 300 in
	let screen = Sdlvideo.set_video_mode width height [`DOUBLEBUF] in
	let buttons = [new Button.eat 150 150; new Button.bath 350 150] in
	let states = [new State.health 10 10 15;  new State.energy 100 100 100] in
	Sdlvideo.flip screen;
	Sdlmixer.fadein_music music 1.0;
	wait_for_escape buttons;
	Sdlmixer.fadeout_music 2.0;
	Sdlmixer.halt_music ();
	Sdlmixer.free_music music

let main () =
	

	run ()





let init () = 
	Sdl.init [`VIDEO; `AUDIO];
	at_exit Sdl.quit;

	Sdlttf.init ();
	at_exit Sdlttf.quit;

	Sdlmixer.open_audio ();
	at_exit Sdlmixer.close_audio;
