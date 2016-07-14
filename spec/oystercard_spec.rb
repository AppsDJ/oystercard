require 'oystercard'

describe Oystercard do

  let(:station){ double(:station) }
  let(:entry_station){ double(:entry_station) }
  let(:exit_station){ double(:exit_station) }

  #REMINDER: when any of the symbols above shows in an 'expect' statement
  # [ e.g. expect(subject.entry_station)) ] then they are the actual variable

  context "initial state of Oystercard" do
    it 'returns the initial balance of 0' do
      expect(subject.balance).to eq 0
    end
    it 'shows status as not in journey when initiated' do
      expect(subject).not_to be_in_journey
    end
  end

  context "on top up" do
    it 'raises error if balance exceeds max amount' do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect{ subject.top_up(1) }.to raise_error("Exceeds max allowed amount of #{max_balance}")
    end
  end

  context "on touch in" do
    it 'sets card status to "in journey"' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end
    it "raises error if minimum balance is not available" do
      expect{ subject.touch_in(station) }.to raise_error("insufficient funds")
    end
    it "logs the entry station" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  context 'on touch out' do
    it 'sets card status to "not in journey"' do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
    it "deducts minimum fare" do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by (-Oystercard::MIN_FARE)
    end
    it "resets entry station at touch_out" do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end
  end

  context "on logging journeys" do
    before(:each) do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end
    it 'checks if the Oystercard stores a log for one journey' do
      expect(subject.journey.key(exit_station)).to eq :exit_station
    end
    let(:journey) { double :journey }
    it 'checks it the Oystercard storesa a log for all journeys' do
      subject.log_journeys(journey)
      expect(subject.journeys).to include journey
    end
  end
end
