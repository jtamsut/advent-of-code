package geometry

import (
	"fmt"
	"testing"
)

func TestDetermineOverlap(t *testing.T) {
	box1 := Box{1, 3, 2, 2}
	box2 := Box{5, 3, 2, 2}
	box3 := Box{2, 2, 2, 2}
	t.Run("Non-overlapping boxes", testDetermineOverlapFunc(box1, box2, false, Box{}))
	t.Run("Overlapping boxes", testDetermineOverlapFunc(box1, box3, true, Box{2, 3, 1, 1}))
	t.Run("Box should overlap with itself", testDetermineOverlapFunc(box1, box1, true, box1))
}

func testDetermineOverlapFunc(a Box, b Box, overlap bool, overlapBox Box) func(*testing.T) {
	return func(t *testing.T) {
		o, Ob := DetermineOverlap(a, b)
		if o == overlap {
			if overlapBox.leftX == Ob.leftX && overlapBox.topY == Ob.topY {
				if overlapBox.width == Ob.width && overlapBox.height == Ob.height {
					return
				}
			}
		}
		t.Error(fmt.Sprintf("Box: %v and Box: %v should have overlap of %v but instead have overlap box of %v", a, b, overlapBox, Ob))
	}
}
