require 'pry'

class BagContainer
  MYBAG = 'shiny_gold'.freeze

  def initialize(file_path)
    @file_path = file_path
    @tree = {}
    @valid_bags = 0
    @bags_containing = 0
  end

  def call
    File.foreach(@file_path).each do |line|
      @current_line = line

      generate_tree
    end

    @tree.values.each do |value|
      @valid_bags += 1 if can_bag_contain_my_bag?(value)
    end

    binding.pry
    @valid_bags
  end

  private

  def count_bags_in_gold_bags(current_nodes)
    current_nodes.each do |curr_node|


    end
  end

  def can_bag_contain_my_bag?(nodes)
    return true if nodes_contain_gold_bag?(nodes)

    return false if leaf_node?(nodes)

    nodes.any? do |node|
      curr_tree_nodes = @tree[node[:description]]

      if curr_tree_nodes.nil?
        puts node
        raise 'Reached a leaf node'
      end

      can_bag_contain_my_bag?(curr_tree_nodes)
    end
  end

  def nodes_contain_gold_bag?(nodes)
    nodes.each do |node|
      return true if node[:description] == MYBAG
    end

    false
  end

  def leaf_node?(nodes)
    return false if nodes.length > 1

    description = nodes.first[:description]

    return true if ['other_bags', 'other_bags.'].include?(description)

    false
  end

  ##################################
  # TREE GENERATION
  ##################################

  def generate_tree
    if @tree[tree_key].nil?
      @tree[tree_key] = tree_nodes
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

puts BagContainer.new('./input.txt').call
