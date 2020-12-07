require 'pry'

class GroupCounter
  def initialize(file_path)
    @file_path = file_path
    @yeses = 0
  end

  def call
    @all_groups = []

    File.foreach(@file_path).each do |line|
      @current_line = line

      if empty_line?
        @all_groups = []
      end

      @yeses += new_groups.count

      @all_groups = @all_groups.concat(new_groups)
    end

    puts "The number of yes's from every group is #{@yeses}"
  end

  private

  def new_groups
    additional_groups = @current_line
      .delete("\n")
      .split('')
      .uniq

    additional_groups - @all_groups
  end

  def empty_line?
    @current_line == "\n"
  end
end

GroupCounter.new('./input.txt').call
# GroupCounter.new('./sample.txt').call
