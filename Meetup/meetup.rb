=begin
Write your code for the 'Meetup' exercise in this file. Make the tests in
`meetup_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/meetup` directory.
=end
require 'date'

class Meetup
  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(name_of_day, attribute)
    day_index = 0
    attr_index = 0
    case name_of_day
      when :monday
        day_index = 1
      when :tuesday
        day_index = 2
      when :wednesday
        day_index = 3
      when :thursday
        day_index = 4
      when :friday
        day_index = 5
      when :saturday
        day_index = 6
      when :sunday
        day_index = 7
    end
    case attribute
    when :first
      for i in 1..10
        curr_date = Date.new(@year, @month, i)
        return curr_date if curr_date.cwday == day_index
      end
    when :second
      flag = 0
      for i in 1..20
        curr_date = Date.new(@year, @month, i)
        flag +=1 if curr_date.cwday == day_index
        return curr_date if flag == 2
      end
    when :third
      flag = 0
      for i in 1..30
        curr_date = Date.new(@year, @month, i)
        flag +=1 if curr_date.cwday == day_index
        return curr_date if flag == 3
      end
    when :fourth
      flag = 0
      for i in 1..31
        curr_date = Date.new(@year, @month, i)
        flag +=1 if curr_date.cwday == day_index
        return curr_date if flag == 4
      end
    when :last
      if @month == 12
        curr_date = Date.new(@year, @month, 31)
        while curr_date.cwday != day_index
          curr_date = curr_date - 1
        end
      else
        curr_date = Date.new(@year, @month+1, 1).prev_day
        while curr_date.cwday != day_index
          curr_date = curr_date - 1
        end
      end
      return curr_date
    when :teenth
      for i in 13..19
        curr_date = Date.new(@year, @month, i)
        return curr_date if curr_date.cwday == day_index
      end
    end
  end
end
