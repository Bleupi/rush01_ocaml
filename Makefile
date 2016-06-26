RESULT 			= itama
SOURCES 		= button.ml State.ml Creature.ml testsdl.ml main_loop.ml
LIBS			= sdl
# INCDIRS			= +sdl
THREADS =  yes
PACKS			= sdl sdl.sdlimage sdl.sdlmixer sdl.sdlttf
OCAMLMAKEFILE = OCamlMakefile 
include $(OCAMLMAKEFILE)
