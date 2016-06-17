let save_filename = "save.itama"

let save (creature : Creature.creature) : bool =
	try (
		let file = open_out save_filename in
		output_string file creature#to_string;
		close_out file;
		true
	) with
	| _ -> false

let load : (Creature.creature option) =
	try (
		None
	) with
	| _ -> None
