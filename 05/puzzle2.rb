lines = File.open('./input.txt').readlines
offsets = []
steps = 0

# Pre-process line
lines.each { |line| offsets << line.to_i }
	
num_offsets = offsets.length
addr = 0

while addr < num_offsets
    jmps = offsets[addr]
    jmps >= 3 ? offsets[addr] -= 1 : offsets[addr] += 1
	addr += jmps
	steps += 1
end

puts steps