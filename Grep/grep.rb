class Grep
  class << self
    def grep(seacrh_word, flags, files)
      result = ""
      @@files = files
      @@seacrh_word = seacrh_word
      @@revert = false
      @@registr_sensetive = true
      @@hard_matching = false
      flags.each do |flag|
        result = send("key_#{flag.gsub("-", "")}")
      end
      result << matching_line if flags.size == 0
      result.chomp if result
    end

    def key_n
      puts "N"
      result = ""
      @@files.each do |curr_file|
        o_file = File.open(curr_file, "r")
        index_line = 0
        o_file.each do |line|
          index_line += 1
          #puts index_line
          line1 = line
          line1 = line.downcase unless @@registr_sensetive
          @@seacrh_word.downcase! unless @@registr_sensetive
          if @@revert
            #result << "#{index_line}:".chomp if line1.match(/#{@@seacrh_word}/).nil?
            result << "#{index_line}:#{line}" if line1.match(/#{@@seacrh_word}/).nil?
          else
            #result << "#{index_line}:".chomp unless line1.match(/#{@@seacrh_word}/).nil?
            result << "#{index_line}:#{line}" unless line1.match(/#{@@seacrh_word}/).nil?
          end
        end
        o_file.close
      end
      #puts "Hello"
      #puts result
      result
    end

    def key_l
      puts "L"
      result = ""
      @@files.each do |curr_file|
        o_file = File.open(curr_file, "r")
        o_file.each do |line|
          line1 = line
          line1 = line.downcase unless @@registr_sensetive
          @@seacrh_word.downcase! unless @@registr_sensetive
          if @@revert
            result << "#{curr_file}\n" if line1.match(/#{@@seacrh_word}/).nil?
          else
            result << "#{curr_file}\n" unless line1.match(/#{@@seacrh_word}/).nil?
          end
        end
        o_file.close
      end
      result
    end

    def key_i
      puts "I"
      @@registr_sensetive = false
      result = ""
      @@files.each do |curr_file|
        o_file = File.open(curr_file, "r")
        index_line = 0
        o_file.each do |line|
          line1 = line.downcase
          @@seacrh_word.downcase!
          if @@revert
            if @@hard_matching
              result << "#{line}" unless line1.match(/^#{@@seacrh_word}$/)
            else
              result << "#{line}" if line1.match(/#{@@seacrh_word}/).nil?
            end
          else
            if @@hard_matching
              result << "#{line}" if line1.match(/^#{@@seacrh_word}$/)
            else
              result << "#{line}" unless line1.match(/#{@@seacrh_word}/).nil?
            end
          end
        end
      end
      result
    end

    def key_v
      puts "V"
      @@revert = true
      result = ""
      @@files.each do |curr_file|
        o_file = File.open(curr_file, "r")
        index_line = 0
        o_file.each do |line|
          line1 = line
          line1 = line.downcase unless @@registr_sensetive
          @@seacrh_word.downcase! unless @@registr_sensetive
          if @@hard_matching
            result << "#{line}" unless line1.match(/^#{@@seacrh_word}$/)
          else
            result << "#{line}" if line1.match(/#{@@seacrh_word}/).nil?
          end
        end
      end
      result
    end

    def key_x
      puts "X"
      @@hard_matching = true
      result = ""
      @@files.each do |curr_file|
        o_file = File.open(curr_file, "r")
        index_line = 0
        o_file.each do |line|
          line1 = line
          line1 = line.downcase unless @@registr_sensetive
          @@seacrh_word.downcase! unless @@registr_sensetive
          if @@revert
              result << "#{line}" unless line1.match(/^#{@@seacrh_word}$/)
          else
              result << "#{line}" if line1.match(/^#{@@seacrh_word}$/)
          end
        end
      end
      result
    end

    def matching_line
      result = ""
      @@files.each do |curr_file|
        o_file = File.open(curr_file, "r")
        index_line = 0
        o_file.each do |line|
          line1 = line
          line1 = line.downcase unless @@registr_sensetive
          @@seacrh_word.downcase! unless @@registr_sensetive
          if @@revert
            if @@hard_matching
              result << "#{line}" unless line1.match(/^#{@@seacrh_word}$/)
            else
              result << "#{line}" if line1.match(/#{@@seacrh_word}/).nil?
            end
          else
            if @@hard_matching
              result << "#{line}" if line1.match(/^#{@@seacrh_word}$/)
            else
              result << "#{line}" unless line1.match(/#{@@seacrh_word}/).nil?
            end
          end
          if @@hard_matching
            result << "#{line}" unless line1.match(/^#{@@seacrh_word}$/)
          else
            result << "#{line}" if line1.match(/#{@@seacrh_word}/).nil?
          end
        end
      end
      result
    end
  end
end



=begin
def Grep.grep(@@seacrh_word, flags, @@files)
  result = ""
  index_file = 0
  number = false
  file_name = false
  @@registr_sensetive = true
  @@@@revert = false
  lines = false
  flags.each do |argument|
    case argument
    when "-n"
      number = true
      file_name = false
      lines = false
    when "-l"
      number = false
      file_name = true
      lines = false
    end
    @@registr_sensetive = flase if argument.eql?("-i")
    @@@@revert = true if argument.eql?("-v")
    lines = true if argument.eql?("-x")
  end
  @@files.each do |curr_file|
    o_file = File.open(curr_file, "r")
    index_line = 0
    flag = 0
    o_file.each do |line|
      line1 = line
      line1 = line.downcase unless @@registr_sensetive
      @@seacrh_word.downcase! unless @@registr_sensetive
      index_line += 1
      if number
        if @@@@revert
          result << "#{@@files[index_file]}:".chomp if (@@files.size > 1 && line1.match(/#{@@seacrh_word}/).nil?)
          result << "#{index_line}:#{line}" if line1.match(/#{@@seacrh_word}/).nil?
        else
          result << "#{@@files[index_file]}:".chomp if (@@files.size > 1 && !line1.match(/#{@@seacrh_word}/).nil?)
          result << "#{index_line}:#{line}" unless line1.match(/#{@@seacrh_word}/).nil?
        end
      elsif file_name
        if @@revert
          flag = 1 if line1.match(/#{@@seacrh_word}/).nil?
        else
          flag = 1 unless line1.match(/#{@@seacrh_word}/).nil?
        end
      elsif lines
        if @@revert
          rresult << "#{@@files[index_file]}:".chomp if (@@files.size > 1 && line1.match(/^#{@@seacrh_word}$/).nil?)
          result << "#{line}" unless line1.match(/^#{@@seacrh_word}$/)
        else
          result << "#{@@files[index_file]}:".chomp if (@@files.size > 1 && line1.match(/^#{@@seacrh_word}$/))
          result << "#{line}" if line1.match(/^#{@@seacrh_word}$/)
        end
      else
        if @@revert
          result << "#{@@files[index_file]}:".chomp if (@@files.size > 1 && line1.match(/#{@@seacrh_word}/).nil?)
          result << "#{line}" if line1.match(/#{@@seacrh_word}/).nil?
        else
          result << "#{@@files[index_file]}:".chomp if (@@files.size > 1 && !line1.match(/#{@@seacrh_word}/).nil?)
          result << "#{line}" unless line1.match(/#{@@seacrh_word}/).nil?
        end
      end
    end
    result << "#{@@files[index_file]}\n" if flag == 1
    o_file.close
    index_file += 1
  end
  result.chomp
end
=end
