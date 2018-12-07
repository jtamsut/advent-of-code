package main

import (
	"fmt"

	"github.com/jtamsut/aochelpers"
)

func run(input string) int64 {
	list := helpers.ParseIntList("./input.txt")
	return helpers.Sum(list...)
}
func main() {
	fmt.Printf("Result: %d\n", run("./input.txt"))
}
