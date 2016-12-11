require_relative 'company'
require_relative 'instance_counter'

class Train
  include Company
  include InstanceCounter
  attr_accessor :wagons, :speed
  attr_reader :type, :id, :route

  @@trains = []

  def initialize(id, type, speed = 0)
    @id = id
    @type = type
    @wagons = []
    @speed = speed

    validate!(id)
    register_instance
    register_train
  end

  def self.find(id)
    @@trains.find { |train| train.id == id }
  end

  def self.clear_trains
    @@trains = []
  end

  def valid?(train)
    validate!(train.id)
  rescue StandardError
    false
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
    return 'Stop the train first!' if self.speed > 0
    wagon.type == self.type ? self.wagons << wagon : 'Wrong type of wagon!'
  end

  def remove_wagon(wagon)
    return 'Stop the train first!' if self.speed > 0
    self.wagons.delete(wagon)
  end

  def current_station
    @route.stations[@current_station_index] rescue NoMethodError "Train doesn't have route"
  end

  def next_station
    @route.stations[@current_station_index + 1] rescue NoMethodError "Train doesn't have route"
  end

  def previous_station
    @route.stations[@current_station_index - 1] rescue NoMethodError "Train doesn't have route"
  end

  protected

  VALID_ID = /^[a-z0-9]{3}-*[a-z0-9]{2}$/i
  attr_reader :current_station_index

  def validate!(id)
    raise 'Wrong type of train id' if id !~ VALID_ID
    true
  end

  def register_train
    @@trains << self
  end
end

