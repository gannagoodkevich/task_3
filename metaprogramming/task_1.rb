class A
  def initialize
    @a = 11
    @@a = 22
    a = 33
  end
  @a = 1
  @@a = 2
  a = 3
end

A.instance_eval do
  def my_class_vars
    variable_i = Array.new
    variable_c = Array.new
    variable_i = A.instance_variables
    variable_c = A.class_variables
    variable_i.each do |var|
      var =  var.to_sym
      v = instance_variable_get(var)
      puts v
    end
    variable_c.each do |var|
      var =  var.to_sym
      v = class_variable_get(var)
      puts v
    end
  end
end

A.class_eval do
  def my_class_vars
    variable_i = Array.new
    variable_c = Array.new
    variable_i = A.instance_variables
    variable_c = A.class_variables
    variable_i.each do |var|
      var =  var.to_sym
      v = instance_variable_get(var)
      puts v
    end
    variable_c.each do |var|
      var =  var.to_sym
      v = self.class.class_variable_get(var)
      puts v
    end
  end
end

A.my_class_vars
puts a = class A
  def initialize
    @a = 11
    @@a = 22
    a = 33
  end
  @a = 1
  @@a = 2
  a = 3
end
A.new.my_class_vars
puts A.new.send(:initialize)
