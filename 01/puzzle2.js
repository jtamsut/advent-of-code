const fs = require('fs')
let sum = 0

fs.readFile('./day1.txt', 'utf-8', (err, data) => {
	
	let xrg = data.length/2;
	let longest = data.length-1;

	for (var i=0; i<data.length; i++) {
		let next = i + xrg;
		if (next > longest) {
			let 
		} else {
			if (data[i] === data[i + xrg]) {
				sum += parseInt(data[i])
			}	
		}
	}
	console.log(sum)
})


