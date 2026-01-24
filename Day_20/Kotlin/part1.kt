fun main() {
    val target = 3310000 
    val maxHouse = target
    val houses = IntArray(maxHouse + 1)

    for (elf in 1..maxHouse) {
        for (house in elf..maxHouse step elf) {
            houses[house] += elf
        }
    }

    for (i in 1..maxHouse) {
        if (houses[i] >= target) {
            println("Found house: $i")
            break
        }
    }
}
