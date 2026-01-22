import Foundation

let path = "../input"
let url = URL(fileURLWithPath: path)
var lights : [[Character]] = []

do {
    let padding = [Character](repeating: ".", count: 102)
    lights.append(padding)
    for try await line in url.lines {
        lights.append("." + Array(line) + ".")
        if line == "STOP" { break }
    }
    lights.append(padding)
} catch {
    print("\(error)")
}
lights[1][1] = "#"
lights[1][100] = "#"
lights[100][1] = "#"
lights[100][100] = "#"

for _ in 1...100 {
    var newLights = lights 
    for i in 1...100 {
        for j in 1...100 {
            let neighbors = countOn(x: i, y: j)
            if lights[i][j] == "#" {
                if neighbors != 2 && neighbors != 3 && !isCorner(x: i, y: j){
                    newLights[i][j] = "."
                }
            } else {
                if neighbors == 3 {
                    newLights[i][j] = "#"
                }
            }
        }
    }
    lights = newLights
}

func isCorner(x: Int, y: Int) -> Bool {
    return (x == 1 && y == 1)
        || (x == 1 && y == 100)
        || (x == 100 && y == 1)
        || (x == 100 && y == 100)
}

func countOn(x: Int, y: Int) -> Int {
    var count = 0
    for i in -1...1{
        for j in -1...1{
            if i == 0 && j == 0 { continue }
            if lights[x+i][y+j] == "#" {
                count += 1
            }
        }
    }
    return count
}

var ans = 0
for i in 1...100 {
    ans += lights[i].filter { $0 == "#" }.count
}
print(ans)

