require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :space
  attr_accessor :taken_space

  def initialize(space)
    super(:cargo)
    @space = space
  end

  def take_space
    self.taken_space += 1
  end

  def free_space
    self.space - self.taken_space
  end
end