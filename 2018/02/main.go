package main

import (
	"fmt"

	helpers "github.com/jtamsut/aochelpers"
)

func frequencies(str string) map[string]int {
	m := make(map[string]int)
	for _, c := range str {
		g := string(c)
		m[g]++
	}
	return m
}

func main() {
	ids, err := helpers.BreakOnNewLines("./input.txt")

	if err != nil {
		helpers.WrapError(err)
	}

	for _, line := range ids {
		fmt.Println(frequencies(line))
	}
}
