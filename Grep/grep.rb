class Grep
  def Grep.grep(seacrh_word, flags, files)
    result = ""
    index_file = 0
    number = false
    file_name = false
    registr = true
    revert = false
    lines = false
    flags.each do |argument|
      if argument.eql?("-n")
        number = true
        file_name = false
        lines = false
      end
      if argument.eql?("-l")
        number = false
        file_name = true
        lines = false
      end
      registr = false if argument.eql?("-i")
      revert = true if argument.eql?("-v")
      lines = true if argument.eql?("-x")
    end
    files.each do |curr_file|
      o_file = File.open(curr_file, "r")
      index_line = 0
      flag = 0
      o_file.each do |line|
        line1 = line
        line1 = line.downcase unless registr
        seacrh_word.downcase! unless registr
        index_line += 1
        if number
          unless revert
            result << "#{files[index_file]}:".chomp if (files.size > 1 && !line1.match(/#{seacrh_word}/).nil?)
            result << "#{index_line}:#{line}" unless line1.match(/#{seacrh_word}/).nil?
          else
            result << "#{files[index_file]}:".chomp if (files.size > 1 && line1.match(/#{seacrh_word}/).nil?)
            result << "#{index_line}:#{line}" if line1.match(/#{seacrh_word}/).nil?
          end
        elsif file_name
          unless revert
            flag = 1 unless line1.match(/#{seacrh_word}/).nil?
          else
            flag = 1 if line1.match(/#{seacrh_word}/).nil?
          end
        elsif lines
          unless revert
            result << "#{files[index_file]}:".chomp if (files.size > 1 && line1.match(/^#{seacrh_word}$/))
            result << "#{line}" if line1.match(/^#{seacrh_word}$/)
          else
            result << "#{files[index_file]}:".chomp if (files.size > 1 && line1.match(/^#{seacrh_word}$/).nil?)
            result << "#{line}" unless line1.match(/^#{seacrh_word}$/)
          end
        else
          unless revert
            result << "#{files[index_file]}:".chomp if (files.size > 1 && !line1.match(/#{seacrh_word}/).nil?)
            result << "#{line}" unless line1.match(/#{seacrh_word}/).nil?
          else
            result << "#{files[index_file]}:".chomp if (files.size > 1 && line1.match(/#{seacrh_word}/).nil?)
            result << "#{line}" if line1.match(/#{seacrh_word}/).nil?
          end
        end
      end
      result << "#{files[index_file]}\n" if flag == 1
      o_file.close
      index_file += 1
    end
    result.chomp
  end
end

puts Grep.grep("World", ["-n"], ["file1.txt", "file2.txt"])
