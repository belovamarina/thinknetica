class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def show_trains(type = :all)
    if type == :all
      "#{type} - #{@trains.size}"
    else
      train_by_type = @trains.select { |train| train.type == type }
      "#{type} - #{train_by_type.size}"
    end
  end

  def send_train(train)
    @trains.delete(train) || "There is no such train"
  end
end
