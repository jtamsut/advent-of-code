# frozen_string_literal: true

require 'pry'

require_relative './../utils/file_loader.rb'

class SeatModel < FileLoader
  ROW_WIDTH = 96
  COL_WIDTH = 98

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
    end

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
    all_visible_seats(seats: curr_seats, row_idx: row_idx, col_idx: col_idx).filter do |cell|
      cell == '#'
    end.count
  end

  def all_visible_seats(seats:, row_idx:, col_idx:)
    visible_seats = []

    visible_seats << visible_seats(
      seats: seats,
      row_idx: row_idx,
      col_idx: col_idx
    ) do
      @row_idx += 1
    end

    visible_seats << visible_seats(
      seats: seats,
      row_idx: row_idx,
      col_idx: col_idx
    ) do
      @col_idx += 1
    end

    visible_seats << visible_seats(
      seats: seats,
      row_idx: row_idx,
      col_idx: col_idx
    ) do
      @row_idx -= 1
    end

    visible_seats << visible_seats(
      seats: seats,
      row_idx: row_idx,
      col_idx: col_idx
    ) do
      @col_idx -= 1
    end

    visible_seats << visible_seats(
      seats: seats,
      row_idx: row_idx,
      col_idx: col_idx
    ) do
      @row_idx += 1
      @col_idx -= 1
    end

    visible_seats << visible_seats(
      seats: seats,
      row_idx: row_idx,
      col_idx: col_idx
    ) do
      @row_idx -= 1
      @col_idx += 1
    end

    visible_seats << visible_seats(
      seats: seats,
      row_idx: row_idx,
      col_idx: col_idx
    ) do
      @row_idx += 1
      @col_idx += 1
    end

    visible_seats << visible_seats(
      seats: seats,
      row_idx: row_idx,
      col_idx: col_idx
    ) do
      @row_idx -= 1
      @col_idx -= 1
    end

    visible_seats.compact
  end

  def visible_seats(seats:, row_idx:, col_idx:)
    @row_idx = row_idx
    @col_idx = col_idx

    yield(@row_idx, @col_idx)

    while in_bounds?(@row_idx, @col_idx)
      seat = seats[@row_idx][@col_idx]

      return seat if seat != '.'

      yield(@row_idx, @col_idx)
    end
  end

  def in_bounds?(row_idx, col_idx)
    return false if row_idx.negative? || row_idx >= ROW_WIDTH
    return false if col_idx.negative? || col_idx >= COL_WIDTH

    true
  end
end

a = SeatModel.new('./input.txt')
a.call
puts a.seats.inspect
