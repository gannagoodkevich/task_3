=begin
Write your code for the 'Acronym' exercise in this file. Make the tests in
`acronym_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/acronym` directory.
=end
class Acronym
  def Acronym.abbreviate(string)
    words = string.split(" ")
    acr = ""
    words.each do |word|
      acr << word[0].upcase if word[0].match(/[a-zA-Z]/)
      if word.match(/-[a-z]/)
        acr << word.split('-')[1][0].upcase
      end
    end
    return acr
  end
end
