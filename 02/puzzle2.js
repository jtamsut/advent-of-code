const fs = require('fs')

fs.readFile('./input.txt', 'utf-8', (err, data) => {
    let [pz, sum] = [data.split('\n'), 0]
    pz.pop()
    pz.forEach(function(elem, accum=0) {
        let row = elem.split('\t').map(num => parseInt(num))
        sum += nestFor(row)
    })
    console.log(sum)
})

function nestFor(row) {
    for (let i=0; i<row.length; i++) {
        let current = row[i]
        for (let j=i+1; j<row.length; j++) {
            let [mod1, mod2] = [current % row[j], row[j] % current]
            if (!mod1 || !mod2) {
                let div = mod1 === 0 ? current/row[j] : row[j]/current
                return div 
            }
        }
    }
}

