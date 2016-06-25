RESULT = test
SOURCES = Creature.ml Display.ml save.ml main_loop.ml
LIBS = sdl
INCDIRS = +sdl
PACKS = sdl.sdlimage sdl.sdlmixer sdl.sdlttf sdl
OCAMLMAKEFILE = OCamlMakefile
THREADS =  yes
include $(OCAMLMAKEFILE)
