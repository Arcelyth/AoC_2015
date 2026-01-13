package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

ans := 10000000
adj: map[string]map[string]int

main :: proc() {    
    path := "../input"

    adj = make(map[string]map[string]int)
    data, ok := os.read_entire_file(path, context.allocator)
    defer delete (data, context.allocator)
    if !ok {
        fmt.eprintf("Error reading file: %s \n", path)
        return 
    }

    contents := string(data)
    for line in strings.split_lines_iterator(&contents) {
        w := strings.split(line, " ")
        val, ok := strconv.parse_int(w[4])
        if !ok {
            fmt.eprint("Error parsing int")
            return 
        }
        if !(w[0] in adj) do adj[w[0]] = make(map[string]int)
        if !(w[2] in adj) do adj[w[2]] = make(map[string]int)
        m0 := adj[w[0]]
        m0[w[2]] = val
        adj[w[0]] = m0

        m2 := adj[w[2]]
        m2[w[0]] = val
        adj[w[2]] = m2
    }

    visited := make(map[string]bool)
    for city in adj {
        visited[city] = true
        dfs(city, 0, 1, &visited)
        visited = make(map[string]bool)
    }

    fmt.println(ans)
}

dfs :: proc(curr: string, cost: int, count: int, visited: ^map[string]bool) {
    if cost >= ans do return
    if count == len(adj) {
        ans = cost 
        return
    }

    for next, dist in adj[curr] {
        if !visited[next]{
            visited[next] = true
            dfs(next, cost + dist, count + 1, visited)
            visited[next] = false
        }
    }
}
