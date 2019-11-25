require 'date'

class Meetup
  WEEK = 7
  TWO_WEEKS = 14
  THREE_WEEKS = 21
  LAST_MONTH = 12
  DAY_INDEXES = {monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7}
  def initialize(month, year)
    @date = Date.new(year, month)
  end

  def day(day, schedule)
    day_index = DAY_INDEXES[day]
    @date += 1 until @date.cwday == day_index unless schedule == :last

    case schedule
    when :second
      @date += WEEK
    when :third
      @date += TWO_WEEKS
    when :fourth
      @date += THREE_WEEKS
    when :teenth
      @date += WEEK until (13..19).include?(@date.day)
    when :last
      year = @date.month == LAST_MONTH ? @date.year + 1 : @date.year
      @date = Date.new(year, @date.month == LAST_MONTH ? 1 : @date.month + 1) - 1
      @date -= 1 until @date.send("#{day}?")
    end
    @date
  end
end