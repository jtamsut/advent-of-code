const fs = require('fs');
const history = [];
const checkBefore = require('./utils/checkBefore');
const redistribute = require('./utils/redistribute');

let input = [2,8,8,5,4,2,3,1,5,5,1,2,15,13,5,14];
let finish = false;
let cycles = 0;

while (!finish) {
    cycles++;
    input = redistribute(input);
    finish = checkBefore(input.join(","), history);
    history.push(input.join(","));
}

console.log(input)
console.log(cycles);
