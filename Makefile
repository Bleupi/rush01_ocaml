RESULT 			= itama
SOURCES 		= button.ml testsdl.ml
LIBS			= sdl
# INCDIRS			= +sdl
PACKS			= sdl sdl.sdlimage sdl.sdlmixer sdl.sdlttf
OCAMLMAKEFILE = OCamlMakefile 
include $(OCAMLMAKEFILE)