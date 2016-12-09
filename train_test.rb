require 'minitest/autorun'
Dir['*.rb'].each {|file| require_relative file }

class TrainTest < Minitest::Test
  def setup
    @st1 = Station.new("Moscow")
    @st2 = Station.new("Borovsk")
    @st3 = Station.new("Nara")

    @route = Route.new(@st1, @st2)

    @cargo_train1 = CargoTrain.new(1)
    @passenger_train2 = PassengerTrain.new(2)
    @passenger_train3 = PassengerTrain.new(3)

    @cargo_train1 = CargoTrain.new(1)
    @passenger_train2 = PassengerTrain.new(2)
    @passenger_train3 = PassengerTrain.new(3)

    @cargo_wagon1 = CargoWagon.new(1)
    @passenger_wagon2 = PassengerWagon.new(2)
    @passenger_wagon3 = PassengerWagon.new(3)
  end

  # Station
  def test_station_name
    assert_equal "Moscow", @st1.name
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
    assert_equal "There is no such train", @st1.send_train(@cargo_cargo_)
  end

  def test_show_all_trains_on_station
    @st1.get_train(@cargo_train1)
    @st1.get_train(@passenger_train2)
    @st1.get_train(@passenger_train3)
    assert_equal "all - 3", @st1.show_trains
  end

  def test_show_trains_on_station_by_type
    @st1.get_train(@cargo_train1)
    @st1.get_train(@passenger_train2)
    @st1.get_train(@passenger_train3)
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
    @cargo_train1.get_route(@route)
    assert_equal @route, @cargo_train1.route
  end

  def test_train_can_speed_up
    @cargo_train1.speed_up
    assert_equal 50, @cargo_train1.speed
  end

  def test_add_wagon_while_moving
    @cargo_train1.speed_up
    assert_equal "Stop the train first!", @cargo_train1.add_wagon(@cargo_wagon1)
  end

  def test_remove_wagon_while_moving
    @cargo_train1.add_wagon(@cargo_wagon1)
    @cargo_train1.speed_up
    assert_equal "Stop the train first!", @cargo_train1.remove_wagon(@cargo_wagon1)
  end

  def test_add_wagon
    @cargo_train1.add_wagon(@cargo_wagon1)
    assert_equal 1 , @cargo_train1.wagons.count
  end

  def test_remove_wagon
    @cargo_train1.add_wagon(@cargo_wagon1)
    @cargo_train1.remove_wagon(@cargo_wagon1)
    refute_includes @cargo_train1.wagons, @cargo_wagon1
  end

  def test_add_wrong_wagon
    assert_equal "Wrong type of wagon!" , @cargo_train1.add_wagon(@passenger_wagon2)
  end

  def test_show_current_station
    @passenger_train2.get_route(@route)
    assert_equal "Moscow", @passenger_train2.current_station.name
  end

  def test_show_next_station
    @passenger_train2.get_route(@route)
    assert_equal "Borovsk", @passenger_train2.next_station.name
  end

  def test_go_to_next_station
    @passenger_train2.get_route(@route)
    @passenger_train2.go_to_next_station
    assert_equal "Borovsk", @passenger_train2.current_station.name
  end

  def test_show_previous_station
    @passenger_train2.get_route(@route)
    @passenger_train2.go_to_next_station
    assert_equal "Moscow", @passenger_train2.previous_station.name
  end

  def test_train_dont_move_without_route
    assert_equal "Train doesn't have route", @passenger_train2.go_to_next_station
  end

  def test_station_get_train_when_it_go_by_route
    @passenger_train2.get_route(@route)
    @passenger_train2.go_to_next_station
    assert_includes @st2.trains, @passenger_train2
  end

  def test_station_remove_train_when_it_go_by_route
    @passenger_train2.get_route(@route)
    @passenger_train2.go_to_next_station
    refute_includes @st1.trains, @passenger_train2
  end
end
