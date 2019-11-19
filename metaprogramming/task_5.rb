some_class = Class.new(super_class=String)

MaskedString = some_class

MaskedString.class_eval do
  define_singleton_method(:tr_vowel) do |str|
    str.tr 'aeiou', '*'
  end
end

MaskedString.instance_eval do
  define_method(:tr_vowel) do
    tr 'aeiou', '*'
  end
end

puts MaskedString.tr_vowel "Hello"
str = MaskedString.new
puts str.tr_vowel
