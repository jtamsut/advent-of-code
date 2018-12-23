// package main

// import (
// 	"fmt"

// 	helpers "github.com/jtamsut/aochelpers"
// )

// type box struct {
// 	topX, topY, width, height int
// }

// func parse(s string) []box {
// 	lines, err := helpers.BreakOnNewLines(s)
// 	boxes := make([]box, len(lines))

// 	helpers.WrapError(err)

// 	for i, line := range l ines {
// 		var tmpI int
// 		fmt.Sscanf(line, "#%d @ %d,%d: %dx%d",
// 			&tmpI,
// 			&boxes[i].topX,
// 			&boxes[i].topY,
// 			&boxes[i].width,
// 			&boxes[i].height)
// 	}

// 	return boxes

// }

// // TODO: Write a consolidation algorithm that will take a slice of boxes and simplify them down to the smallest slice possible

// func mergeBoxes() {
// 	// will return a slice of []box
// }

// func main() {
// 	boxes := parse("input.txt")
// 	for _, i := range boxes {
// 		o, b := compareTwoPoints(i, i)
// 		fmt.Println(i)
// 		fmt.Println(o)
// 		fmt.Println(b)
// 		fmt.Println("---")
// 	}
// }
