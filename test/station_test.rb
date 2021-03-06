require 'minitest/autorun'
require 'byebug'
Dir['../*.rb'].each { |file| require_relative file if file !~ /main|metaprogramming/ }

class StationTest < Minitest::Test
  def setup
    @st1 = Station.new('Moscow')
    @st2 = Station.new('Borovsk')
    @st3 = Station.new('Nara')

    @cargo_train1 = CargoTrain.new('12345')
    @passenger_train2 = PassengerTrain.new('123-45')
    @passenger_train3 = PassengerTrain.new('vbn-nb')
  end

  # Station
  def test_station_name
    assert_equal 'Moscow', @st1.name
  end

  def test_station_get_trains
    @st1.get_train(@cargo_train1)
    assert_equal @st1.trains.last, @cargo_train1
  end

  def test_station_send_trains
    @st1.get_train(@cargo_train1)
    @st1.get_train(@passenger_train2)
    @st1.send_train(@cargo_train1)
    refute_includes @st1.trains, @cargo_train1
  end

  def test_empty_station_send_trains
    assert_equal 'There is no such train', @st1.send_train(@cargo_cargo_)
  end

  def test_show_all_trains_on_station
    @st1.get_train(@cargo_train1)
    @st1.get_train(@passenger_train2)
    @st1.get_train(@passenger_train3)
    assert_equal 'all - 3', @st1.show_trains
  end

  def test_show_trains_on_station_by_type
    @st1.get_train(@cargo_train1)
    @st1.get_train(@passenger_train2)
    @st1.get_train(@passenger_train3)
    assert_equal 'cargo - 1', @st1.show_trains(:cargo)
  end

  def test_counting_all_stations
    Station.clear_all_stations_count
    @st1 = Station.new('Moscow')
    @st2 = Station.new('Borovsk')
    @st3 = Station.new('Nara')
    assert_equal 3, Station.all.size
  end

  def test_raising_error
    @not_valid_station = Station.new(123)
    assert_raises StandardError do
      @not_valid_station.validate!
    end
  end

  def test_call_block
    @st1.get_train(@cargo_train1)
    assert_equal '12345', @st1.call_block { |x| x.first.id }
  end

  def test_validation_station_name
    @not_valid_station = Station.new(123)
    refute @not_valid_station.valid?
  end
end
