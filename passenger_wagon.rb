require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(type)
    super(:passenger)
  end
end