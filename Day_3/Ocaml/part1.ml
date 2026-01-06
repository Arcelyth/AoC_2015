let file = "../input"

module PosSet = Set.Make(struct
  type t = int * int  
  let compare = compare
end)
  
let rec delivering s i pos_x pos_y visited = 
  if i >= String.length s then
    visited 
  else
    let c = String.get s i in
      let new_x, new_y = 
        match c with 
        | '^' -> pos_x, pos_y + 1
        | 'v' -> pos_x, pos_y - 1
        | '<' -> pos_x - 1, pos_y
        | '>' -> pos_x + 1, pos_y 
        | _ -> pos_x, pos_y
      in delivering s (i + 1) new_x new_y (PosSet.add (new_x, new_y) visited)
  
let () = 
  let ic = open_in file in
    try
      let line = input_line ic in        
        close_in ic;
        let visited = (0, 0) |> PosSet.singleton |> delivering line 0 0 0 in
        print_int (PosSet.cardinal visited);
    with e ->
      close_in_noerr ic;
      raise e


