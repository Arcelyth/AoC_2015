package main

import (
	"crypto/md5"
	"fmt"
	"strconv"
)

func main() {
	secret := "yzbqklnj"
	limit := 10000000
	// part1
	fmt.Println("===== part1 =====")
	var i = 0
	for {
		data := []byte(secret + strconv.Itoa(i))
		hash := fmt.Sprintf("%x", md5.Sum(data))
		head5 := hash[:5]
		if head5 == "00000" || i > limit {
			fmt.Println("hash:", hash)
			fmt.Println("number:", i)
			break
		}
		i += 1
	}

	// part2
	fmt.Println("===== part2 =====")
	var j = 0
	for {
		data := []byte(secret + strconv.Itoa(j))
		hash := fmt.Sprintf("%x", md5.Sum(data))
		head6 := hash[:6]
		if head6 == "000000" || j > limit {
			fmt.Println("hash:", hash)
			fmt.Println("number:", j)
			break
		}
		j += 1
	}
}
