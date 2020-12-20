# frozen_string_literal: true

require 'pry'

require_relative './../utils/file_loader.rb'
require_relative './visible_seats.rb'

class SeatModel < FileLoader
  attr_reader :seats

  def initialize(file_path)
    super(file_path)

    @seats = []

    each_line { @seats << @current_line.split('') }
  end

  def call
    iterations = 0

    while run_model
      iterations += 1
      puts "Number of iterations: #{iterations}"
    end

    run_model

    puts "Occupied seats: #{@seats.flatten.join('').count('#')}"
    puts "Iterations: #{iterations}"
  end

  def run_model
    no_change = false
    seat_copy = @seats.clone.map(&:clone)

    @seats.each_with_index do |row, row_idx|
      row.each_with_index do |_, col_idx|
        seat = seat_copy[row_idx][col_idx]

        adj_seats = num_adj_occupied_seats(
          curr_seats: seat_copy,
          row_idx: row_idx,
          col_idx: col_idx
        )

        if seat == 'L' && adj_seats.zero?
          @seats[row_idx][col_idx] = '#'
          no_change = true
        elsif seat == '#' && adj_seats >= 5
          @seats[row_idx][col_idx] = 'L'
          no_change = true
        end
      end
    end

    no_change
  end

  def num_adj_occupied_seats(curr_seats:, row_idx:, col_idx:)
    VisibleSeats.new(
      seats: curr_seats,
      row: row_idx,
      col: col_idx
    ).call.filter do |cell|
      cell == '#'
    end.count
  end
end

a = SeatModel.new('./test.txt')
a.call
