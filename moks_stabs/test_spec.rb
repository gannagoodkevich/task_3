require 'rspec'
require_relative 'human.rb'

describe 'Job' do
  let(:job) { double('job') }
  let(:human) { Human.new }

  describe '#feed' do
    it 'feed dog' do
      allow(job).to receive(:pay)
                          .and_return(human.pay)
      expect(job).to receive(:pay)

      expect(job.pay(human)).to eq("The human is happy")
    end
  end
end

describe 'Dog' do
  let(:human) { double('human') }
  let(:dog) { Dog.new }

  describe '#feed' do
    it 'feed dog' do
      allow(human).to receive(:feed)
                          .and_return(dog.feed)
      expect(human).to receive(:feed)

      expect(human.feed(dog)).to eq("Dog is happy")
    end
  end
end