package fileReader

import (
	"io/ioutil"
	"log"

	"github.com/pkg/errors"
)

func fileReader(fileName string) string {
	file, err := ioutil.ReadFile(fileName)

	if err != nil {
		log.Fatal(errors.Wrap(err, "couldn't read input"))
	}

	return string(file)
}
