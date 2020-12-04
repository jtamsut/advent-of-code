require 'pry'

class PassportParser 
  VALID_FIELDS = [
    'byr',
    'iyr',
    'eyr',
    'hgt',
    'hcl',
    'ecl',
    'pid'
  ]

  def initialize(file_path)
    @file_path = file_path
    @passports = [[]]
    @passport_codes = []
    @current_line = nil
    @valid_count = 0
  end

  def call
    generate_raw_passport_data
    codes_from_passports

    @passport_codes.each do |passport|
      if required_codes?(passport) && valid_codes?(passport)
        @valid_count += 1
      end
    end

    @valid_count
  end

  private

  def generate_raw_passport_data
    File.foreach(@file_path) do |line|
      @current_line = line

      @passports << [] if newline?

      @passports.last.concat(line.split(' ')) unless newline?
    end
  end

  def required_codes?(passport_codes)
    VALID_FIELDS.each do |valid_field|
      unless just_keys(passport_codes).include?(valid_field)
        return false
      end
    end

    true
  end

  def newline?
    @current_line == "\n"
  end

  def codes_from_passports
    @passports.each do |passport|
      @passport_codes << parse_passport(passport)
    end
  end

  def parse_passport(codes)
    codes.map do |code|
      split_data = code.split(':')

      { split_data[0] => split_data[1] }
    end
  end

  def just_keys(codes)
    codes.map(&:keys).flatten
  end

  def valid_codes?(passport)
    passport.each do |code|
      next if code.keys[0] == 'cid'
      method_name = "#{code.keys[0]}_valid?".to_sym
      unless send(method_name, code.values[0])
        puts "Not valid - #{code.keys[0]}: #{code.values[0]}"
        return false
      end
    end

    true
  end

  def byr_valid?(value)
    num_val = value.to_i

    return false unless /^\d{4}$/ === value
    return false if num_val < 1920 || num_val > 2002

    true
  end

  def iyr_valid?(value)
    num_val = value.to_i

    return false unless /^\d{4}$/ === value
    return false if num_val < 2010 || num_val > 2020

    true
  end

  def eyr_valid?(value)
    num_val = value.to_i

    return false unless /^\d{4}$/ === value
    return false if num_val < 2020 || num_val > 2030

    true
  end

  def hgt_valid?(value)
    reg = value.match(/(?<height>^\d+)(?<unit>(cm|in))/)

    return false if reg.nil?

    unit = reg[:unit]
    height = reg[:height].to_i

    if unit == 'cm'
      return false if height < 150 || height > 193
    end

    if unit == 'in'
      return false if height < 59 || height > 76
    end

    true
  end

  def hcl_valid?(value)
    !value.match(/^#[0-9a-f]{6}$/).nil?
  end

  def ecl_valid?(value)
    %w(amb blu brn gry grn hzl oth).include?(value)
  end

  def pid_valid?(value)
    return false unless /^\d{9}$/ === value

    true
  end
end

puts PassportParser.new('./input.txt').call
