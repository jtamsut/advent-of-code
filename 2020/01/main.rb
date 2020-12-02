DIFFERENCE = {}

NUM_LIST = File
  .readlines('./input.txt')
  .map{ |e| e.delete!("\n") }
  .map(&:to_i)

def generate_difference
  NUM_LIST.each_with_index do |num, index|
    DIFFERENCE[2020-num] = index
  end
end

def find_doubles
  NUM_LIST.each do |num|
    idx = DIFFERENCE[num]

    if !idx.nil? 
      puts "#{num} and #{NUM_LIST[idx]} add up to 2020"
      puts "and multiple to #{num * NUM_LIST[idx]}"
      return
    end
  end
end

def find_triples
  NUM_LIST.each_with_index do |a, i|
    NUM_LIST.each_with_index do |b, j|
      idx = DIFFERENCE[a + b]

      if i != j && j != idx

        if !idx.nil?
          p [a, b, NUM_LIST[idx]].sort
          p a * b * NUM_LIST[idx]
        end
      end
    end
  end
end

generate_difference
find_triples
