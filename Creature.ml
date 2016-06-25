class creature health energy hygiene happyness =
object (self)
  val _health = health
  val _energy = energy
  val _hygiene = hygiene
  val _happyness = happyness

  method get = [("health", _health); ("energy", _energy); ("hygiene", _hygiene); ("happyness", _happyness)]
  method get_actions = ["eat"; "bath"; "thunder" ; "kill"] 
  method to_string = 
    let rec print lst acc =
      match lst with
      | (stat, value)::t ->  print t (acc^ stat ^ " : " ^ (string_of_int value) ^ ", ")
      | [] -> acc
    in print self#get ""

  method limits value = if value > 100 then 100 else if value < 0 then 0 else value
  method eat = {< _health = self#limits(_health + 25); _energy = self#limits(_energy - 10); _hygiene = self#limits(_hygiene - 20); _happyness = self#limits(_happyness + 5) >}
  method thunder = {< _health = self#limits(_health - 20); _energy = self#limits(_energy + 25); _hygiene = _hygiene; _happyness = self#limits(_happyness - 20) >}
  method bath = {< _health = self#limits(_health - 20); _energy = self#limits(_energy - 10); _hygiene = self#limits(_hygiene + 25); _happyness = self#limits(_happyness + 5) >}
  method kill = {< _health = self#limits(_health - 20); _energy = self#limits(_energy - 10); _hygiene = _hygiene; _happyness = self#limits(_happyness + 20) >}
  method sleep = {< _health = self#limits(_health + 15); _energy = self#limits(_energy + 15); _hygiene = self#limits(_hygiene - 5); _happyness = self#limits(_happyness + 10) >}
  method decre_health = {< _health = self#limits(_health - 1); _energy = _energy; _hygiene = _hygiene; _happyness = _happyness >}

  method is_alive = _health > 0 && _energy > 0 && _happyness > 0 && _hygiene > 0
end
