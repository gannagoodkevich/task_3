require 'pry'

class TimeCrosser
  def initialize(time_intervals)
    @time_intervals = time_intervals
    @result = []
  end

  def match_time_intervals
    flag = 0
    intervals = @time_intervals.map do |interval|
      convert_to_time(interval[0], interval[1])
    end
    puts intervals.inspect
    puts "INTERVALS"
    puts intervals.inspect
    puts "-^-"
    @result = []
    flag = 1
    prev_interval = intervals.shift
    intervals.each do |interval|
      #@result = @result.flatten
      interval = interval.flatten
      puts "--PREV--"
      puts prev_interval.inspect
      puts "--INT--"
      puts interval.inspect
      puts "---"
      if compare(prev_interval, interval) || compare(interval, prev_interval)
        puts "HOLA"
        puts @result.inspect
        flag = 0
      end
      puts "INTERVALS"
      puts intervals.inspect
      puts "-^-"
    end
    intervals = @result.uniq
    puts "--RES--"
    puts @result.uniq.flatten.inspect
    @result = @time_intervals if @result == []
    answer = []
    @result.flatten.uniq.each_slice(2) do |time_f, time_s|
      answer << %W[#{time_f} #{time_s}]
    end
    answer
  end

  private

  def compare(first, second)
    flag = true
    result = first
    puts first[0].inspect
    puts second[0].inspect
    puts "Star checking"
    if first[0].between?(second[0], second[1])
      result[0] = second[0]
    end
    if first[1].between?(second[0], second[1])
      result[1] = second[1]
    end
    unless first[0].between?(second[0], second[1]) || first[1].between?(second[0], second[1])
      flag = false
      result = []
    end
    #puts flag
    @result << result
    flag
  end

  def convert_to_time(begin_interval, end_interval)
    begin_interval = begin_interval.split(':')
    end_interval = end_interval.split(':')
    return Time.gm(1999, 12, 10, begin_interval[0], begin_interval[1]), Time.gm(1999, 12, 10, end_interval[0], end_interval[1])
  end

  def convert_result(time_first, time_second)
    %W[#{time_first.strftime('%H:%M')} #{time_second.strftime('%H:%M')}]
  end
end