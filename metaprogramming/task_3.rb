animal = 'dog'

puts animal.class
animal.class.instance_eval do
  @@animals = {dog: 'woof'}
  def animal.speak
    puts "#{self} says #{@@animals[self.to_sym]}"
  end
end

animal.speak
