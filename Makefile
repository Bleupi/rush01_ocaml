RESULT 			= itama
SOURCES 		= testsdl.ml
LIBS			= sdl
INCDIRS			= +sdl
PACKS			= sdl.sdlimage sdl.sdlmixer sdl.sdlttf sdl
OCAMLMAKEFILE = OCamlMakefile 
include $(OCAMLMAKEFILE)