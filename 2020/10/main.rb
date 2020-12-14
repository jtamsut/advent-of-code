# frozen_string_literal: true
require 'pry'

require_relative './../utils/file_loader.rb'

class JoltageAdapter < FileLoader
  def initialize(file_path)
    super(file_path)
  end
  
  def call
  end
end

JoltageAdapter.new('./input.txt').call
