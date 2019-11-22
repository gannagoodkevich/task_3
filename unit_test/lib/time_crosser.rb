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
        if compare(prev_interval, interval)
          @result.delete(prev_interval) if flag == 1
          flag = 0
        end
        prev_interval = interval
      end
      puts "Hola"
      intervals =  @result.uniq
      puts @result
    end
    #puts @result
    puts "--ANS--"
    if @result == []
      @result = @time_intervals
    end
   @result.uniq
  end

  private

  def compare(first_interval, second_interval)
    @time_start_first = first_interval[0].split(':')
    @time_end_first = first_interval[1].split(':')
    @time_start_second = second_interval[0].split(':')
    @time_end_second = second_interval[1].split(':')
    compare_time
  end

  def compare_time
    answer = false
    if @time_start_second[0] <= @time_end_first[0] && @time_start_first[0] <=  @time_end_second[0]
      choose_result_interval(@time_start_first[0], @time_start_second[0], @time_end_first[0], @time_end_second[0])
      answer = true
    else
      answer = false
      @result << convert_result(@time_start_first, @time_end_first)
      @result << convert_result(@time_start_second, @time_end_second)
    end
    answer
  end

  def compare_minutes(first_minutes, second_minutes)
    first_minutes >= second_minutes
  end

  def choose_result_interval(time_start_first, time_start_second, time_end_first, time_end_second)
    if time_start_first >= time_start_second && time_end_first < time_end_second
      checking_for_equality(time_start_first, time_start_second, :beginning, @time_start_second, @time_end_second)
    end
    if time_start_first < time_start_second && time_end_first < time_end_second
      @result << convert_result(@time_start_first, @time_end_second)
    end
    if time_start_first < time_start_second && time_end_first >= time_end_second
      checking_for_equality(time_end_first, time_end_second, :ending, @time_start_first, @time_end_first)
    end
    if time_start_first >= time_start_second && time_end_first >= time_end_second
      checking_for_equality(time_start_first, time_start_second, :beginning, @time_start_second, @time_end_first)
      checking_for_equality(time_end_first, time_end_second, :ending, @time_start_second, @time_end_first)
    end
  end

  def convert_result(time_first, time_second)
    %W[#{time_first[0]}:#{time_first[1]} #{time_second[0]}:#{time_second[1]}]
  end

  def checking_for_equality(comp_time_first, comp_time_second, time_type, answer_first, answer_second)
    case time_type
    when :beginning
      if comp_time_first == comp_time_second && @time_start_first != @time_start_second
        choose_result_interval(@time_start_first[1], @time_start_second[1], @time_end_first[0], @time_end_second[0])
      else
        @result << convert_result(answer_first, answer_second)
      end
    when :ending
      if comp_time_first == comp_time_second && @time_end_first != @time_end_second
        choose_result_interval(@time_start_first[0], @time_start_second[0], @time_end_first[1], @time_end_second[1])
      else
        @result << convert_result(answer_first, answer_second)
      end
    end
  end
end
