class Grep
  def self.grep(pattern, flags, files)
    results = []
    files.each do |file|
      File.read(file).lines.each_with_index do |line, index|
        match_pattern = Regexp.new(
            flags.include?('-x') ? "^#{pattern}$" : pattern,
            (Regexp::IGNORECASE if flags.include?('-i')))
        next unless line.match?(match_pattern) ^ flags.include?('-v')
        break results << file if flags.include?('-l')
        answer_string = []
        answer_string.push("#{file}:") unless files.one?
        answer_string.push("#{index + 1}:") if flags.include?('-n')
        answer_string.push(line.rstrip)
        results.push answer_string.join
      end
    end
    results.join("\n")
  end
end