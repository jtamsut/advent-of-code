const redistribute = require('./utils/redistribute');
let input = [ 0, 13, 12, 10, 9, 8, 7, 5, 3, 2, 1, 1, 1, 10, 6, 5 ];
let finish = false;
let cycles = 0;
const desiredInput = input.join(",");


while (!finish) {
    cycles++;
    input = redistribute(input);
    finish = (input.join(",") === desiredInput);
}

console.log(cycles);
