class Oystercard
  DEFAULT_VALUE = 0
  MAX_BALANCE = 90
  MIN_FARE = 1

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station

  def initialize
    @balance = DEFAULT_VALUE
    @in_use = false
  end

  def top_up(amount)
    fail "Maximum balance #{MAX_BALANCE} exceeded" if exceeds_max?(amount)
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def entry_station
    @entry_station
  end 

  def touch_in(station)
    fail "Insufficient funds - balance below #{MIN_FARE}" if insufficient_balance?
    @entry_station = station
  end

  def touch_out(fare, station)
    deduct(fare)
    @entry_station = nil
    @exit_station = station
  end

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


