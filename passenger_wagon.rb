require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :places
  attr_accessor :taken_places

  def initialize(places)
    super(:passenger)
    @places = places
    @taken_places = 0
  end

  def take_place
    self.taken_places += 1
  end

  def free_places
    places - self.taken_places
  end
end
