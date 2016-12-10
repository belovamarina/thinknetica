require_relative 'company'

class Wagon
  include Company
  attr_reader :type
  @@id ||= 0

  def initialize(type)
    @type = type
    @id = @@id + 1
  end
end