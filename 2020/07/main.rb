require 'pry'

class BagContainer
  def initialize(file_path)
    @file_path = file_path
    @tree = {}
  end

  def call
    File.foreach(@file_path).each do |line|
      @current_line = line

      generate_tree
    end
  end

  private

  def generate_tree
    if @tree[tree_key].nil?
      @tree[tree_key] = {
        contain_gold_bag: nil,
        nodes: tree_nodes
      }
    else
      puts 'Bag already exists'
    end
  end

  def parse_line
    @current_line.split(' ')
  end

  def tree_key
    texture = parse_line[0]
    color = parse_line[1]
    description(texture: texture, color: color)
  end

  def tree_nodes
    nodes = []

    (4..(parse_line.length - 1)).step(4).each do |index|
      amount = parse_line[index]
      description = description(
        texture: parse_line[index + 1],
        color: parse_line[index + 2]
      )

      nodes << node(amount: amount, description: description)
    end

    nodes
  end

  def description(texture:, color:)
    "#{texture}_#{color}"
  end

  def node(amount:, description:)
    {
      amount: amount,
      description: description
    }
  end
end

BagContainer.new('./input.txt').call
