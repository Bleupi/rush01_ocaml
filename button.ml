class button name x y =
object (self)
	val _name = name
	val _surface = Sdlloader.load_image ("ressources/" ^ name ^ "_button.png")
	val mutable _width = 0
	val mutable _height = 0
	val _x = x
	val _y = y
	val mutable _to_screen = Sdlvideo.rect 0 0 0 0

	method name = _name
	method init = 
		ignore(_width <- match Sdlvideo.surface_dims _surface with | (w,_,_) -> w);
		ignore(_height <- match Sdlvideo.surface_dims _surface with | (_,h,_) -> h);
		ignore(_to_screen <- Sdlvideo.rect _x _y _width _height)
	method is_in_bound x y = (x >= _x && x < (_x + _width) && y >= _y && y < (_y + _height))
	method blit_to_surface surface = 
	Sdlvideo.blit_surface ~dst_rect:_to_screen ~src:_surface ~dst:surface ();
end


class eat x y =
object (self)
	inherit button "eat" x y
	initializer self#init
end

class thunder x y =
object (self)
	inherit button "thunder" x y
	initializer self#init
end

class kill x y =
object (self)
	inherit button "kill" x y
	initializer self#init
end

class bath x y =
object (self)
	inherit button "bath" x y
	initializer self#init
end