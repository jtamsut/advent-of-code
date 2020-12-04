require 'pry'

class PassportParser 
  VALID_FIELDS = [
    'byr',
    'iyr',
    'eyr',
    'hgt',
    'hcl',
    'ecl',
    'pid',
  ]

  def initialize(file_path)
    @file_path = file_path
    @passports = [[]]
    @cleaned_up_codes = []
    @current_line = nil
    @valid_count = 0
  end

  def call
    File.foreach(@file_path) do |line|
      @current_line = line

      @passports << [] if newline?

      if !newline?
        @passports.last.concat(line.split(" "))
      end
    end

    clean_up

    @cleaned_up_codes.each do |x|
      @valid_count += 1 if passport_valid?(x) 
    end

    @valid_count
  end

  private

  def passport_valid?(passport)
    passport.each do |i|
      return false if !VALID_FIELDS.include?(i)
    end

    true
  end
    


  def newline?
    @current_line == "\n"
  end

  def clean_up
    @passports.each do |passport|
      @cleaned_up_codes << get_codes(passport)
    end
  end

  def get_codes(codes)
    codes.map do |code|
      parse_code(code)
    end
  end

  def parse_code(code)
    code.split(':').first
  end
end

puts PassportParser.new('./input.txt').call
