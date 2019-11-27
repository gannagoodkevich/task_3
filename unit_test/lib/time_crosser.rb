require 'pry'

class TimeCrosser
  def initialize(time_intervals)
    @time_intervals = time_intervals
    @result = []
  end

  def match_time_intervals
    flag = 0
    intervals = []
    @time_intervals.each do |interval|
      intervals << convert_to_range(interval[0], interval[1])
    end
    while flag.zero?
      break if intervals.size == 1

      @result = []
      flag = 1
      prev_interval = intervals.shift
      intervals.each do |interval|
        @result = @result.flatten
        if compare(prev_interval, interval)
          @result.delete(prev_interval) if flag == 1
          flag = 0
        end
        prev_interval = interval
      end
      intervals = @result.flatten.uniq
    end
    @result = @time_intervals if @result == []
    answer = []
    @result.flatten.uniq.each do |interval|
      answer << convert_result(interval.begin, interval.end)
    end
    answer
  end

  private

  def compare(first, second)
    flag = true
    if first.cover?(second.begin) && first.cover?(second.end)
      result = first
    elsif second.cover?(first.begin) && second.cover?(first.end)
      result = second
    elsif first.cover?(second.begin) && second.cover?(first.end)
      result = first.begin..second.end
    elsif second.cover?(first.begin) && first.cover?(second.end)
      result = second.begin..first.end
    else
      flag = false
      result = []
      result << first
      result << second
    end
    @result << result
    flag
  end

  def convert_to_range(begin_interval, end_interval)
    begin_interval = begin_interval.split(':')
    end_interval = end_interval.split(':')
    begin_numeric = begin_interval[0].to_i * 100 + begin_interval[1].to_i
    end_numeric = end_interval[0].to_i * 100 + end_interval[1].to_i
    begin_numeric..end_numeric
  end

  def convert_result(time_first, time_second)
    time_first = [time_first / 100, time_first % 100]
    time_second = [time_second / 100, time_second % 100]
    time_interval = %W[#{time_first[0]}:#{time_first[1]} #{time_second[0]}:#{time_second[1]}]
    time_interval.map { |interval| interval.gsub(':0', ':00') }
  end
end