package main

import (
	"fmt"

	"github.com/jtamsut/aochelpers"
)

func add(input string) int64 {
	list := helpers.ParseIntList("./input.txt")
	return helpers.Sum(list...)
}

func freq(input string) int64 {
	list := helpers.ParseIntList("./input.txt")
	frequencyMap := map[int64]bool{0: true}
	var sum int64

	for {
		for _, num := range list {
			sum += num
			_, exist := frequencyMap[sum]
			fmt.Println(frequencyMap)
			if exist {
				return sum
			}
			frequencyMap[sum] = struct{}{}
		}
	}
}

func main() {
	fmt.Printf("Result: %d\n", add("./input.txt"))
	freq("./input.txt")
}
