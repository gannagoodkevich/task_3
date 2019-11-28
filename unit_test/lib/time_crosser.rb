require 'pry'

class TimeCrosser
  YEAR = 2007
  MONTH = 1
  DAY = 1
  def initialize(time_intervals)
    @time_intervals = time_intervals
  end

  def match_time_intervals
    intervals = @time_intervals.map do |interval|
      convert_to_time(interval[0], interval[1])
    end
    find_matching_time(intervals)
    @result.flatten.uniq.each_slice(2).map do |time_f, time_s|
      %W[#{time_f.strftime('%H:%M')} #{time_s.strftime('%H:%M')}]
    end
  end

  private

  def convert_to_time(begin_interval, end_interval)
    begin_interval = begin_interval.split(':')
    end_interval = end_interval.split(':')
    [Time.gm(YEAR, MONTH, DAY, begin_interval[0], begin_interval[1]), Time.gm(YEAR, MONTH, DAY, end_interval[0], end_interval[1])]
  end

  def find_matching_time(intervals)
    continue_sticking = true
    while continue_sticking
      break if intervals.size == 1

      @result = []
      continue_sticking = false
      intervals.each_cons(2) do |prev_interval, interval|
        if prev_interval[0] <= interval[1] && prev_interval[1] >= interval[0]
          @result << prev_interval.concat(interval).minmax
          @result.delete(prev_interval) if continue_sticking == false
          continue_sticking = true
        else
          @result << prev_interval << interval
        end
      end
      intervals = @result.uniq
    end
  end
end