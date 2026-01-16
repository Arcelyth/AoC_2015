let 
  input = builtins.readFile ../input;
  json = builtins.fromJSON input;
  sumNum = val:
    if builtins.isInt val then
      val
    else if builtins.isList val then
      builtins.foldl' (acc: x: acc + sumNum(x)) 0 val
    else if builtins.isAttrs val then
      let 
        values = builtins.attrValues val;
        hasRed = builtins.any (v: v == "red") values;
      in 
        if hasRed then
          0
        else 
          builtins.foldl' (acc: x: acc + sumNum(x)) 0 values
    else 0;
in
  sumNum json

