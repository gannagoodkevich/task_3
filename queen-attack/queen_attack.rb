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
    attack_colomn(@hash[:white][1], @hash[:black][1])
    attack_row(@hash[:white][0], @hash[:black][0])
    attack_right_upper_diagonal(@hash[:white][0], @hash[:white][1], @hash[:black][0], @hash[:black][1])
    attack_right_bottom_diagonal(@hash[:white][0], @hash[:white][1], @hash[:black][0], @hash[:black][1])
    attack_left_bottom_diagonal(@hash[:white][0], @hash[:white][1], @hash[:black][0], @hash[:black][1])
    attack_left_upper_diagonal(@hash[:white][0], @hash[:white][1], @hash[:black][0], @hash[:black][1])
    return true if @flag == 1
  end

  private

  def valid_hash_check
    @hash.each do |k, v|
      if v[0] < 0 || v[1] < 0 || v[0] >= 8 || v[1] >= 8
        raise ArgumentError, 'Argument is wrong'
      end
    end
  end

  def attack_right_upper_diagonal(row_position_white, colomn_position_white, row_position_black, colomn_position_black)
    i = 0
    while row_position_white - i > 0 && colomn_position_white + i < 7
      i += 1
      if row_position_white - i == row_position_black && colomn_position_white + i == colomn_position_black
        @flag = 1
      end
    end
  end

  def attack_right_bottom_diagonal(row_position_white, colomn_position_white, row_position_black, colomn_position_black)
    i = 0
    while row_position_white + i < 7 && colomn_position_white + i < 7
      i += 1
      if row_position_white + i == row_position_black && colomn_position_white + i == colomn_position_black
        @flag = 1
      end
    end
  end

  def attack_left_bottom_diagonal(row_position_white, colomn_position_white, row_position_black, colomn_position_black)
    i = 0
    while row_position_white + i < 7 && colomn_position_white - i > 0
      i += 1
      if row_position_white + i == row_position_black && colomn_position_white - i == colomn_position_black
        @flag = 1
      end
    end
  end

  def attack_left_upper_diagonal(row_position_white, colomn_position_white, row_position_black, colomn_position_black)
    i = 0
    while row_position_white - i > 0 && colomn_position_white - i > 0
      i += 1
      if row_position_white - i == row_position_black && colomn_position_white - i == colomn_position_black
        @flag = 1
      end
    end
  end

  def attack_row(row_position_white, row_position_black)
    @flag = 1 if row_position_white == row_position_black
  end

  def attack_colomn(colomn_position_white, colomn_position_black)
    @flag = 1 if colomn_position_white == colomn_position_black
  end

end
