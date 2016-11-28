class Train
  attr_accessor :wagons_count, :speed
  attr_reader :type, :id, :route, :current_station_index

  def initialize(id, type, wagons_count = 0, speed = 0)
    @id = id
    @type = type
    @wagons_count = wagons_count
    @speed = speed
  end

  def get_route(route)
    @route = route
    @current_station_index = 0
  end

  def go_to_next_station
    if @route
      next_station = @route.stations[@current_station_index + 1]
      @route.stations[@current_station_index].send_train(self)
      next_station.get_train(self)
      @current_station_index += 1
    else
      "Train doesn't have route"
    end
  end

  def current_station
    @route ? @route.stations[@current_station_index] : "Train doesn't have route"
  end

  def next_station
    @route ? @route.stations[@current_station_index + 1] : "Train doesn't have route"
  end

  def previous_station
    @route ? @route.stations[@current_station_index - 1] : "Train doesn't have route"
  end

  def speed_up
    self.speed += 50
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    if self.speed == 0
      self.wagons_count += 1
    else
      "Stop the train first!"
    end
  end

  def remove_wagon
    if self.speed == 0 && self.wagons_count > 0
      self.wagons_count -= 1
    else
      "Stop the train or/and add wagons!"
    end
  end
end

