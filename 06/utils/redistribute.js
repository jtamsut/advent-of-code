function redistribute(input) {
    let maxBlocks = Math.max(...input);
    let maxIdx = input.indexOf(maxBlocks);
    let currentIdx = maxIdx + 1;
    let largestIdx = input.length-1;
    input[maxIdx] = 0;
    
    while (maxBlocks > 0) {
        currentIdx = currentIdx > largestIdx ? 0 : currentIdx;
        input[currentIdx] = input[currentIdx] + 1;
        currentIdx++;
        maxBlocks--;
    }
    return input;
}

module.exports = redistribute;