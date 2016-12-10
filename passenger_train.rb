require_relative 'train'

class PassengerTrain < Train
  def initialize(id, speed = 0)
    super
    @type = :passenger
  end
end