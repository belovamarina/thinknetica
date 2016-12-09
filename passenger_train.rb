require_relative 'train'

class PassengerTrain < Train
  def initialize(id, speed = 0)
    @id = id
    @type = :passenger
    @wagons = []
    @speed = speed
  end
end