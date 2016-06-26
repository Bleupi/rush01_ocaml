RESULT 			= itama
SOURCES 		= Init.ml button.ml State.ml Creature.ml Display.ml save.ml main_loop.ml
LIBS			= sdl str
# INCDIRS			= +sdl
THREADS =  yes
PACKS			= sdl sdl.sdlimage sdl.sdlmixer sdl.sdlttf
OCAMLMAKEFILE = OCamlMakefile 
include $(OCAMLMAKEFILE)
