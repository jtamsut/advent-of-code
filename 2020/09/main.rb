# frozen_string_literal: true
require 'pry'

require_relative './../utils/file_loader.rb'

class SumFinder < FileLoader
  def initialize(file_path)
    super(file_path)
  end

  def call
    each_line do |line, line_number|
      binding.pry
      puts line
    end
  end

  private

  def two_num_sum(nums, num)
    sums = {}

  

  end
end

SumFinder.new('./input.txt').call
