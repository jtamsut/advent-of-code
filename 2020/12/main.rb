# frozen_string_literal: true

require 'pry'

require_relative './../utils/file_loader.rb'

class Navigator < FileLoader
  COMPASS_RIGHT = %i[north east south west].freeze
  COMPASS_LEFT = %i[north west south east].freeze

  def initialize(file_path)
    super(file_path)
  end

  def call
    @path = []
    @directions = {
      north: 0,
      west: 0,
      south: 0,
      east: 0
    }
    @current_direction = :east

    each_line do
      move(current_move: instruction)
    end

    up_down = [@directions[:north], @directions[:south]]
    left_right = [@directions[:east], @directions[:west]]
    a = up_down.max - up_down.min
    b = left_right.max - left_right.min

    puts "Manhattan distance: #{a + b}"
  end

  def move(current_move:)
    amount = current_move[:amount]

    case current_move[:direction]
    when 'N'
      @directions[:north] += amount
    when 'W'
      @directions[:west] += amount
    when 'S'
      @directions[:south] += amount
    when 'E'
      @directions[:east] += amount
    when 'F'
      @directions[@current_direction] += amount
    when 'R'
      rotate_right(degrees: amount)
    when 'L'
      rotate_left(degrees: amount)
    else
      puts 'Well this should NOT have happened'
    end
  end

  def rotate_right(degrees:)
    right = degrees / 90
    new_index = (COMPASS_RIGHT.index(@current_direction) + right) % 4

    @current_direction = COMPASS_RIGHT[new_index]
  end

  def rotate_left(degrees:)
    left = degrees / 90
    new_index = (COMPASS_LEFT.index(@current_direction) + left) % 4

    @current_direction = COMPASS_LEFT[new_index]
  end

  def instruction
    {
      direction: @current_line[0],
      amount: @current_line[1..-1].to_i
    }
  end
end

Navigator.new('./input.txt').call
