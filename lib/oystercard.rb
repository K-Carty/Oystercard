require 'oystercard'
require 'station'
require 'journey'

class Oystercard
  DEFAULT_VALUE = 0
  MAX_BALANCE = 90
  # MIN_FARE = 1

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  # attr_reader :journeys


  def initialize
    @balance = DEFAULT_VALUE
    @in_use = false
    # @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance #{MAX_BALANCE} exceeded" if exceeds_max?(amount)
    @balance += amount
  end

  # def in_journey?
  #   !!entry_station
  # end


  # def touch_in(entry_station)
  #   fail "Insufficient funds - balance below #{MIN_FARE}" if insufficient_balance?
  #   @entry_station = entry_station
  # end

  # def touch_out(fare, exit_station)
  #   deduct(fare)
  #   @journeys << {entry_station: entry_station, exit_station: exit_station}
  #   @entry_station = nil
  #   @exit_station = exit_station
  # end

  private

  attr_reader :in_use 

  def exceeds_max?(amount)
    balance + amount > MAX_BALANCE
  end

  def insufficient_balance?
    balance < MIN_FARE
  end

  def deduct(fare)
    @balance -= fare
  end
end


