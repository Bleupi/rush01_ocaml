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
		let file = open_in save_filename in
		let data = input_line file in
		close_in file;
		let parsed_values = Str.split (Str.regexp " : \\| ") data in
		Some (new Creature.creature (int_of_string @@ List.nth parsed_values 1) (* health *)
			(int_of_string @@ List.nth parsed_values 3) (* energy *)
			(int_of_string @@ List.nth parsed_values 5) (* hygiene *)
			(int_of_string @@ List.nth parsed_values 7) (* happyness *)
		)
	) with
	| _ -> None
