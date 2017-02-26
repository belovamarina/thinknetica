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