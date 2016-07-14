require 'station'

describe Station do

  context 'on initialize' do
    let(:subject) { Station.new("entry station", 1) }
    it 'creates holder for station name' do
      expect(subject.station[0]).to eq "entry station"
    end
    it 'creates holder for the zone' do
      expect(subject.station[1]).to eq 1
    end
  end

end
