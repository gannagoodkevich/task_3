class Human
  def pay
    "The human is happy"
  end

  def feed(dog)
    dog.feed
  end
end

class Dog
  def feed
    "Dog is happy"
  end
end

class Job
  def pay(human)
    human.take_salery
  end
end
