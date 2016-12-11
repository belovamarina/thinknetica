require_relative 'passenger_train'

begin
  puts 'Введите номер поезда (три буквы или цифры в любом порядке, необязательный дефис и еще 2 буквы или цифры после дефиса.)'
  id = gets.strip
  train = PassengerTrain.new(id)
  puts "Создан поезд #{train.inspect}"
rescue
  puts 'Неправильный формат номера, попробуйте еще раз'
  retry
end