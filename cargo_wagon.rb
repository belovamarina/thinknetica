require_relative 'wagon'

class CargoWagon < Wagon
  def initialize(type)
    super(:cargo)
  end
end