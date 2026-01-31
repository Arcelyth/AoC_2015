string path = "../input";

List<long> weights = (
    from line in File.ReadAllLines(path)
    let trimmed = line.Trim()
    where !string.IsNullOrEmpty(trimmed)
    let parsed = long.Parse(trimmed)
    orderby parsed descending
    select parsed
).ToList();

long sum = weights.Sum();
long targetW = sum / 3;

for (int count = 1; count <= weights.Count; count++) {
    List<long> qe = new List<long>();
    solve(weights, targetW, count, 0, 1, 0, qe);
    if (qe.Count > 0) {
        Console.WriteLine($"QE: {qe.Min()}");
        break;
    }
}

void solve(List<long> w, long target, int rest, int idx, long curQe, long acc, List<long> qe) {
    if (acc > target) return;
    if (rest == 0)  {
        if (acc == target) {
            qe.Add(curQe);
        }
        return;
    }
    for (int i = idx; i < w.Count; i++) {
        solve(w, target, rest - 1, i + 1, curQe * w[i], acc + w[i], qe);
    }
}
