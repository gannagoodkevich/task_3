animal = 'dog'

animal.class.instance_eval do
  def animal.speak
    puts "#{self} says Woof"
  end
end

animal.speak
