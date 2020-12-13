# frozen_string_literal: true

require 'pry'
require_relative './../utils/file_loader.rb'

class AssemblyParser < FileLoader
  def initialize(file_path)
    super(file_path)
    @accumulator = 0
  end

  def call
    @instructions = []

    # Save instructions in array
    each_line { @instructions << instruction }

    @instructions.each_with_index do |instruction, index|

      if ['jmp', 'nop'].include?(instruction[:op_code])
        cloned_instructions = deep_copy(@instructions)

        change_op_code(cloned_instructions, index)

        process_instructions(cloned_instructions)

        puts "The value of counter is: #{@counter}"
      end
    end
  end

  private

  def set_as_not_visited(instructions)
    instructions.each do |instruction|
      instruction[:visited] = false
    end
  end

  def deep_copy(obj)
    obj = Marshal.load(Marshal.dump(obj))

    set_as_not_visited(obj)

    obj
  end

  def change_op_code(instructions, index)
    op_code = instructions[index][:op_code]
    instructions[index][:op_code] = op_code == 'nop' ? 'jmp' : 'nop'
  end

  def process_instructions(instructions)
    @counter = 0

    instruction = instructions[@counter]

    while !instruction[:visited]
      instruction[:visited] = true

      send(
        instruction[:op_code],
        instruction[:arg]
      )
    end
  end

  def instruction
    {
      visited: false,
      op_code: op_code,
      arg: arg
    }
  end

  def op_code
    @current_line.split(' ').first
  end

  def jmp(arg)
    operator = arg[0]
    rest = arg[1..-1].to_i

    @counter = @counter.send(operator, rest)
  end

  def nop(_)
    @counter += 1
  end

  def arg
    @current_line.split(' ')[1]
  end

  def acc(arg)
    operator = arg[0]
    rest = arg[1..-1].to_i

    @accumulator = @accumulator.send operator, rest
    @counter += 1
  end
end

AssemblyParser.new('input.txt').call
