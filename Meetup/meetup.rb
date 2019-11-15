# frozen_string_literal: true

# Write your code for the 'Meetup' exercise in this file. Make the tests in
# `meetup_test.rb` pass.
#
# To get started with TDD, see the `README.md` file in your
# `ruby/meetup` directory.
require 'date'

class Meetup
  def initialize(month, year)
    @month = month
    @year = year
    @day_hash = { monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7 }
  end

  def day(name_of_day, attribute)
    day_index = send("#{name_of_day}_index")
    send("#{attribute}_day", day_index)
  end

  def monday_index
    @day_hash[:monday]
  end

  def tuesday_index
    @day_hash[:tuesday]
  end

  def wednesday_index
    @day_hash[:wednesday]
  end

  def thursday_index
    @day_hash[:thursday]
  end

  def friday_index
    @day_hash[:friday]
  end

  def saturday_index
    @day_hash[:saturday]
  end

  def sunday_index
    @day_hash[:sunday]
  end

  def first_day(day_index)
    curr_date = Date.new(@year, @month, 1)
    curr_date += 1 until curr_date.cwday == day_index
    curr_date
  end

  def second_day(day_index)
    curr_date = Date.new(@year, @month, 8)
    curr_date += 1 until curr_date.cwday == day_index
    curr_date
  end

  def third_day(day_index)
    curr_date = Date.new(@year, @month, 15)
    curr_date += 1 until curr_date.cwday == day_index
    curr_date
  end

  def fourth_day(day_index)
    curr_date = Date.new(@year, @month, 22)
    curr_date += 1 until curr_date.cwday == day_index
    curr_date
  end

  def last_day(day_index)
    curr_date =
      if @month == 12
        Date.new(@year, @month, 31)
      else
        Date.new(@year, @month + 1, 1).prev_day
      end
    curr_date -= 1 until curr_date.cwday == day_index
    curr_date
  end

  def teenth_day(day_index)
    curr_date = Date.new(@year, @month, 13)
    curr_date += 1 until curr_date.cwday == day_index
    curr_date
  end
end
