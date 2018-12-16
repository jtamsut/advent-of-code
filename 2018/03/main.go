package main

import (
	"fmt"

	helpers "github.com/jtamsut/aochelpers"
)

type box struct {
	topX, topY, width, height int
}

func parse(s string) []box {
	lines, err := helpers.BreakOnNewLines(s)
	boxes := make([]box, len(lines))

	helpers.WrapError(err)

	for i, line := range lines {
		var tmpI int
		fmt.Sscanf(line, "#%d @ %d,%d: %dx%d",
			&tmpI,
			&boxes[i].topX,
			&boxes[i].topY,
			&boxes[i].width,
			&boxes[i].height)
	}

	return boxes

}

func main() {
	fmt.Println(parse("input2.txt"))
}

// func main() {
// 	var boxes []Box

// 	for _, x := range line {
// 		g := strings.Split(x, "@")
// 		j := strings.Split(g[1], ":")
// 		i := strings.Split(j[0], ",")
// 		b := strings.Split(j[1], "x")

// 		tX, _ := strconv.Atoi(i[0])
// 		tY, _ := strconv.Atoi(i[1])
// 		wi, _ := strconv.Atoi(b[0])
// 		he, _ := strconv.Atoi(b[1])

// 		fmt.Println(tX)

// 		z := Box{
// 			topX:   tX,
// 			topY:   tY,
// 			width:  wi,
// 			height: he,
// 		}

// 		boxes = append(boxes, z)
// 	}

// 	// fmt.Println(boxes)
// }
