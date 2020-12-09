require 'pry'

class BagContainer
  MYBAG = 'shiny_gold'.freeze

  def initialize(file_path)
    @file_path = file_path
    @tree = {}
  end

  def call
    File.foreach(@file_path).each do |line|
      @current_line = line

      generate_tree
    end

    @tree.values.each do |value|
      nodes = value[:nodes]

      value[:contain_gold_bag] = true if contain_my_bag?(nodes)
      find_leaf_nodes(nodes)
    end
  end

  private

  def contain_my_bag?(nodes)
    nodes.each do |node|
      return true if node[:description] == MYBAG
    end

    false
  end

  def find_leaf_nodes(nodes)
    nodes.each do |node|
      description = node[:description]

      node[:leaf_node] = true if @tree[description].nil?
    end
  end

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
      description: description,
      leaf_node: false
    }
  end
end

BagContainer.new('./input.txt').call
