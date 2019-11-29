require 'rspec'
require_relative '../lib/time_crosser.rb'

describe 'TimeCrosser' do
  context 'all is sticking' do
    it 'stiks 2 intervals' do
      crosser = TimeCrosser.new([%w[12:20 15:00], %w[12:00 14:10]])
      expect(crosser.match_time_intervals).to eq([%w[12:00 15:00]])
    end

    it 'stiks 3 intervals' do
      crosser = TimeCrosser.new([%w[13:20 15:00], %w[12:00 14:10], %w[11:00 12:10]])
      expect(crosser.match_time_intervals).to eq([%w[11:00 15:00]])
    end

    it 'stiks 4 intervals' do
      crosser = TimeCrosser.new([%w[13:20 15:00], %w[13:30 14:10], %w[11:00 16:10], %w[12:00 15:20]])
      expect(crosser.match_time_intervals).to eq([%w[11:00 16:10]])
    end
  end

  context 'some stickings' do
    it 'stiks 2 intervals' do
      crosser = TimeCrosser.new([%w[11:00 11:40], %w[13:20 15:00], %w[12:00 15:10], %w[10:00 10:20]])
      expect(crosser.match_time_intervals).to eq([%w[11:00 11:40], %w[12:00 15:10], %w[10:00 10:20]])
    end

    it 'stiks 3 intervals' do
      crosser = TimeCrosser.new([%w[10:00 10:20], %w[13:20 15:00], %w[13:30 14:10], %w[11:00 16:10], %w[12:00 15:20]])
      expect(crosser.match_time_intervals).to eq([%w[10:00 10:20], %w[11:00 16:10]])
    end
  end

  context 'no sticking' do
    it '2 intervals' do
      crosser = TimeCrosser.new([%w[13:20 15:00], %w[17:00 18:10]])
      expect(crosser.match_time_intervals).to eq([%w[13:20 15:00], %w[17:00 18:10]])
    end

    it '3 intervals' do
      crosser = TimeCrosser.new([%w[10:20 11:00], %w[13:20 15:00], %w[17:00 18:10]])
      expect(crosser.match_time_intervals).to eq([%w[10:20 11:00], %w[13:20 15:00], %w[17:00 18:10]])
    end
  end
end