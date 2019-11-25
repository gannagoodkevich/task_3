class I
  def like arg
    puts '%s %s %s' % [self.class, self.class.instance_methods(false), arg]
  end
end

c, m, arg = gets.split

module M
  method_name = TOPLEVEL_BINDING.eval('m')
  define_method(method_name) do |arg|
    middle = self.class.instance_methods(false).pop
    puts self.class.to_s << ' ' << middle.to_s << ' ' << arg.to_s
  end
end

Object.const_get(c).prepend(M)
Object.const_get(c).new.send(m, arg)