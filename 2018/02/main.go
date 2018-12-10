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

// returns true, true if 2 and 3 occurrences
func doubleOrTriple(j map[string]int) (bool, bool) {
	i := false
	o := false
	for _, v := range j {
		if v == 2 {
			i = true
		}

		if v == 3 {
			o = true
		}
	}
	return i, o
}

func main() {
	ids, err := helpers.BreakOnNewLines("./input.txt")

	if err != nil {
		helpers.WrapError(err)
	}
	twos := 0
	threes := 0
	for _, line := range ids {
		w, x := doubleOrTriple(frequencies(line))
		if w == true {
			twos += 1
		}
		if x == true {
			threes += 1
		}
	}

	fmt.Printf("Part 1: %d\n", twos*threes)
}
