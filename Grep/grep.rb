class Grep
  def Grep.grep(seacrh_word, flags, files)
    result = ""
    index_file = 0
    @registr_sensetive = true
    @revert = false
    if flags.size > 0
      flags.each do |flag|
        puts "Hola", send("set_#{flag}") if respond_to?("set_#{flag}")
        puts result = send("key#{flag.gsub('-', '')}", seacrh_word) if respond_to?("key#{flag.gsub('-', '')}")
        if result == ""
          index_file = 0
          files.each do |curr_file|
            o_file = File.open(curr_file, "r")
            index_line = 0
            o_file.each do |line|
              line1 = line
              line1 = line.downcase unless @registr_sensetive
              seacrh_word.downcase! unless @registr_sensetive
              index_line += 1
              if @revert
                result << "#{files[index_file]}:".chomp if files.size > 1 && line1.match(/#{seacrh_word}/).nil?
                result << "#{line}" if line1.match(/#{seacrh_word}/).nil?
              else
                result << "#{files[index_file]}:".chomp if files.size > 1 && !line1.match(/#{seacrh_word}/).nil?
                result << "#{line}" unless line1.match(/#{seacrh_word}/).nil?
              end
            end
            o_file.close
            index_file += 1
          end
        end
      end
    else
      index_file = 0
      files.each do |curr_file|
        o_file = File.open(curr_file, "r")
        index_line = 0
        o_file.each do |line|
          line1 = line
          line1 = line.downcase unless @registr_sensetive
          seacrh_word.downcase! unless @registr_sensetive
          index_line += 1
          if @revert
            result << "#{files[index_file]}:".chomp if files.size > 1 && line1.match(/#{seacrh_word}/).nil?
            result << "#{line}" if line1.match(/#{seacrh_word}/).nil?
          else
            result << "#{files[index_file]}:".chomp if files.size > 1 && !line1.match(/#{seacrh_word}/).nil?
            result << "#{line}" unless line1.match(/#{seacrh_word}/).nil?
          end
        end
        o_file.close
        index_file += 1
      end
    end
    result.chomp
  end

  def key_n(seacrh_word, files)
    index_file = 0
    files.each do |curr_file|
      o_file = File.open(curr_file, "r")
      index_line = 0
      o_file.each do |line|
        line1 = line
        line1 = line.downcase unless @registr_sensetive
        seacrh_word.downcase! unless @registr_sensetive
        index_line += 1
        if @revert
          result << "#{files[index_file]}:".chomp if files.size > 1 && line1.match(/#{seacrh_word}/).nil?
          result << "#{index_line}:#{line}" if line1.match(/#{seacrh_word}/).nil?
        else
          result << "#{files[index_file]}:".chomp if files.size > 1 && !line1.match(/#{seacrh_word}/).nil?
          result << "#{index_line}:#{line}" unless line1.match(/#{seacrh_word}/).nil?
        end
      end
      o_file.close
      index_file += 1
    end
    result
  end

  def key_l(seacrh_word, files)
    flag = 0
    index_file =0
    files.each do |curr_file|
      o_file = File.open(curr_file, "r")
      index_line = 0
      flag = 0
      o_file.each do |line|
        line1 = line
        line1 = line.downcase unless @registr_sensetive
        seacrh_word.downcase! unless @registr_sensetive
        index_line += 1
        if @revert
          flag = 1 if line1.match(/#{seacrh_word}/).nil?
        else
          flag = 1 unless line1.match(/#{seacrh_word}/).nil?
        end
      end
      o_file.close
      index_file += 1
    end
    result << "#{files[index_file]}\n" if flag == 1
    result
  end

  def key_x(seacrh_word, files)
    index_file = 0
    files.each do |curr_file|
      o_file = File.open(curr_file, "r")
      index_line = 0
      o_file.each do |line|
        line1 = line
        line1 = line.downcase unless @registr_sensetive
        seacrh_word.downcase! unless @egistr_sensetive
        index_line += 1
        if @revert
          result << "#{files[index_file]}:".chomp if files.size > 1 && line1.match(/^#{seacrh_word}$/).nil?
          result << line unless line1.match(/^#{seacrh_word}$/)
        else
          result << "#{files[index_file]}:".chomp if files.size > 1 && line1.match(/^#{seacrh_word}$/)
          result << line if line1.match(/^#{seacrh_word}$/)
        end
      end
      o_file.close
      index_file += 1
    end
    result
  end

  def set_i
    @registr_sensetive = false
  end

  def set_v
    @revert = true
  end
end