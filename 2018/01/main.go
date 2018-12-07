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
	frequencyMap := make(map[int64]bool)
	var sum int64

	for {
		for _, num := range list {
			sum += num
			if frequencyMap[sum] {
				return sum
			}
			frequencyMap[sum] = true
		}
	}
}

func main() {
	fmt.Printf("Result for Part 1: %d\n", add("./input.txt"))
	fmt.Printf("Result for Part 2: %d\n", freq("./input.txt"))
}
