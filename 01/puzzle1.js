const fs = require('fs')
let sum = 0

fs.readFile('./day1.txt', 'utf-8', (err, data) => {
	let xrg = data.length/2

	for (var i=0; i<data.length; i++) {
		if (data[i] === data[i + xrg]) {
			sum += parseInt(data[i])
		}	
	}

	if (data[0] === data[data.length-1]) {
		sum += parseInt(data[0])
	}

	console.log(sum)
})


