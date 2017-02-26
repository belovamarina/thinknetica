require 'byebug'
require_relative 'validation'

class Station
  extend Validation

  attr_reader :name, :trains
  validate :name, presence: true, type: String
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []

    @@all_stations << self
  end

  def self.all
    @@all_stations
  end

  def self.clear_all_stations_count
    @@all_stations = []
  end

  def get_train(train)
    @trains << train
  end

  def show_trains(type = :all)
    if type == :all
      "#{type} - #{trains.size}"
    else
      "#{type} - #{train_by_type(type).size}"
    end
  end

  def send_train(train)
    @trains.delete(train) || 'There is no such train'
  end

  def call_block
    yield(@trains)
  end

  private

  def train_by_type(type)
    @trains.select { |train| train.type == type }
  end
end
