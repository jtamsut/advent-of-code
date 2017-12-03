const fs = require('fs')
let sum = 0

fs.readFile('./captcha.txt', 'utf-8', (err, data) => {
	let [half, end] = [(data.length/2), (data.length-1)];
	let [firstHalf, secondHalf] = [data.slice(0, half).split(""), data.slice(half, end).split("")];
	let sum = 0
	
	firstHalf.forEach(function(elem, index) {
		sum = elem === secondHalf[index] ? sum + (2 * elem) : sum
	});

	console.log(sum)

})


