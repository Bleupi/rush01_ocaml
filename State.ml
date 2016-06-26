class state name x y level =
object (self)
	val _name = name
	val _surface =  Sdlttf.render_text_blended (Sdlttf.open_font "ressources/pika.TTF" 24) name ~fg:Sdlvideo.black
	val mutable _width = 0
	val mutable _height = 0
	val _x = x
	val _y = y
	val _surface_rect_fill_up = Sdlvideo.rect x y level 20
	val _surface_rect_border = Sdlvideo.rect (x-2)(y-2) 104 24
(* 	val _surface_rect_empty = create_RGB_surface_format
 *)	val mutable _to_screen = Sdlvideo.rect 0 0 0 0

	method name = _name
	method init = 
		ignore(_width <- match Sdlvideo.surface_dims _surface with | (w,_,_) -> w);
		ignore(_height <- match Sdlvideo.surface_dims _surface with | (_,h,_) -> h);
		ignore(_to_screen <- Sdlvideo.rect _x _y _width _height);

	method is_in_bound x y = (x >= _x && x < (_x + _width) && y >= _y && y < (_y + _height))
	method blit_to_surface surface = 
	Sdlvideo.fill_rect ~rect:_surface_rect_border surface (Int32.of_int 0xFF0000);
	Sdlvideo.fill_rect ~rect:_surface_rect_fill_up surface (Int32.of_int (255 * 255));
	Sdlvideo.blit_surface ~dst_rect:_to_screen ~src:_surface ~dst:surface ()

end


 class health x y level=
object (self)
	inherit state "Health" x y level
	initializer self#init
end

class energy x y level=
object (self)
	inherit state "Energy" x y level
	initializer self#init
end

class hygiene x y level=
object (self)
	inherit state "Hygiene" x y level
	initializer self#init
end

class happy x y level=
object (self)
	inherit state "Happy" x y level
	initializer self#init
end 
