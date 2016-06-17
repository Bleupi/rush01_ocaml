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
	let is_good x = (
		if x >= 0 && x <= 100 then true
		else false
	) in

	try (
		let file = open_in save_filename in
		let data = input_line file in
		close_in file;
		let parsed_values = Str.split (Str.regexp " : \\| ") data in
		if List.length parsed_values <> 8 then None
		else (
			let health = int_of_string @@ List.nth parsed_values 1 in
			let energy = int_of_string @@ List.nth parsed_values 3 in
			let hygiene = int_of_string @@ List.nth parsed_values 5 in
			let happyness = int_of_string @@ List.nth parsed_values 7 in
			if is_good health && is_good energy && is_good hygiene && is_good happyness then
			Some (new Creature.creature health energy hygiene happyness)
			else None
		)
	) with
	| _ -> None
