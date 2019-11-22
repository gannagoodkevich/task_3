class Human

  def initialize(pet)
    @pet = pet
  end
  
  def pay
    "The human is happy"
  end

  def feed
    @pet.eat
  end
end

class Dog
  def eat
    "Dog is happy"
  end
end

class Job
  def pay(human)
    human.pay
  end
end

puts Human.new(Dog.new).feed