MaskedString.instance_eval do
  include String
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
