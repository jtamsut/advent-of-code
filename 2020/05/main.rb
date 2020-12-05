require 'pry'

class Boarder
  TOTAL_NUM_ROWS = 127
  TOTAL_NUM_COLS = 7

  def initialize(file_path)
    @file_path = file_path
    @seat_ids = []
  end

  def call
    seat_ids = []
    highest_seat_id = 0

    File.foreach(@file_path).each do |line|
      @current_line = line

      current_seat_id = seat_id(row, column)

      @seat_ids << current_seat_id

      if current_seat_id > highest_seat_id
        highest_seat_id = current_seat_id
      end
    end

    puts "The highest seat ID is #{highest_seat_id}"

    get_seat
  end

  private

  def get_seat
    sorted_seat_ids = @seat_ids.sort

    sorted_seat_ids.each_with_index do |seat_id, idx|
      next_id = sorted_seat_ids[idx + 1]

      if next_id != seat_id + 1
        puts "You seat id is #{seat_id + 1}"
        break
      end
    end
  end

  def seat_id(row_val, col_val)
    (row_val * 8) + col_val
  end

  def row 
    first = 0
    last = TOTAL_NUM_ROWS

    rows.each_char do |row|
      mid = midpoint(first, last)

      if row == 'F'
        first = first
        last = mid
      else
        first = mid + 1
        last = last
      end
    end

    first
  end

  def column
    first = 0
    last = TOTAL_NUM_COLS

    columns.each_char do |column|
      mid = midpoint(first, last)

      if column == 'R'
        first = mid + 1
        last = last
      else
        first = first
        last = mid
      end
    end

    last
  end

  def midpoint(first, last)
    delta = last - first
    first + (delta / 2)
  end

  def rows
    @current_line[0..6]
  end

  def columns
    @current_line[7..9]
  end
end

Boarder.new('./input.txt').call
