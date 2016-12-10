module InstanceCounter
  def self.included(base)
    base.class_variable_set :@@instances, 0
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      self.class_variable_get :@@instances
    end

    def clear_instances
      self.class_variable_set :@@instances, 0
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.class_variable_set :@@instances, (self.class.class_variable_get(:@@instances) + 1)
    end
  end
end

# class Train
#   include InstanceCounter
#   def initialize
#     self.register_instance
#   end
# end
#
# train1 = Train.new
# train2 = Train.new
#
# puts Train.instances # => 2