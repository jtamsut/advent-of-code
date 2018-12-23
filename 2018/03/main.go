package main

import (
	"fmt"

	helpers "github.com/jtamsut/aochelpers"
	geometry "github.com/jtamsut/aochelpers/geometry"
)

func parse(s string) []geometry.Box {
	lines, err := helpers.BreakOnNewLines(s)
	boxes := make([]geometry.Box, len(lines))

	helpers.WrapError(err)

	for i, line := range lines {
		var tmpI int
		fmt.Sscanf(line, "#%d @ %d,%d: %dx%d",
			&tmpI,
			&boxes[i].LeftX,
			&boxes[i].TopY,
			&boxes[i].Width,
			&boxes[i].Height)
	}

	return boxes

}

func getArea() {
	boxes := parse("./input.txt")
	var area int
	for i, bx := range boxes {
		for j, bt := range boxes {
			if i != j {
				o, m := geometry.DetermineOverlap(bx, bt)

				if o {
					area += geometry.Area(m)
				}
			}
		}
	}
	fmt.Println(area)
}

func main() {
	getArea()
}
