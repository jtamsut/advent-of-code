const fs = require('fs')

fs.readFile('./input.txt', 'utf-8', (err, data) => {
    [sum, rows] = [0, data.split('\n')]
    rows.forEach(row => areDuplicates(row.split(' ')) ? null : sum = sum + 1)
    console.log(sum-1)
})


// Utility function for determining if their are duplicates in an array
function areDuplicates(arr) {
    for (let index=0; index<arr.length-1; index++) {
        let current = arr[index]
        for (let j=index+1; j<arr.length; j++) {
            if (current === arr[j]) {
                return true
            }
        }
    }
    return false
}