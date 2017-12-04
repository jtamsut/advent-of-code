const fs = require('fs')

fs.readFile('./input.txt', 'utf-8', (err, data) => {
    let [pz, sum] = [data.split('\n'), 0]
    pz.pop()
    pz.forEach(function(elem, accum=0) {
        let row = elem.split('\t').map(num => parseInt(num))

        sum = sum +  (Math.max(...row) - Math.min(...row)) 
    })
    console.log(sum)
})