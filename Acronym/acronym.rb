class Acronym
  def create_acronym(string)
    words = string.split(" ")
    print "The acronym is: "
    words.each {|word| print word[0].upcase}
    puts
  end
end

puts "Enter the phrase you want to make acronym"
phrase = gets.chomp
acr = Acronym.new
acr.create_acronym(phrase)
