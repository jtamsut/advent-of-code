package geometry

import helpers "github.com/jtamsut/aochelpers"

// Box ... represents the coordinates of a box
type Box struct {
	leftX, topY, width, height int
}

// DetermineOverlap ... determines if there is an overlap between two boxes
func DetermineOverlap(p Box, m Box) (bool, Box) {
	lX := helpers.Max(p.leftX, m.leftX)
	rX := helpers.Min(p.leftX+p.width, m.leftX+m.width)
	bY := helpers.Max(p.topY-p.height, m.topY-m.height)
	tY := helpers.Min(p.topY, m.topY)
	var boxWidth, boxHeight int

	if rX > lX {
		boxWidth = rX - lX
	}

	if tY > bY {
		boxHeight = tY - bY
	}

	// return true, empty box if no overlap
	if boxHeight*boxWidth == 0 {
		return false, Box{}
	}

	// if overlap, return false and resulting overlapping box
	return true, Box{
		leftX:  lX,
		topY:   tY,
		width:  boxWidth,
		height: boxHeight,
	}
}
