const fs = require('fs');
const history = [];

let input = [2,8,8,5,4,2,3,1,5,5,1,2,15,13,5,14];
let finish = false;
let cycles = 0;

/*
    Utility functions: redistribute & checkBefore

*/

function redistribute(mem) {
    let maxBlocks = Math.max(...input);
    let maxIdx = input.indexOf(maxBlocks);
    mem[maxIdx] = 0;
    let currentIdx = maxIdx + 1;
    
    while (maxBlocks > 0) {
        currentIdx = currentIdx > 15 ? 0 : currentIdx;
        mem[currentIdx] = mem[currentIdx] + 1;
        currentIdx++;
        maxBlocks--;
    }
    
    return mem;
}

const checkBefore = (newSequence, olds) => olds.includes(newSequence);

/*

    Redistributing and checking

*/

while (!finish) {
    cycles++;
    newInput = redistribute(input).join(",");
    finish = checkBefore(newInput, history);
    history.push(newInput);
}

console.log(cycles)
