require 'pry'

class VisibleSeats
  DIRECTIONS = [
    [-1, -1],
    [1,   1],
    [0,  -1],
    [-1,  0],
    [1,  -1],
    [-1,  1],
    [1,   0],
    [0,   1]
  ]

  NO_SEAT = '.'

  def initialize(seats:, row:, col:)
    @num_rows = seats.first.length
    @num_cols = seats.length
    @seats = seats
    @row = row
    @col = col
    @visible_seats = []
  end

  def call
    DIRECTIONS.each do |direction|
      line_of_sight(
        row: @row,
        col: @col,
        seats: @seats,
        direction: direction
      )
    end

    binding.pry
    @visible_seats
  end

  def line_of_sight(row:, col:, seats:, direction:)
    row_position = row + direction[0]
    col_position = row + direction[1]

    loop do
      break unless in_bounds?(row_position, col_position)

      @visible_seats << seats[row][col] if seats[row][col] != NO_SEAT

      break if seats[row][col] != NO_SEAT

      row_position += direction[0]
      col_position += direction[1]
    end
  end

  def in_bounds?(row_idx, col_idx)
    return false if row_idx.negative? || row_idx >= @seats.first.length
    return false if col_idx.negative? || col_idx >= @seats.length

    true
  end
end
