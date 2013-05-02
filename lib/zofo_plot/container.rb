module ZofoPlot
  # Provides a generalized accessor
  #
  # To define the generalized accessor, use the class method zofo_attributes.
  # This method works like attr_accessor, but the methods it creates are more
  # versatile.
  #
  # As an example, let's assume we have two containers:
  #     class Color
  #       include Container
  #       zofo_attributes :red, :green, :blue
  #     end
  #
  #     class Line
  #       include Container
  #       zofo_attributes :width, :color
  #     end
  #
  #     my_color=Color.new
  #     my_line =Line.new
  #
  # The attribute can be accessed in the following ways:
  #   * regular setter: sets and returns the (new) value. This is identical to
  #     the write accessor created with attr_writer:
  #         my_color.red = 127
  #   * regular getter: returns the current value. This is identical to the
  #     read accessor created with attr_reader:
  #         my_color.red
  #   * generalized setter: allows setting the value with a different syntsx:
  #         my_text.red 255
  #   * block accessor: executes a block in he context of the value. This is
  #     particularly useful if the value is itself a Container:
  #         my_line.color {
  #           red 0
  #           green 127
  #           blue 255
  #         }
  #
  # The attribute can also be associated with a class. This allows the
  # following additional access method:
  #   * creator: when the value passed to the generalized setter does not
  #     match the expected class, or if multiple values are passed to the
  #     generalized setter, a new instance of the associated class is created,
  #     using the value(s) passed as constructor arguments. These examples
  #     assume that the Color class has a constructor that can handle the
  #     respective arguments:
  #         my_line.color "#007fff"
  #         my_line.color [0, 127, 255]
  #         my_line.color 0, 127, 255
  #
  # Note that we do not allow creating a converted value by regular setter
  # (e. g. `line.color="#007fff"` or `line.color=1,2,3`), for two reasons:
  #   * this does not preserve assignment semantics
  #   * it seems that a method with a name ending in `=` receives varargs
  #     wrapped in an array instead of individual values, as if it had been
  #     called with an array as a parameter:
  #         c.x [1,2,3]   => args==[[1, 2, 3]]
  #         c.x=[1,2,3]   => args==[[1, 2, 3]]
  #         c.x  1,2,3    => args== [1, 2, 3]
  #         c.x= 1,2,3    => args==[[1, 2, 3]], this is inconsistent
  #     Additionally, we cannot call a method ending in `=` with the arguments
  #     in parenteses (`foo=(1,2,3)` does not work).
  module Container
    def self.included(klass)
      klass.extend(ClassMethods)

      # Initialize the @zofo_attributes instance variable of the class (!)
      # to an empty hash. This variable is used to store additional
      # information about the attributes. The zofo_attributes class
      # method, which is used for defining attributes, also acts as a
      # getter for this variable.
      klass.instance_variable_set :@zofo_attributes, Hash.new
    end

    module ClassMethods
      def zofo_attribute(name, klass)
        # Create a generalize setter/getter
        zofo_attributes name

        # Store the metadata
        @zofo_attributes[name]=klass
      end

      # FIXME allow specifying a class (like for zofo_attribute) using a hash
      def zofo_attributes(*attributes)
        attr_writer *attributes

        # If no attributes are specified, this class acts as a getter for the
        # zofo_attributes instance variable of the class (!)
        return @zofo_attributes if attributes.empty?

        # For each attribute, define the generalized setter. The
        # generalized setter accepts a value or a proc and always returns
        # the (new) value.
        attributes.each { |attribute|
          define_method(attribute) { |*args, &proc|
            # Calculate the instance variable name from the attribute name
            variable_name="@#{attribute}"

            # Set the value, if a value or multiple values were given
            unless args.empty?
              # Retrieve the expected class for this attribute
              expected_class=self.class.zofo_attributes[attribute]

              # args.size | expected_class | action | comments
              # ----------+----------------+--------+-----
              # 1         | nil            | assign | line.with 2
              # 1         | match          | assign | line.color my_color
              # 1         | mismatch       | create | line.color "007fff"
              # >1        | nil            | error  | Need an expected class to create an instance
              # >1        | non-nil        | create | line.color 0, 127, 255

              if args.size==1
                value=args[0]

                if expected_class.nil? || value.is_a?(expected_class)
                  # No expected class or match - assign
                  instance_variable_set(variable_name, value)
                else
                  # Mismatch - create
                  instance_variable_set(variable_name, expected_class.new(value))
                end
              else
                if expected_class.nil?
                  # Multiple arguments, but no expected class - error
                  raise ArgumentError, "Multiple values can only be specified for attributes with a default class"
                else
                  # Multiple arguments - create
                  instance_variable_set(variable_name, expected_class.new(*args))
                end
              end
            end

            # Retrieve the (potentially new) value
            value=instance_variable_get(variable_name)

            # Execute the process in the context of the value, if given
            if proc
              #puts "Executing #{proc} in the context of the #{value.class}"
              value.instance_eval &proc
            end

            # In any case, return the (potentially new) value
            return value
          }
        }

        @zofo_attributes
      end
    end
  end
end
