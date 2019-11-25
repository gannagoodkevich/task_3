require 'pry'
require 'csv'
require 'test/unit'

Person = Struct.new(
  :first_name, :last_name, :gender, :age, :address, :city,
  :state, :phone, :email, :allow_sms, :allow_email,
  keyword_init: true
)

# data.csv example:
#
# first_name,last_name,gender,age,address,city,state,phone,email,allow_sms,allow_email
# Bob,Marley,m,45,2763 Tori Lane,Salt Lake City,UT,1235439504,bobmarley@random.com,true,false
# Billy,McGregory,M,22,3762 Star Route,Schaumburg,IL,+1545467644,billymcgregory@random.org,T,F
# Lady,GaGa,F,88,2694 George Street,Gainesville,FL,1119993334,ladygaga@random.by,,

class Loader
  class << self
    def call(file)
      new(file).call
    end
  end

  attr_reader :file, :result

  def initialize(file)
    @file = file
    @result = []
  end

  def call
    CSV.foreach(file, headers: true) do |row|
      binding.pry
      # here was a mistake: Person.new(hash)
      person = Person.new(row.to_h)
      binding.pry
      result.push(person)
    end
    result
  end
end

class LoaderTest < Test::Unit::TestCase
  def test_size
    assert_equal(Loader.call('data.csv').size, 3, 'All people were loaded.')
  end

  def test_class
    assert_instance_of(Person, Loader.call('data.csv').first, 'Create correct objects.')
  end
end
