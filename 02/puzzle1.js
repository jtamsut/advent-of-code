const fs = require('fs')

fs.readFile('./input.txt', 'utf-8', (err, data) => {
    let pz = data.split('\n')
    pz.reduce(function(elem, accum=0) {
        let lt = elem.split('\t')
        console.log(lt)
    })
    
})

const findMax = (arr) => { 
    return arr.reduce((a, b) => {
        if (a < b) {
            return b
        } else {
            return a
        }
    })
}

const findMin = (arr) => { 
    return arr.reduce((a, b) => {
        if (a > b) {
            return b
        } else {
            return a
        }
    })
}