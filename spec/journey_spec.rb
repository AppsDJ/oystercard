require 'journey'

describe Journey do

  context 'on initialize' do
    let(:subject) { described_class.new }
    it 'creates holder for point of entry into the journey' do
      expect(subject.a_journey[:entry_station]).to eq nil
    end
    it "knows the journey not to be complete" do
      expect(subject.complete).to eq false
    end
  end

  context 'on journey start' do
    let(:entry_station) { double :entry_station }
    it 'adds an entry point to the journey' do
      subject.start_journey(entry_station)
      expect(subject.a_journey[:entry_station]).to eq entry_station
    end
  end

  context 'on checking journey completion' do
    let(:exit_station) { double :exit_station }
    it 'shows journey to have been completed' do
      subject.finish_journey(exit_station)
      expect(subject.complete?).to eq true
    end
    it 'shows journey to have not to been completed' do
      expect(subject.complete?).to eq false
    end
  end

  context 'on journey end' do
    let(:exit_station) { double :exit_station }
    it 'adds an exit point to the journey' do
      subject.finish_journey(exit_station)
      expect(subject.a_journey[:exit_station]).to eq exit_station
    end
  end

  context 'on fare calculation' do
    let(:entry_station) { double :entry_station }
    let(:exit_station) { double :exit_station }
    it 'returns the minmum fare if journey includes both entry and exit stations' do
      subject.start_journey(entry_station)
      subject.finish_journey(exit_station)
      expect(subject.fare).to eq Journey::MIN_FARE
    end
    it 'returns the penalty fare if journey does not include entry station' do
      subject.finish_journey(exit_station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
    it 'returns the penalty fare if journey does not include exit station' do
      subject.start_journey(entry_station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end


end
