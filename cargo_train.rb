require_relative 'train'

class CargoTrain < Train
  def initialize(id, speed = 0)
    super
    @type = :cargo
  end
end