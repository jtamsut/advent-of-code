const odds = []
let prime = 1

while (odds.length < 560) {
	odds.push(prime)
	prime += 2
}

console.log(odds[odds.length-1])	
