class Matrix
  def initialize(*str)
    @str = str
  end

  def add(str)
    @str << str
    puts "HEllO #{@str}"
  end

  def to_matrix
    @col = Array.new
    @str.each do |s|
      @col << s.split(' ')
    end
  end

  def puts_rows
    puts "Rows:"
    for i in 0...@col.size
      for j in 0...@col[0].size
        print "#{@col[i][j]}"
      end
      puts ";"
    end
  end

  def puts_columns
    puts "Columns:"
    for i in 0...@col[0].size
      for j in 0...@col.size
        print "#{@col[j][i]}"
      end
      puts ";"
    end
  end
end

puts "Enter matrix. Type END to stop input"
m = Matrix.new()
while((string = gets.chomp) && !string.eql?("END"))
  m.add(string)
end
m.to_matrix
m.puts_rows
m.puts_columns
