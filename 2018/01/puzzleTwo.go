// package main

// import (
// 	"log"
// 	"strconv"

// 	"github.com/filereader"
// 	"github.com/pkg/errors"
// )

// func main() {
// 	vals, err := filereader.BreakOnNewLines("./input.txt")

// 	if err != nil {
// 		log.Fatal(errors.Wrap(err, "Error reading input"))
// 	}

// 	for {
// 		for _, line := range vals {
// 			newVal, err := strconv.ParseInt(line, 10, 64)
// 			if err != nil {
// 				log.Fatal(errors.Wrap(err, "Could not parse"))
// 			}

// 		}
// 	}
// }
