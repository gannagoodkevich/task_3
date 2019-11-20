#require 'pry'

class TimeCrosser
  def initialize(time_intervals)
    @time_intervals = time_intervals
    @result = []
  end

  def match_time_intervals
    flag = 0
    intervals = @time_intervals
    while flag == 0
      break if intervals.size == 1
      @result = []
      prev_interval = intervals.shift
      #puts intervals
      intervals.each do |interval|
        #binding.pry
        flag = 1 unless compare(prev_interval, interval)
        #puts compare(prev_interval, interval)
        prev_interval = interval
      end
      puts "Hola"
      puts intervals
      #break if flag == 1
      intervals = @result
    end
    #puts @result
    @result
  end

  private

  def compare(first_interval, second_interval)
    time_start_first = first_interval[0].split(':')
    time_end_first = first_interval[1].split(':')
    time_start_second = second_interval[0].split(':')
    time_end_second = second_interval[1].split(':')
    compare_time(time_start_first, time_start_second, time_end_first, time_end_second)
  end

  def compare_time(time_start_first, time_start_second, time_end_first, time_end_second)
    answer = false
    if time_start_first[0] > time_start_second[0] && time_end_first[0] < time_end_second[0]
      @result << convert_result(time_start_first, time_end_second)
      answer = true
    end
    if time_start_first[0] < time_start_second[0] && time_end_first[0] < time_end_second[0]
      @result << convert_result(time_start_second, time_end_second)
      answer = true
    end
    if time_start_first[0] < time_start_second[0] && time_end_first[0] > time_end_second[0]
      @result << convert_result(time_start_second, time_end_first)
      answer = true
    end
    if time_start_first[0] > time_start_second[0] && time_end_first[0] > time_end_second[0]
      @result << convert_result(time_start_first, time_end_first)
      answer = true
    end
    if time_start_second[0] == time_end_first[0]
      if compare_minutes(time_end_first[1], time_start_second[1])
        @result << convert_result(time_start_first, time_end_second)
        answer = true
      end
    end
    if time_start_first[0] < time_start_second[0] && time_end_first[0] < time_end_second[0]
      answer = false
      @result << convert_result(time_start_first, time_end_first)
      @result << convert_result(time_start_second, time_end_second)
    end
    answer
  end

  def compare_minutes(first_minutes, second_minutes)
    first_minutes >= second_minutes
  end

  def convert_result(time_first, time_second)
    %W[#{time_first[0]}:#{time_first[1]} #{time_second[0]}:#{time_second[1]}]
  end
end

time = TimeCrosser.new([%w[13:20 15:00], %w[12:00 14:10]]).match_time_intervals
