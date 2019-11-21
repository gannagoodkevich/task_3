require 'pry'

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
      flag = 1
      prev_interval = intervals.shift
      #puts intervals
      #binding.pry
      intervals.each do |interval|
        flag = 0 if compare(prev_interval, interval)
        prev_interval = interval
      end
      puts "Hola"
      intervals = @result
      puts @result
    end
    #puts @result
    puts "--ANS--"
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
      @result << convert_result(time_start_second, time_end_second)
      answer = true
    end
    if time_start_first[0] < time_start_second[0] && time_end_first[0] < time_end_second[0]
      @result << convert_result(time_start_first, time_end_second)
      answer = true
    end
    if time_start_first[0] < time_start_second[0] && time_end_first[0] > time_end_second[0]
      @result << convert_result(time_start_first, time_end_first)
      answer = true
    end
    if time_start_first[0] > time_start_second[0] && time_end_first[0] > time_end_second[0]
      @result << convert_result(time_start_second, time_end_first)
      answer = true
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

time = TimeCrosser.new([%w[13:20 15:00], %w[12:00 14:10], %w[11:00 12:10]]).match_time_intervals
