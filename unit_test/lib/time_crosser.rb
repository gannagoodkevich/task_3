require 'pry'

class TimeCrosser
  def initialize(time_intervals)
    @time_intervals = time_intervals
  end

  def match_time_intervals
    @time_intervals.each do |interval|
      first = interval[0]
      second = interval[1]
      binding.pry
      compare_time(first, second)
    end
  end

  private

  def compare_time(first_time, second_time)
    first_time = first_time.split(':')
    second_time = second_time.split(':')
  end

  def compare_hours(hour_start_first, hour_start_second, hour_end_first, hour_end_second)
    result = Array.new
    if hour_start_first.to_i < hour_start_second.to_i && hour_end_first.to_i > hour_end_second.to_i
      result << [hour_start_first, hour_end_first]
    end
    if hour_start_first.to_i < hour_start_second.to_i && hour_end_first.to_i < hour_end_second.to_i
      result << [hour_start_first, hour_end_second]
    end
  end
end

TimeCrosser.new([['11:20', '12:00'], ['12:30', '14:10']]).match_time_intervals

