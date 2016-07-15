class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6
  attr_reader :a_journey, :complete, :journey_start

  def initialize
    @a_journey = {}
    @complete = false
    @journey_start = false
  end

  def start_journey(entry_station)
    @journey_start = true
    @a_journey[:entry_station] = entry_station
  end

  def finish_journey(exit_station)
    @journey_start = false
    @a_journey[:exit_station] = exit_station
    @complete = true
  end

  def fare
    return MIN_FARE if @a_journey[:entry_station] && @a_journey[:exit_station]
    PENALTY_FARE
  end

  def complete?
    @complete
  end

end
