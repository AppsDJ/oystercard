require 'station'

describe Station do

  context 'on initialize' do
    let(:subject) { Station.new("entry station", 1) }
    # OR
    #  let(:subject) { described_class.new("entry station", 1) }
    # NOTES: LET WILL ONLY BE EXECUTED IF IT IS NEEDED
    # OR
    #  subject {described_class.new(name: "Old Street", zone: 1)}
    # NOTES: LINE ABOVE WILL ALWAYS BE EXECUTED IF WHENEVER IT APPEARS IN CODE
    it 'creates holder for station name' do
      expect(subject.station[0]).to eq "entry station"
    end
    it 'creates holder for the zone' do
      expect(subject.station[1]).to eq 1
    end
  end

end
