package main

import (
	"fmt"

	helpers "github.com/jtamsut/aochelpers"
)

type box struct {
	topX, topY, width, height int
}

func compareTwoPoints(p box, m box) (bool, box) {
	leftX := helpers.Max(p.topX, m.topX)
	rightX := helpers.Min(p.topX+p.width, m.topX+m.width)
	bottomY := helpers.Max(p.topY-p.height, m.topY-m.height)
	topY := helpers.Min(p.topY, m.topY)
	var boxWidth, boxHeight int

	if rightX > leftX {
		boxWidth = rightX - leftX
	}

	if topY > bottomY {
		boxHeight = topY - bottomY
	}

	// return true, empty box if no overlap
	if boxHeight*boxWidth == 0 {
		return true, box{}
	}

	// if overlap, return false and resulting overlapping box
	return false, box{
		topX:   leftX,
		topY:   topY,
		width:  boxWidth,
		height: boxHeight,
	}
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
	boxes := parse("input.txt")
	for _, i := range boxes {
		o, b := compareTwoPoints(i, i)
		fmt.Println(i)
		fmt.Println(o)
		fmt.Println(b)
		fmt.Println("---")
	}
}
