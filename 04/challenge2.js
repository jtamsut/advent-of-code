const fs = require('fs')
const dups = require('./challenge1')

fs.readFile('./input.txt', 'utf-8', function(err, data) {
    [sum, rows] = [0, data.split('\n')]
    rows.pop()
    rows.forEach(function(row){
        let sortedRow = row.split(' ').map(word => word.split('').sort().join(''))
        console.log(sortedRow)
        dups(sortedRow) ? null : sum = sum + 1
    })   
    console.log(`Anagrams are ${sum}`)    
})

