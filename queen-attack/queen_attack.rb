=begin
Write your code for the 'Queen Attack' exercise in this file. Make the tests in
`queen_attack_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/queen-attack` directory.
=end

class Queens
  def initialize(hash)
    @hash = hash
    @hash.each do |k, v|
      raise ArgumentError, 'Argument is wrong' if v[0] < 0 || v[1] < 0 || v[0] >= 8 || v[1] >= 8
    end
  end

  def attack?
    @board = Array.new(8){Array.new(8)}
    @board.each do |line|
      line.each {|element| element = 0}
    end
    flag = 0
    @board[@hash[:white][0].to_i][@hash[:white][1].to_i] = 1
    @board[@hash[:black][0].to_i][@hash[:black][1].to_i] = 1
    flag = 1 if @hash[:white][0] == @hash[:black][0] || @hash[:white][1] == @hash[:black][1]
    i = 0
    while @hash[:white][0]-i > 0 && @hash[:white][1]+i < 7
      i += 1
      flag = 1 if (@hash[:white][0]-i == @hash[:black][0] and @hash[:white][1]+i == @hash[:black][1])
    end
    i = 0
    while @hash[:white][0] + i < 7 && @hash[:white][1] + i < 7
      i += 1
      flag = 1 if (@hash[:white][0]+i == @hash[:black][0] and @hash[:white][1]+i == @hash[:black][1])
    end
    i = 0
    while @hash[:white][0].to_i+i < 7 && @hash[:white][1].to_i-i > 0
      i += 1
      flag = 1 if (@hash[:white][0]+i == @hash[:black][0] and @hash[:white][1]-i == @hash[:black][1])
    end
    i = 0
    while @hash[:white][0].to_i-i > 0 && @hash[:white][1].to_i-i > 0
      i += 1
      flag = 1 if (@hash[:white][0]-i == @hash[:black][0] and @hash[:white][1]-i == @hash[:black][1])
    end
    return true if flag == 1
  end
end


q = Queens.new(white: [2, 2], black: [0, 4])
puts q.attack?.inspect
