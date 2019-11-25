# frozen_string_literal: true

# Write your code for the 'Meetup' exercise in this file. Make the tests in
# `meetup_test.rb` pass.
#
# To get started with TDD, see the `README.md` file in your
# `ruby/meetup` directory.
require 'date'

FIRST_DAY_MONTH = 1
SECOND_WEEK_FIRST_DAY_MONTH = 8
THIRD_WEEK_FIRST_DAY_MONTH = 15
FOURTH_WEEK_FIRST_DAY_MONTH = 22
FIRST_TEENTH_DAY_MONTH = 13
LAST_DAY_MONTH = 31
LAST_MONTH = 12


class Meetup
  def initialize(month, year)
    @month = month
    @year = year
    @day_hash = {monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7}
  end

  def day(name_of_day, attribute)
    day_index = 0
    attr_index = 0
    case name_of_day
    when :monday
      day_index = @day_hash[:monday]
    when :tuesday
      day_index = @day_hash[:tuesday]
    when :wednesday
      day_index = @day_hash[:wednesday]
    when :thursday
      day_index = @day_hash[:thursday]
    when :friday
      day_index = @day_hash[:friday]
    when :saturday
      day_index = @day_hash[:saturday]
    when :sunday
      day_index = @day_hash[:sunday]
    end
    case attribute
    when :first
      curr_date = Date.new(@year, @month, FIRST_DAY_MONTH)
      curr_date += 1 until curr_date.cwday == day_index
      return curr_date
    when :second
      curr_date = Date.new(@year, @month, SECOND_WEEK_FIRST_DAY_MONTH)
      curr_date += 1 until curr_date.cwday == day_index
      return curr_date
    when :third
      curr_date = Date.new(@year, @month, THIRD_WEEK_FIRST_DAY_MONTH)
      curr_date += 1 until curr_date.cwday == day_index
      return curr_date
    when :fourth
      curr_date = Date.new(@year, @month, FOURTH_WEEK_FIRST_DAY_MONTH)
      curr_date += 1 until curr_date.cwday == day_index
      curr_date
    when :last
      curr_date =
        if @month == LAST_MONTH
          Date.new(@year, @month, LAST_DAY_MONTH)
        else
          Date.new(@year, @month + 1, FIRST_DAY_MONTH).prev_day
        end
      curr_date -= 1 until curr_date.cwday == day_index
      return curr_date
    when :teenth
      curr_date = Date.new(@year, @month, FIRST_TEENTH_DAY_MONTH)
      curr_date += 1 until curr_date.cwday == day_index
      curr_date
    end
  end
end
