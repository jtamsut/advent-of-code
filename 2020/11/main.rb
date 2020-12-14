# frozen_string_literal: true

require 'pry'

require_relative './../utils/file_loader.rb'

class SeatModel < FileLoader
  def initialize(file_path)
    super(file_path)
  end

  def call
    seats = []

    each_line { seats << @current_line.split('') }

    prev_state = run_model(seats)
    new_state = run_model(prev_state)

    while state_change?(prev_state, new_state)
      prev_state = new_state
      new_state = run_model(prev_state)
    end


    binding.pry

    puts "There are #{prev_state.flatten.join('').count('#')} occupied seats."
    puts "There are #{new_state.flatten.join('').count('#')} occupied seats."
  end

  private

  def state_change?(prev, new)
    prev_string = prev.flatten.join('')
    new_string = new.flatten.join('')

    prev_string != new_string
  end

  def run_model(seats)
    seat_copy = seats.clone.map(&:clone)
    @change = false

    seat_copy.each_with_index do |row, row_idx|
      row.each_with_index do |_, col_idx|
        seat = seat_copy[row_idx][col_idx]

        adj_seats = num_adj_occupied_seats(
          curr_seats: seat_copy,
          row_idx: row_idx,
          col_idx: col_idx
        )

        if seat == 'L' && adj_seats.zero?
          seat_copy[row_idx][col_idx] = '#'
          @change = true
        elsif seat == '#' && adj_seats >= 4
          seat_copy[row_idx][col_idx] = 'L'
          @change = true
        end
      end
    end

    unless @change
      pretty_print(seat_copy)
    end

    seat_copy
  end

  def num_adj_occupied_seats(curr_seats:, row_idx:, col_idx:)
    adjacent_cells(curr_seats, row_idx, col_idx).filter do |cell|
      cell == '#'
    end.count
  end

  def pretty_print(seats)
    seats.each do |row|
      puts row.join('')
    end
  end

  def  adjacent_cells(curr_seats, row_idx, col_idx)
    adjacent = []

    number_of_rows = curr_seats.count
    number_of_cols = curr_seats.first.count

    if (row_idx + 1) < number_of_rows
      adjacent << curr_seats[row_idx + 1][col_idx]
      adjacent << curr_seats[row_idx + 1][col_idx + 1] if (col_idx + 1) < number_of_cols
      adjacent << curr_seats[row_idx + 1][col_idx - 1] if (col_idx - 1) >= 0
    end

    if (row_idx - 1) >= 0
      adjacent << curr_seats[row_idx - 1][col_idx]
      adjacent << curr_seats[row_idx - 1][col_idx + 1] if col_idx + 1 < number_of_cols
      adjacent << curr_seats[row_idx - 1][col_idx - 1] if (col_idx - 1) >= 0
    end

    adjacent << curr_seats[row_idx][col_idx + 1] unless col_idx + 1 < number_of_cols
    adjacent << curr_seats[row_idx][col_idx - 1] unless (col_idx - 1) >= 0

    adjacent
  end
end

SeatModel.new('./input2.txt').call
