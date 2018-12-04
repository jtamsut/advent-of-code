package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"strconv"
)

func main() {
	sum := 0
	num := "xa"
	file, _ := ioutil.ReadFile("input.txt")
	str := string(file)
	t := strings.Split(str, "\n")
	t = t[:len(t)-1]

	for _, val := range t {
		op := string(val[0]); 
		if op == "+" {
			num = strings.Replace(string(val), "+", "", -1)
			numPlus, _ := strconv.Atoi(num)
			sum += numPlus

		} else {
			num = strings.Replace(string(val), "-", "", -1)
			numMinus, _ := strconv.Atoi(num)
			sum -= numMinus
		}
	}
	fmt.Println(sum)
}