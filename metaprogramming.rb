module Accessors
  def att_accessor_with_history(*attributes)
    attributes.each do |attr|
      var_name = "@#{attr}".to_sym
      define_method(attr) { instance_variable_get(var_name) }

      define_method("#{attr}=".to_sym) do |value|
        if get_history = instance_variable_get("@#{attr}_history".to_sym)
          instance_variable_set("@#{attr}_history".to_sym, get_history << value)
        else
          instance_variable_set("@#{attr}_history", [value])
        end

        define_singleton_method("#{attr}_history") { get_history }

        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(attr, attr_class)
    var_name = "@#{attr}".to_sym
    define_method(attr) { instance_variable_get(var_name) }
    define_method("#{attr}=".to_sym) do |value|
      value.is_a?(attr_class) ? instance_variable_set(var_name, value) : (raise 'Wrong class of variable!')
    end
  end
end

module Validation
  def validate(name, options = {})
    define_method(:validate!) do
      get_attribute = instance_variable_get("@#{name}".to_sym)
      if options[:presence] && !get_attribute
        raise 'Variable is missing!'
      elsif options[:format] && get_attribute.to_s !~ options[:format]
        raise 'Wrong format!'
      elsif options[:type] && !get_attribute.is_a?(options[:type])
        raise 'Wrong type!'
      end
      true
    end

    define_method(:valid?) { validate! rescue false }
  end
end

class Animal
  extend Accessors
  extend Validation
  att_accessor_with_history :dog, :cat
  strong_attr_accessor :age, Integer
  validate :age, presence: true, type: Integer, format: /[1-9]/
end



