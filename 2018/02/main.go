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

// Given two strings will return true if only char is different; false otherwise
func sameExceptOne(f, s string) bool {
	diff := 0
	for i, c := range f {
		iString := string(s[i])
		cString := string(c)

		if iString != cString {
			diff++
		}

		if diff > 1 {
			return false
		}

	}

	if diff == 1 {
		return true
	}

	return false
}

func compare() (string, string) {
	ids, _ := helpers.BreakOnNewLines("./input.txt")

	for _, a := range ids {
		for _, b := range ids {
			strA := string(a)
			strB := string(b)

			if sameExceptOne(strA, strB) {
				return strA, strB
			}
		}
	}
	return "None", "None"
}

func removeNonUniques(a, b string) string {
	u := ""
	for i, g := range a {
		if string(b[i]) == string(g) {
			u += string(g)
		}
	}
	return u
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
			twos++
		}
		if x == true {
			threes++
		}
	}
	l, q := compare()
	fmt.Println(l)
	fmt.Println(q)
	fmt.Printf("Part 1: %d\n", twos*threes)
	fmt.Printf("Part 2: %s\n", removeNonUniques(l, q))
}
