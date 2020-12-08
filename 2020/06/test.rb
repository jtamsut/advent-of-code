def element_in_all_groups?(element, group)
  group.each do |key, value|
    return false unless value.include?(element)
  end

  true
end

v = {
  'a': [1,2,3],
  'b': [1,3,6,5]
}

puts element_in_all_groups?(1, v)
puts element_in_all_groups?(4, v)
