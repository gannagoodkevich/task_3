require 'rspec'
require_relative 'human.rb'

describe 'Job' do
  let(:job) { double('job') }
  let(:human) { double('human') }

  describe '#feed' do
    it 'feed dog' do
      allow(job).to receive(:pay).with(human)
      allow(human).to receive(:pay)

      job.pay(human)
    end
  end
end

describe 'Human' do
  let(:pet) { double('pet') }
  let(:human) { Human.new(pet) }

  describe '#feed' do
    it 'feed dog' do
      expect(pet).to receive(:eat)

      human.feed
    end
  end
end