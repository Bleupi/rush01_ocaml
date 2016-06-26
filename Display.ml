let width = 1000
let height = 1000 
let screen = Sdlvideo.set_video_mode width height [`DOUBLEBUF]
let screen_dim = Sdlvideo.surface_dims screen
let s_w = match screen_dim with | (w,_,_) -> w
let s_h = match screen_dim with | (_,h,_) -> h

(*RESOURCES*)

let pika = "ressources/pikachu.png"
let pika_dead = "ressources/pikachu_rip.png"
let eat_button = "ressources/eat_button.png"
let pikattf = "ressources/pika.TTF"
(* let music1 = Sdlmixer.load_music "ressources/sons/pika.mp3" 
let music2 = Sdlmixer.load_music "ressources/sons/sleep.mp3"
 *)

let bt_lst = [new Button.eat 150 150; new Button.bath 350 150 ;new Button.thunder 150 150; new Button.kill 350 150 ;new Button.sleep 150 150; new Button.save_and_quit 150 150] (* ; new Button.sing 350 150; *)
let bt_end_lst = [new Button.yes 250 350; new Button.no 550 350]


let display_text text_str =
	let font = Sdlttf.open_font pikattf 48 in
	let text = Sdlttf.render_text_blended font text_str ~fg:Sdlvideo.red in
	let text_dim = Sdlvideo.surface_dims text in
	let t_w = match text_dim with | (w,_,_) -> w in
	let t_h = match text_dim with | (_,h,_) -> h in
	let position_of_text = Sdlvideo.rect  ((s_w/2) - (t_w/2)) ((s_h/2) - (t_h/2)) t_w t_h in
	Sdlvideo.blit_surface ~src:text ~dst:screen ~dst_rect:position_of_text ()

let display_end () =
    let image = Sdlloader.load_image pika_dead in 
	let position_of_image = Sdlvideo.rect 0 0 300 300 in
(*	let screen = Sdlvideo.set_video_mode width height [`DOUBLEBUF] in*)
    Sdlvideo.set_alpha image 200;
	Sdlvideo.blit_surface ~dst_rect:position_of_image ~src:image ~dst:screen ();
    display_text "GAME OVER!\nTry Again ?";
    Sdlvideo.flip screen
(* 	Sdlmixer.fadein_music music2 1.0;
 *)


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
	blit_states states_lst x y


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
	Sdlvideo.blit_surface ~dst_rect:(Sdlvideo.rect 0 0 300 300) ~src:image ~dst:screen ()


let quit () =
    Sdlmixer.fadeout_music 2.0;
	Sdlmixer.halt_music ()

let update_display () =
	Sdlvideo.flip screen

(*
main_loop
call Init.init () 
puis Display ...


*)