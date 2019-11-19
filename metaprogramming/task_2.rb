class I
  def like arg
    puts "%s %s %s" % [self.class, self.class.instance_methods(false), arg]
  end
end

module M
  def like arg
    middle = self.class.instance_methods(false).pop
    puts self.class.to_s << " " << middle.to_s << " " << arg.to_s
  end
end
c, m, arg = gets.split
Object.const_get(c).prepend(M)
Object.const_get(c).new.send(m, arg)