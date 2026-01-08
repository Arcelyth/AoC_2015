-module(part2).
-export([nice_string/0]).

nice_string() -> 
  {ok, Device} = file:open("../input", [read]),
  Sum = handle_lines(Device, 0),
  io:format("~p~n", [Sum]).

handle_lines(Device, Acc) -> 
  Line1 = io:get_line(Device, ''),
  case Line1 of  
    eof -> 
      file:close(Device),
      Acc;
    Line -> 
      NewAcc = case handle_word(Line) of 
                 true -> Acc + 1;
                 false -> Acc
               end,
      handle_lines(Device, NewAcc)
  end.

handle_word(Word) -> 
  has_pair(Word) andalso has_between(Word).

has_pair([]) -> false;
has_pair([_]) -> false;
has_pair([A, B | T]) -> case string:str(T, [A, B]) of 
                          0 -> has_pair([B | T]);
                          _ -> true
                        end.

has_between([]) -> false;
has_between([A ,_ , A | _]) -> true;
has_between([_ | T]) -> has_between(T).


