require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Company
  include InstanceCounter
  extend Validation

  attr_accessor :wagons, :speed
  attr_reader :type, :id, :route
  validate :id, format: /^[a-z0-9]{3}-*[a-z0-9]{2}$/i

  @@trains = []

  def initialize(id, type, speed = 0)
    @id = id
    @type = type
    @wagons = []
    @speed = speed
    #
    # validate!(id)
    register_instance
    register_train
  end

  def self.find(id)
    @@trains.find { |train| train.id == id }
  end

  def self.clear_trains
    @@trains = []
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
    wagon.type == type ? wagons << wagon : 'Wrong type of wagon!'
  end

  def remove_wagon(wagon)
    return 'Stop the train first!' if self.speed > 0
    wagons.delete(wagon)
  end

  def current_station
    @route.stations[@current_station_index]
  rescue
    NoMethodError "Train doesn't have route"
  end

  def next_station
    @route.stations[@current_station_index + 1]
  rescue
    NoMethodError "Train doesn't have route"
  end

  def previous_station
    @route.stations[@current_station_index - 1]
  rescue
    NoMethodError "Train doesn't have route"
  end

  def call_block
    wagons.each do |wagon|
      yield(wagon)
    end
  end

  protected

  attr_reader :current_station_index

  def register_train
    @@trains << self
  end
end
