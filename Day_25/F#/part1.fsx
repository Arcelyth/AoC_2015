open System.Text.RegularExpressions

let input = @"To continue, please consult the code grid in the manual. Enter the code at row 2947, column 3029."

let rx = Regex(@".+ row (\d+).+column (\d+)\.", RegexOptions.Compiled)
let m = rx.Match(input)

let rec modPow (baseNum: int64) (exp: int64) (m: int64) : int64 =
    if exp = 0L then 1L
    else
        let half = modPow baseNum (exp / 2L) m
        let res = (half * half) % m
        if exp % 2L = 1L then (res * (baseNum % m)) % m
        else res

if m.Success then
    let r = int64 m.Groups.[1].Value
    let c = int64 m.Groups.[2].Value
    
    let n = ((r + c - 2L) * (r + c - 1L) / 2L) + c
    
    let start = 20151125L
    let multi = 252533L
    let modi = 33554393L
    
    let result = (start * modPow multi (n - 1L) modi) % modi
    
    printfn "Code: %d" result
else
    printfn "Failed to match the text"
