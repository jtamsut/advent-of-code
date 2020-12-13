# frozen_string_literal: true
require 'pry'

require_relative './../utils/file_loader.rb'

class SumFinder < FileLoader
  def initialize(file_path)
    super(file_path)
  end

  def call
    @numbers = []
    each_line { @numbers << @current_line.to_i }
    @target = incorrect_num

    range_sum
  end

  private

  def range_sum
    @numbers.each_with_index do |_, idx|
      final_idx = idx

      while (sum(idx, final_idx) < @target) && (final_idx < @numbers.length)
        final_idx += 1

        if sum(idx, final_idx) == @target
          range = @numbers[idx..final_idx]

          puts range.min + range.max
          return
        end
      end
    end
  end

  def sum(start, finish)
    @numbers[start..finish].inject(0, :+)
  end

  def incorrect_num
    @numbers.each_with_index do |num, idx|
      if idx > 24
        prev = preamble(idx)

        if !two_num_sum(prev, num)
          return num
        end
      end
    end

  end

  def preamble(idx)
    start = idx - 25
    end_pos = idx - 1

    @numbers[start..end_pos]
  end

  def two_num_sum(nums, num)
    differences = {}

    nums.each_with_index do |curr_num, idx|
      diff = num - curr_num

      differences[diff] = idx if diff.positive?
    end

    nums.each_with_index do |curr_num, idx|
      return true if !differences[curr_num].nil? && differences[curr_num] != idx
    end

    false
  end
end

SumFinder.new('./input.txt').call
