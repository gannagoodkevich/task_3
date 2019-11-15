=begin
Write your code for the 'Matrix' exercise in this file. Make the tests in
`matrix_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/matrix` directory.
=end

class Matrix
  def initialize(str)
    @str = str
    to_matrix
  end

  def rows
    ans = []
    for i in 0...@col.size
      mmm = []
      for j in 0...@col[0].size
        mmm << @col[i][j].to_i
      end
      ans << mmm
    end
    return ans
  end

  def columns
    ans = []
    for i in 0...@col[0].size
      mmm = []
      for j in 0...@col.size
        mmm << @col[j][i].to_i
      end
      ans << mmm
    end
    return ans
  end
  
  private

  def to_matrix
    @col = Array.new
    @str = @str.split("\n")
    @str.each do |s|
      @col << s.split(' ')
    end
  end
end
