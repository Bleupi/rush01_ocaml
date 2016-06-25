let main () =
    Sdl.init [`VIDEO];
    ignore(Sdlvideo.set_video_mode 200 200 []);
    Sdltimer.delay 2000;
    Sdl.quit ()

let () = main ()