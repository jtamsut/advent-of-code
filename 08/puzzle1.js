const fs = require('fs');

fs.readFile('./input.txt', 'utf-8', function(err, line) {
    let lines = line.split('\n');
    let registers = {};

    lines.forEach((line) => {
        if (line !== '') {
            registers[line.split(" ")[0]] = 0;
        }
    })

    console.log(registers);
})