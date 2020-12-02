$number_of_valid_passwords_1 = 0
$number_of_valid_passwords_2 = 0

REGEX = /(?<lower>[0-9]+)-(?<upper>[0-9]+) (?<letter>[a-z]): (?<password>[a-z]+)/

def password_valid_1?(lower:, upper:, letter:, pw:)
  occurences = pw.count(letter)
  occurences >= lower && occurences <= upper
end

def password_valid_2?(lower:, upper:, letter:, pw:)
  letters = [ pw[lower-1], pw[upper-1] ]
  letters.count(letter) == 1
end

File.foreach('./input.txt') do |line|
  data = REGEX.match(line)
  if password_valid_1?(
      lower: data[:lower].to_i,
      upper: data[:upper].to_i,
      letter: data[:letter],
      pw: data[:password]
    )
    $number_of_valid_passwords_1 += 1
  end

  if password_valid_2?(
      lower: data[:lower].to_i,
      upper: data[:upper].to_i,
      letter: data[:letter],
      pw: data[:password]
    )
    puts line
    $number_of_valid_passwords_2 += 1
  end
end

puts "Number of valid passwords from part 1: #{$number_of_valid_passwords_1}"
puts "Number of valid password from part 2: #{$number_of_valid_passwords_2}"
