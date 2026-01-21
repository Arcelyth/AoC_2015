import strutils, sequtils

let content = readFile("../input")
var num = content.splitLines()
del(num, num.len - 1)
let nums = num.map(parseInt) 

proc solve(i, rest: int): int =
  if rest == 0: return 1 
  if rest < 0 or i >= nums.len: return 0 
  solve(i + 1, rest - nums[i]) + solve(i + 1, rest)

echo solve(0, 150)
