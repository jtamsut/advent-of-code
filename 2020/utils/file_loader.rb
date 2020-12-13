# frozen_string_literal: true

class FileLoader
  def initialize(file_path)
    @file_path = file_path
  end

  def each_line
    File.foreach(@file_path).with_index do |line, line_number|
      @current_line = line.strip
      @current_line_number = line_number

      yield
    end
  end

  def call
    raise 'You must implement call method'
  end
end
