import System.IO

main::IO ()
main = do 
  hd <- openFile "../input" ReadMode
  contents <- hGetContents hd
  let inst = foldl (\acc c -> case c of 
                    '(' -> acc + 1 
                    ')' -> acc -1 
                    other -> acc ) 0 contents
  -- output the answer of part 1 
  print $ show inst

  let instList = scanl (\acc c -> case c of 
                    '(' -> acc + 1 
                    ')' -> acc -1 
                    other -> acc ) 0 contents
  -- output the answer of part 2
  print $ head[i | (x, i) <- zip instList [0..], x == -1]
  hClose hd
  


