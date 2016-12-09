class Train
  attr_accessor :wagons, :speed
  attr_reader :type, :id, :route

  def initialize(id, type, speed = 0)
    @id = id
    @type = type
    @wagons = []
    @speed = speed
  end

  def get_route(route)
    @route = route
    @current_station_index = 0
  end

  def go_to_next_station
    if @route
      current_station.send_train(self)
      next_station.get_train(self)
      @current_station_index += 1
    else
      "Train doesn't have route"
    end
  end

  def speed_up
    self.speed += 50
  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    return "Stop the train first!" if self.speed > 0
    wagon.type == self.type ? self.wagons << wagon : "Wrong type of wagon!"
  end

  def remove_wagon(wagon)
    return "Stop the train first!" if self.speed > 0
    self.wagons.delete(wagon)
  end

  def current_station
    @route ? @route.stations[@current_station_index] :  "Train doesn't have route"
  end

  def next_station
    @route ? @route.stations[@current_station_index + 1] : "Train doesn't have route"
  end

  def previous_station
    @route ? @route.stations[@current_station_index - 1] : "Train doesn't have route"
  end

  private

  attr_reader :current_station_index
end

