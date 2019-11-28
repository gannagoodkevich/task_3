=begin
Write your code for the 'Queen Attack' exercise in this file. Make the tests in
`queen_attack_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/queen-attack` directory.
=end

class Queens

  def initialize(hash)
    @hash = hash
    valid_hash_check
    @flag = 0
  end

  def attack?
    attack_on_line(@hash[:white][1], @hash[:black][1]) || attack_on_line(@hash[:white][0], @hash[:black][0]) || attack_diagonal(@hash[:white][0], @hash[:white][1], @hash[:black][0], @hash[:black][1])
  end

  private

  def valid_hash_check
    @hash.each do |k, v|
      if v[0] < 0 || v[1] < 0 || v[0] >= 8 || v[1] >= 8
        raise ArgumentError, 'Argument is wrong'
      end
    end
  end

  def attack_diagonal(row_position_white, colomn_position_white, row_position_black, colomn_position_black)
    (row_position_white - row_position_black).abs == (colomn_position_white - colomn_position_black).abs
  end

  def attack_on_line(position_white, position_black)
    position_white == position_black
  end
end
