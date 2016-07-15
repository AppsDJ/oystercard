require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1
  attr_reader :balance
  attr_reader :journey, :journeys

  def initialize
    @balance = 0
    @journey = Journey.new
    @journeys = []
  end

  def top_up(amount)
    raise "Exceeds max allowed amount of #{MAX_BALANCE}" if balance_exceeds_limit?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise "insufficient funds" if insufficient_funds?
    journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    journey.finish_journey(exit_station)
    log_journeys
  end

  def in_journey?
     if journey.journey_start == false || journey.complete?
       false
     else
       true
     end
  end

  def log_journeys
    @journeys << journey.a_journey
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
