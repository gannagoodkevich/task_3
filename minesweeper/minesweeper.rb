=begin
Write your code for the 'Minesweeper' exercise in this file. Make the tests in
`minesweeper_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/minesweeper` directory.
=end
class Board
  class << self
    def transform(input)
      for j in 1...input[0].size - 1
        raise ArgumentError, 'Argument is wrong' unless input[0][j] == '-'
        raise ArgumentError, 'Argument is wrong' unless input[input.size - 1][j] == '-'
      end
      for i in 1...input.size - 1
        raise ArgumentError, 'Argument is wrong' unless input[i].size == input[0].size
        for j in 1...input[i].size - 1
          if input[i][j].eql?(' ')
            ans = 0
            ans += 1 if check_bottom_square(input, i, j)
            ans += 1 if check_right_square(input, i, j)
            ans += 1 if check_right_bottom_square(input, i, j)
            ans += 1 if check_upper_square(input, i, j)
            ans += 1 if check_left_square(input, i, j)
            ans += 1 if check_left_upper_square(input, i, j)
            ans += 1 if check_left_bottom_square(input, i, j)
            ans += 1 if check_right_upper_square(input, i, j)
            input[i][j] = ans.to_s unless ans == 0
          else
            raise ArgumentError, 'Argument is wrong' unless input[i][j].eql?('*')
          end
        end
      end
      input
    end

    private

    def check_bottom_square(input, i, j)
      i + 1 <= input.size && input[i + 1][j] == '*'
    end

    def check_right_square(input, i, j)
      j + 1 <= input[i].size && input[i][j + 1] == '*'
    end

    def check_right_bottom_square(input, i, j)
      i + 1 <= input.size && j + 1 <= input[i].size && input[i + 1][j + 1] == '*'
    end

    def check_upper_square(input, i, j)
      i - 1 >= 0 && input[i - 1][j] == '*'
    end

    def check_left_square(input, i, j)
      j - 1 >= 0 && input[i][j - 1] == '*'
    end

    def check_left_upper_square(input, i, j)
      i - 1 >= 0 && j - 1 >= 0 && input[i - 1][j - 1] == '*'
    end

    def check_left_bottom_square(input, i, j)
      i + 1 <= input.size && j - 1 >= 0 && input[i + 1][j - 1] == '*'
    end

    def check_right_upper_square(input, i, j)
      i - 1 >= 0 && j + 1 <= input[i].size && input[i - 1][j + 1] == '*'
    end
  end
end
