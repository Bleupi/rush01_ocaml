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
(*  method storage lst =
    let rec loop lst =
      match lst with
      | (stats, value)::t -> begin
          match stats with
          | "health" -> ignore(_health <- (self#limits value)); loop t
          | "energy" -> ignore(_energy <- (self#limits value)); loop t
          | "hygiene" -> ignore(_hygiene <- (self#limits value)); loop t
          | "happyness" -> ignore(_happyness <- (self#limits value)); loop t
          | _ -> ()
        end
      | [] -> ()
    in loop lst
 *)
  method eat = begin
      (*      self#storage [("health", _health + 25); ("energy", _energy - 10); ("hygiene", _hygiene - 20); ("happyness", _happyness + 5)];*)
      {< _health = self#limits(_health + 25); _energy = self#limits(_energy - 10); _hygiene = self#limits(_hygiene - 20); _happyness = self#limits(_happyness + 5) >}
    end
  method thunder = begin
      (*      self#storage [("health", _health - 20); ("energy", _energy + 25); ("hygiene", _hygiene); ("happyness", _happyness - 20)];*)
      {< _health = self#limits(_health - 20); _energy = self#limits(_energy + 25); _hygiene = _hygiene; _happyness = self#limits(_happyness - 20) >}
    end
  method bath = begin
      (*      self#storage [("health", _health - 20); ("energy", _energy - 10); ("hygiene", _hygiene + 25); ("happyness", _happyness + 5)];*)
      {< _health = self#limits(_health - 20); _energy = self#limits(_energy - 10); _hygiene = self#limits(_hygiene + 25); _happyness = self#limits(_happyness + 5) >}
    end
  method kill = begin
      (*      self#storage [("health", _health - 20); ("energy", _energy - 10); ("hygiene", _hygiene); ("happyness", _happyness + 20)];*)
      {< _health = self#limits(_health - 20); _energy = self#limits(_energy - 10); _hygiene = _hygiene; _happyness = self#limits(_happyness + 20) >}
    end
  method sleep = begin
      (*      self#storage [("health", _health + 15); ("energy", _energy + 15); ("hygiene", _hygiene - 5); ("happyness", _happyness + 10)];*)
      {< _health = self#limits(_health + 15); _energy = self#limits(_energy + 15); _hygiene = self#limits(_hygiene - 5); _happyness = self#limits(_happyness + 10) >}
    end
  method is_alive = _health > 0 && _energy > 0 && _happyness > 0 && _hygiene > 0
end
