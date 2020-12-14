# frozen_string_literal: true
require 'pry'

require_relative './../utils/file_loader.rb'

class SeatModel < FileLoader
  def initialize(file_path)
    super(file_path)
  end

  def call
    @seats = []
    each_line { @seats << @current_line.split('') }

    prev_state = -1
    new_state = 1
    evolutions = 0

    while prev_state != new_state
      evolutions += 1

      prev_state = @seats.flatten.join('')

      run_model

      new_state = @seats.flatten.join('')
    end

    puts "There are #{prev_state.count('#')} occupied seats."
    puts "There are #{new_state.count('#')} occupied seats."
    puts "Number of evolutions: #{evolutions}"
  end

  def run_model
    @seats.each_with_index do |row, row_idx|
      @row_idx = row_idx

      row.each_with_index do |_, col_idx|
        @col_idx = col_idx

        seat = @seats[row_idx][col_idx]

        if seat == 'L' && num_adj_occupied_seats.zero?
          @seats[@row_idx][@col_idx] = '#'
        elsif seat == '#' && num_adj_occupied_seats >= 4
          @seats[row_idx][col_idx] = 'L'
        end
      end
    end
  end

  def num_adj_occupied_seats
    adjacent_cells.filter do |cell|
      cell == '#'
    end.count
  end

  def  adjacent_cells
    adjacent = []
    number_of_rows = @seats.count
    number_of_cols = @seats.first.count

    if @row_idx + 1 < number_of_rows
      adjacent << @seats[@row_idx + 1][@col_idx]
      adjacent << @seats[@row_idx + 1][@col_idx + 1] if @col_idx + 1 < number_of_cols
      adjacent << @seats[@row_idx + 1][@col_idx - 1] if (@col_idx - 1).positive?
    end

    if (@row_idx - 1).positive?
      adjacent << @seats[@row_idx - 1][@col_idx]
      adjacent << @seats[@row_idx - 1][@col_idx + 1] if @col_idx + 1 < number_of_cols
      adjacent << @seats[@row_idx - 1][@col_idx - 1] if (@col_idx - 1).positive?
    end

    adjacent << @seats[@row_idx][@col_idx + 1] unless @col_idx + 1 < number_of_cols
    adjacent << @seats[@row_idx][@col_idx - 1] unless (@col_idx - 1).positive?

    adjacent
  end
end

SeatModel.new('./input.txt').call
