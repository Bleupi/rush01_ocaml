let init () = 
	Sdl.init [`VIDEO; `AUDIO];
	at_exit Sdl.quit;

	Sdlttf.init ();
	at_exit Sdlttf.quit;

	Sdlmixer.open_audio ();
	at_exit Sdlmixer.close_audio;