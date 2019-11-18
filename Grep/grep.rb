class Grep
  class << self
    def grep(search_word, flags, files)
      @registr_sensetive = true
      @revert = false
      @strict_match = false
      result = if !flags.empty?
                 handle_flags(flags, search_word, files)
               else
                 handle_empty_flags(search_word, files)
               end
      result.chomp
    end

    def key_n(search_word, files)
      result = ''
      index_file = 0
      files.each do |curr_file|
        o_file = File.open(curr_file, 'r')
        index_line = 0
        o_file.each do |line|
          line1 = line
          line1 = line.downcase unless @registr_sensetive
          search_word.downcase! unless @registr_sensetive
          index_line += 1
          result << if @revert
                      reverse_n(search_word, files, index_file, index_line, line1, line)
                    else
                      normal_n(search_word, files, index_file, index_line, line1, line)
                    end
        end
        o_file.close
        index_file += 1
      end
      result
    end

    def key_l(search_word, files)
      result = ''
      index_file = 0
      files.each do |curr_file|
        o_file = File.open(curr_file, 'r')
        index_line = 0
        flag = 0
        o_file.each do |line|
          line1 = line
          line1 = line.downcase unless @registr_sensetive
          search_word.downcase! unless @registr_sensetive
          index_line += 1
          if @revert
            flag = 1 if line1.match(/#{search_word}/).nil?
          else
            flag = 1 unless line1.match(/#{search_word}/).nil?
          end
        end
        o_file.close
        result << "#{files[index_file]}\n" if flag == 1
        index_file += 1
      end
      result
    end

    def set_x
      @strict_match = true
    end

    def set_i
      @registr_sensetive = false
    end

    def set_v
      @revert = true
    end

    private

    def handle_empty_line(search_word, files)
      result = ''
      index_file = 0
      files.each do |curr_file|
        o_file = File.open(curr_file, 'r')
        index_line = 0
        o_file.each do |line|
          line1 = line
          line1 = line.downcase unless @registr_sensetive
          search_word.downcase! unless @registr_sensetive
          index_line += 1
          if @revert
            if files.size > 1 && line1.match(/#{search_word}/).nil?
              result << "#{files[index_file]}:".chomp
            end
            if @strict_match
              result << line unless line1.match(/^#{search_word}$/)
            else
              result << "#{line}" if line1.match(/#{search_word}/).nil?
            end
          else
            if files.size > 1 && !line1.match(/#{search_word}/).nil?
              result << "#{files[index_file]}:".chomp
            end
            if @strict_match
              result << line if line1.match(/^#{search_word}$/)
            else
              result << line unless line1.match(/#{search_word}/).nil?
            end
          end
        end
        o_file.close
        index_file += 1
      end
      result
    end

    def handle_empty_flags(search_word, files)
      result = ''
      index_file = 0
      files.each do |curr_file|
        o_file = File.open(curr_file, 'r')
        index_line = 0
        o_file.each do |line|
          line1 = line
          index_line += 1
          if files.size > 1 && !line1.match(/#{search_word}/).nil?
            result << "#{files[index_file]}:".chomp
          end
          result << line unless line1.match(/#{search_word}/).nil?
        end
        o_file.close
        index_file += 1
      end
      result
    end

    def handle_flags(flags, search_word, files)
      result = ''
      flags.each do |flag|
        if respond_to?("set_#{flag.gsub('-', '')}")
          send("set_#{flag.gsub('-', '')}")
        end
      end
      flags.each do |flag|
        if respond_to?("key_#{flag.gsub('-', '')}")
          result = send("key_#{flag.gsub('-', '')}", search_word, files)
        end
      end
      result = handle_empty_line(search_word, files) if result == ''
      result
    end

    def reverse_n(search_word, files, index_file, index_line, line1, line)
      result = ''
      if files.size > 1 && line1.match(/#{search_word}/).nil?
        result << "#{files[index_file]}:".chomp
      end
      if @strict_match
        result << "#{index_line}:#{line}" unless line1.match(/^#{search_word}$/)
      else
        result << "#{index_line}:#{line}" if line1.match(/#{search_word}/).nil?
      end
      result
    end

    def normal_n(search_word, files, index_file, index_line, line1, line)
      result = ''
      if files.size > 1 && !line1.match(/#{search_word}/).nil?
        result << "#{files[index_file]}:".chomp
      end
      if @strict_match
        if line1.match(/^#{search_word}$/)
          result << "#{index_line}:#{line}"
        end
      else
        unless line1.match(/#{search_word}/).nil?
          result << "#{index_line}:#{line}"
        end
      end
      result
    end
  end
end
