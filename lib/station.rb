class Station
  attr_reader :station
  def initialize(name, zone)
    @station = [name, zone]
  end
end
