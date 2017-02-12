class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def show_route
    stations.map(&:name)
  end

  def add_station(index = -2, station)
    @stations.insert(index, station)
  end

  def remove_station(station)
    @stations.delete(station)
  end
end
