package main

import (
	"fmt"
	"log"
	"strconv"

	"github.com/filereader"
	"github.com/pkg/errors"
)

func main() {

	vals, err := filereader.BreakOnNewLines("./input.txt")
	if err != nil {
		log.Fatal(errors.Wrap(err, "Trouble reading input."))
	}
	var frequency int64
	for _, line := range vals {
		parsed, err := strconv.ParseInt(line, 10, 64)
		if err != nil {
			log.Fatal(errors.Wrap(err, "Couldn't parse input"))
		}
		frequency += parsed
	}
	fmt.Printf("Result: %d\n", frequency)
}
