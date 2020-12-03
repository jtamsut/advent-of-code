require 'pry'

class TreeHitCounter
  def initialize(file_path, right, down = 1) 
    @file_path = file_path
    @trees_hit = 0
    @right = right
    @current_line_number = 0
    @current_line = nil
    @offset = 0
    @down = down
  end


  def call
    File.foreach(@file_path).with_index do |line, line_num|
      if @down != 1
        next if line_num % 2 != 0
      end

      @current_line_number = line_num
      @current_line = line

      if hit_tree?
        log_tree_hit
        @trees_hit += 1
      end

      update_offset
    end

    @trees_hit
  end

  private

  def update_offset
    @offset = (@offset + @right) % 31
  end

  def log_tree_hit
    puts "Line(#{@current_line_number+1}): Offset(#{@offset}): #{curr_cell}"
  end

  def curr_cell
    @current_line[@offset]
  end

  def hit_tree?
    curr_cell == '#'
  end
end


a = TreeHitCounter.new('./input.txt', 1).call
b = TreeHitCounter.new('./input.txt', 3).call
c = TreeHitCounter.new('./input.txt', 5).call
d = TreeHitCounter.new('./input.txt', 7).call
e = TreeHitCounter.new('./input.txt', 1, 2).call

puts "#{'=' * 50}"
puts "Total: #{a * b * c * d * e}"
puts "#{'=' * 50}"
