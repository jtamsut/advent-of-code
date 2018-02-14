const fs = require('fs')

fs.readFile('./input.txt', 'utf-8', function(err, data) {
	if (err) throw err;
	let topArrays = data.split('\n').filter(line => line.includes('->'));
	
	for (let i=0; i<topArrays.length; i++) {
		
		let memoryNames = /([a-z]+)\s/g;
		let string = memoryNames.exec(topArrays[i])[0];
		
		for (let j=i+1; j<topArrays.length; j++) {


			let children = /->\s(.)+/g;
			let childrenString = children.exec(topArrays[j]);
			
			if (childrenString.includes(string)) {
				console.log(string);
				
			}
		}
	}
})



/* 

Notes:
- What do the weights correspond to?

*/