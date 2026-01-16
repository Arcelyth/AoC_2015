let
  input = builtins.readFile ../input;
  regex = "(-?[0-9]+)";
  raw = builtins.split regex input;
  l = builtins.concatMap (x: if builtins.isList x then x else []) raw;
  numL = builtins.map builtins.fromJSON l;
in
  builtins.foldl' (acc: x: acc + x) 0 numL
