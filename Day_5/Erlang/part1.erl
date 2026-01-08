-module(part1).
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
  (count_vowels(Word) >= 3) andalso has_double(Word) andalso not has_invalid(Word).

count_vowels(Word) -> 
  Vowels = "aeiou",
  lists:foldl(fun(C, Acc) -> 
                case lists:member(C, Vowels) of 
                  true -> Acc + 1;
                  false -> Acc
                end 
              end, 0, Word).
  
has_double(L) -> has_double(L, none).
has_double([], _) -> false;
has_double([H|_], H) -> true;
has_double([H|T], _) -> has_double(T, H).

has_invalid(Word) ->
  Invalids = ["ab", "cd", "pq", "xy"],
  lists:any(fun(Inv) -> 
              string:str(Word, Inv) =/= 0
            end, Invalids).
  
