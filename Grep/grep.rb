class Grep
  def initialize(file_name)
    @file_name = file_name
    @files = Array.new
    @file_name.each do |file|
      @files << File.open(file, "r")
    end
  end

  def print_matching_lines_number(seacrh_word, number, file_name, revert, registr, lines)
    index_file = 0
    @files.each do |curr_file|
      index_line = 0
      flag = 0
      puts "Searching in #{@file_name[index_file]}..."
      curr_file.each do |line|
        line.downcase! unless registr
        seacrh_word.downcase! unless registr
        index_line += 1
        if number
          unless revert
            puts "#{index_line}: #{line}" unless line.match(/#{seacrh_word}/).nil?
          else
            puts "#{index_line}: #{line}" if line.match(/#{seacrh_word}/).nil?
          end
        end
        if file_name
          unless revert
            flag = 1 unless line.match(/#{seacrh_word}/).nil?
          else
            flag = 1 if line.match(/#{seacrh_word}/).nil?
          end
        end
        if lines
          unless revert
            puts "#{index_line}: #{line}" if line.match(/^#{seacrh_word}$/)
          else
            puts "#{index_line}: #{line}" unless line.match(/^#{seacrh_word}$/)
          end
        end
      end
      puts "#{@file_name[index_file]}" if (flag ==1 && file_name)
      curr_file.close
      index_file += 1
    end
  end
end
name_of_file = []
word = ""
number = false
file_name = false
registr = true
revert = false
lines = false

ARGV.each do |argument|
  case argument
    when "-n"
      number = true
    when "-l"
      file_name = true
    when "-i"
      registr = false
    when "-v"
      revert = true
    when "-x"
      revert = true
  end
  if argument.match(/.txt/)
    name_of_file << argument
  end
  if argument.match(/--find=/)
    word = argument.gsub('--find=', '')
  end
end

grep = Grep.new(name_of_file)
grep.print_matching_lines_number(word, number, file_name, revert, registr, lines)
