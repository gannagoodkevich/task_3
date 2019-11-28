class A
  @@a = 1
  @a = 2
  a = 3
  @@bind = binding

  def self.get_bind
    @@bind
  end
end

p eval('[@@a, @a, a]', A.get_bind)
