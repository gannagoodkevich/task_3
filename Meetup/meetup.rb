require 'date'

class Meetup
  WEEK = 7
  LAST_MONTH = 12

  def initialize(month, year)
    @date = Date.new(year, month)
  end

  def day(day, schedule)
    @date += 1 until @date.send("#{day}?") unless schedule == :last

    case schedule
    when :second
      @date += WEEK
    when :third
      @date += 2 * WEEK
    when :fourth
      @date += 3 * WEEK
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