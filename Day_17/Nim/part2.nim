import strutils, sequtils

let content = readFile("../input")
var num = content.splitLines()
del(num, num.len - 1)
let nums = num.map(parseInt) 
var minLen = 100
var counts: seq[int] = @[]

proc solve(idx, rest, count: int) =
  if rest == 0:
    if count < minLen:
      minLen = count
    counts.add(count)
    return

  if rest < 0 or idx >= nums.len:
    return
  solve(idx + 1, rest - nums[idx], count + 1)
  solve(idx + 1, rest, count)

solve(0, 150, 0)

echo counts.filter(proc(x: int): bool = x == minLen).len
