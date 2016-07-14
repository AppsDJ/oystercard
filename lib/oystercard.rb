class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1
  attr_reader :balance
  attr_reader :entry_station, :journey, :journeys

  # journeys =
  #           [
  #             {entry_station: ["Ealing", 1], exit_station: ["Earls Court", 2]}
  #             {entry_station: ["Ealing", 1, exit_station: ["Earls Court", 2]}
  #           ]

  def initialize
    @balance = 0
    @journey = {}
    @journeys = []
  end

  def top_up(amount)
    raise "Exceeds max allowed amount of #{MAX_BALANCE}" if balance_exceeds_limit?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise "insufficient funds" if insufficient_funds?
    @entry_station = entry_station
    journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @entry_station = nil
    journey[:exit_station] = exit_station
  end

  def in_journey?
     entry_station == nil ? false : true
  end

  def log_journeys(journey)
    @journeys << journey
  end

  private

  def insufficient_funds?
    balance < MIN_BALANCE
  end

  def balance_exceeds_limit?(amount)
    balance + amount > MAX_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

end
