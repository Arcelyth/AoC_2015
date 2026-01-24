fun main() {
    val target = 33100000 
    val maxHouse = target
    val houses = IntArray(maxHouse + 1)

    for (elf in 1..maxHouse) {
        for (house in elf..minOf(elf*50, maxHouse) step elf) {
            houses[house] += elf * 11
        }
    }

    for (i in 1..maxHouse) {
        if (houses[i] >= target) {
            println("Found house: $i")
            break
        }
    }
}
