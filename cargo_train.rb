require_relative 'train'

class CargoTrain < Train
  def initialize(id, speed = 0)
    @id = id
    @type = :cargo
    @wagons = []
    @speed = speed
  end
end