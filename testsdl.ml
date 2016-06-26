let pika = "ressources/pikachu.png"
let pika_dead = "ressources/pikachu_rip.png"
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
let rec wait_for_escape bt =
		match Sdlevent.wait_event () with
			| evt -> match evt with
						| Sdlevent.MOUSEBUTTONDOWN { Sdlevent.mbe_x = x ; Sdlevent.mbe_y = y ; mbe_button = b } -> 
								let rec check_buttons lst = match lst with
									| hd::tl -> 
									if (hd#is_in_bound x y)
									then begin print_endline hd#name ; wait_for_escape bt end
									else check_buttons tl
									| [] -> wait_for_escape bt
								in check_buttons bt

						| Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } -> ()

						| _ -> wait_for_escape bt


let display_text text_str screen =
    let screen_dim = Sdlvideo.surface_dims screen in
    let s_w = match screen_dim with | (w,_,_) -> w in
    let s_h = match screen_dim with | (_,h,_) -> h in

	let font = Sdlttf.open_font pikattf 48 in
	let text = Sdlttf.render_text_blended font text_str ~fg:Sdlvideo.red in
	let text_dim = Sdlvideo.surface_dims text in
	let t_w = match text_dim with | (w,_,_) -> w in
	let t_h = match text_dim with | (_,h,_) -> h in
	let position_of_text = Sdlvideo.rect  ((s_w/2) - (t_w/2)) ((s_h/2) - (t_h/2)) t_w t_h in

	Sdlvideo.blit_surface ~src:text ~dst:screen ~dst_rect:position_of_text ()


let display_end screen =
    let screen_dim = Sdlvideo.surface_dims screen in
    let s_w = match screen_dim with | (w,_,_) -> w in
    let s_h = match screen_dim with | (_,h,_) -> h in

    let image = Sdlloader.load_image pika_dead in
	let music = Sdlmixer.load_music pikamp3 in
	let dim = Sdlvideo.surface_dims image in 
	let width = match dim with | (w,_,_) -> w in
	let height = match dim with | (_,h,_) -> h in
	let position_of_image = Sdlvideo.rect 0 0 300 300 in
	let screen = Sdlvideo.set_video_mode width height [`DOUBLEBUF] in
    let buttons = [new Button.yes 250 350; new Button.no 550 350] in

    Sdlvideo.set_alpha image 200;
	Sdlvideo.blit_surface ~dst_rect:position_of_image ~src:image ~dst:screen ();
	let rec blit_buttons lst = match lst with
		| hd::tail -> hd#blit_to_surface screen; blit_buttons tail
		| [] -> ()
	in
	blit_buttons buttons ;
    display_text "Try Again ?" screen;
    Sdlvideo.flip screen ;
	Sdlmixer.fadein_music music 1.0;
	wait_for_escape buttons;
	Sdlmixer.fadeout_music 2.0;
	Sdlmixer.halt_music ();
	Sdlmixer.free_music music


let run () =
	let image = Sdlloader.load_image pika in
	let music = Sdlmixer.load_music pikamp3 in
	let dim = Sdlvideo.surface_dims image in 
	let width = match dim with | (w,_,_) -> w in
	let height = match dim with | (_,h,_) -> h in
	let position_of_image = Sdlvideo.rect 0 0 300 300 in
	let screen = Sdlvideo.set_video_mode width height [`DOUBLEBUF] in
    let buttons = [new Button.eat 100 150; new Button.bath 300 150; new
    Button.thunder 500 150; new Button.kill 700 150] in


	Sdlvideo.blit_surface ~dst_rect:position_of_image ~src:image ~dst:screen ();
	let rec blit_buttons lst = match lst with
		| hd::tail -> hd#blit_to_surface screen; blit_buttons tail
		| [] -> ()
	in
	blit_buttons buttons ;
	Sdlvideo.flip screen;
	Sdlmixer.fadein_music music 1.0;
    display_end screen;  (*======CALL END SCREEN=====*)
	wait_for_escape buttons;
	Sdlmixer.fadeout_music 2.0;
	Sdlmixer.halt_music ();
    Sdlmixer.free_music music


let main () =
	Sdl.init [`VIDEO; `AUDIO];
	at_exit Sdl.quit;

	Sdlttf.init ();
	at_exit Sdlttf.quit;

	Sdlmixer.open_audio ();
	at_exit Sdlmixer.close_audio;


	run ()

let () = main ()
