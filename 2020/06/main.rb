require 'pry'

class GroupCounter
  def initialize(file_path)
    @file_path = file_path
    @yeses = 0
    @unanimous = 0
  end

  def call
    @all_groups = []
    @groups = []
    @group = {}

    File.foreach(@file_path).with_index do |line, index|
      @current_line = line

      if empty_line?
        @groups << @group
        @all_groups = []
        @group = {}
      end

      @yeses += new_groups.count

      @group["member#{index}"] = current_line_yeses unless empty_line?

      @all_groups = @all_groups.concat(new_groups)
    end

    @groups << @group

    count_common

    puts "The number of yes's from every group is #{@yeses}"
    puts "The number of unanimous yes's is #{@unanimous}"
  end

  private

  def count_common
    @groups.each do |group|
      gather_all(group).each do |element|
        @unanimous += 1 if element_in_all_groups?(element, group)
      end
    end
  end

  def gather_all(group)
    all_codes = []
    group.values.each do |value|
      all_codes << value
      all_codes.flatten!
    end

    all_codes.uniq
  end

  def element_in_all_groups?(element, group)
    group.values.each do |value|
      return false unless value.include?(element)
    end

    true
  end

  def current_line_yeses
    @current_line.delete("\n").split('').sort
  end

  def new_groups
    additional_groups = current_line_yeses.uniq

    additional_groups - @all_groups
  end

  def empty_line?
    @current_line == "\n"
  end
end

GroupCounter.new('./input.txt').call
