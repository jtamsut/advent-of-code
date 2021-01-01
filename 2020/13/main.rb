# frozen_string_literal: true

require 'pry'

require_relative './../utils/file_loader.rb'

class Solution < FileLoader
  def initialize(file_path)
    super(file_path)
  end

  def call
    each_line do
      @earliest_time = @current_line.to_i if @current_line_number == 0
      @bus_ids = @current_line.split(',').filter{ |x| x != 'x' } if @current_line_number == 1
    end

    targets = @bus_ids.map do |id|
      to_target(id.to_i, @earliest_time)
    end

    time_waiting = targets.min - @earliest_time

    sorted = targets.sort
  end

  def to_target(factor, target)
    count = factor

    while count < target
      count += factor
    end

    count
  end
end

Solution.new('./input.txt').call
