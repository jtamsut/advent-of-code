const fs = require('fs')
let sum = 0

fs.readFile('./input.txt', 'utf-8', (err, data) => {

	for (var i=0; i<data.length; i++) {
		if (data[i] === data[i + 1]) {
			sum += parseInt(data[i])
		}	
	}

	if (data[0] === data[data.length-1]) {
		sum += parseInt(data[0])
	}

	console.log(sum)
})


