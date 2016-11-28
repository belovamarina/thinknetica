require 'minitest/autorun'
require_relative './train.rb'
require_relative './station.rb'
require_relative './route.rb'

class TrainTest < Minitest::Test
  def setup
    @st1 = Station.new("Moscow")
    @st2 = Station.new("Borovsk")
    @st3 = Station.new("Nara")

    @route = Route.new(@st1, @st2)

    @train1 = Train.new(1, :passenger, 5)
    @train2 = Train.new(2, :passenger, 3)
    @train3 = Train.new(3, :cargo, 3)
  end

  # Station
  def test_station_name
    assert_equal "Moscow", @st1.name
  end

  def test_station_get_trains
    @st1.get_train(@train1)
    assert_equal @st1.trains.last, @train1
  end

  def test_station_send_trains
    @st1.get_train(@train1)
    @st1.get_train(@train2)
    @st1.send_train(@train1)
    refute_includes @st1.trains, @train1
  end

  def test_empty_station_send_trains
    assert_equal "There is no such train", @st1.send_train(@train1)
  end

  def test_show_all_trains_on_station
    @st1.get_train(@train1)
    @st1.get_train(@train2)
    @st1.get_train(@train3)
    assert_equal "all - 3", @st1.show_trains
  end

  def test_show_trains_on_station_by_type
    @st1.get_train(@train1)
    @st1.get_train(@train2)
    @st1.get_train(@train3)
    assert_equal "cargo - 1", @st1.show_trains(:cargo)
  end

  # Route
  def test_show_route
    assert_equal ["Moscow", "Borovsk"], @route.show_route
  end

  def test_add_station_to_route
    @route.add_station(@st3)
    assert_includes @route.stations, @st3
  end

  def test_delete_station_from_route
    @route.remove_station(@st2)
    assert_equal false, @route.stations.include?(@st2)
  end

  # Train
  def test_train_get_route
    @train1.get_route(@route)
    assert_equal @route, @train1.route
  end

  def test_train_can_speed_up
    @train1.speed_up
    assert_equal 50, @train1.speed
  end

  def test_add_wagon_while_moving
    @train1.speed_up
    assert_equal "Stop the train first!", @train1.add_wagon
  end

  def test_remove_wagon_while_moving
    @train1.add_wagon
    @train1.speed_up
    assert_equal "Stop the train or/and add wagons!", @train1.remove_wagon
  end

  def test_add_wagon
    @train1.add_wagon
    assert_equal 6, @train1.wagons_count
  end

  def test_remove_wagon
    @train1.remove_wagon
    assert_equal 4, @train1.wagons_count
  end

  def test_show_current_station
    @train2.get_route(@route)
    assert_equal "Moscow", @train2.current_station.name
  end

  def test_show_next_station
    @train2.get_route(@route)
    assert_equal "Borovsk", @train2.next_station.name
  end

  def test_go_to_next_station
    @train2.get_route(@route)
    @train2.go_to_next_station
    assert_equal "Borovsk", @train2.current_station.name
  end

  def test_show_previous_station
    @train2.get_route(@route)
    @train2.go_to_next_station
    assert_equal "Moscow", @train2.previous_station.name
  end

  def test_train_dont_move_without_route
    assert_equal "Train doesn't have route", @train2.go_to_next_station
  end

  def test_station_get_train_when_it_go_by_route
    @train2.get_route(@route)
    @train2.go_to_next_station
    assert_includes @st2.trains, @train2
  end

  def test_station_remove_train_when_it_go_by_route
    @train2.get_route(@route)
    @train2.go_to_next_station
    refute_includes @st1.trains, @train2
  end
end
