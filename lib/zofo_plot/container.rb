# FIXME current: we want to use the generalized setter to set an attribute
# to something other than simply a reference.
#
# Example:
#   color          is a zofo_attribute  of line
#   red/green/blue are  zofo_attributes of color
#
# Calling a block in the context of the attribute: 
#   line.color { red 255; green 0; blue 255 }
#
# Assigning a value by regular or generalized setter:
#   line.color my_color
#   line.color=my_color
#
# Creating a converted value by generalized setter:
#   line.color "#ff00ff"
#   line.color [255, 0, 255]
#   line.color 255, 0, 255
#
# We do not allow creating a converted value by regular setter (e. g.
# line.color=1, 2, 3), for two reasons:
#   1. this does not preserve assignment semantics
#   2. a method with a name ending in `=` receives varargs wrapped in an array
#      (`args==[[1, 2, 3]]`) instead of individual values (`args==[1, 2, 3]`),
#      as if it had been called with an array as a parameter:
#      `foo=1,2,3` is the same as    `foo=[1,2,3]`
#      `foo 1,2,3` is different from `foo [1,2,3]`
#      Additionally, we cannot call foo=(1,2,3)

module ZofoPlot
	# Provides a generalized setter/getter.
	#
	# To define the generalized setter, use the class method zofo_attributes.
	# This method works like attr_accessor, but the getter can also be used
	# as a setter by passing the value to be set as an argument.
	# Additionally, a block can be passed to the getter, which will be
	# executed in the context of the attribute. This is particularly useful
	# if the attribute is a Container itself.
	#
	# Example:
	#     class Text
	#       include Container
	#       zofo_attributes :string, :size
	#     end
	#
	#     class Document
	#       include Container
	#       zofo_attributes :title, :body
  #
	#       def initialize
	#         @title=Text.new
	#         @body =Text.new
	#       end
	#     end
	#
	#     my_text=Text.new
	#     my_text.string = "Hello"  # Sets and returns the value (like an attr_writer)
	#     my_text.size     24       # Sets and returns the value (like an attr_writer)
	#     my_text.size              # Returns the value          (like an attr_reader)
	#     
	#     my_document=Document.new
	#     my_document.title = my_text
	#     my_document.body {        # Executes the block in the context of the value
	#       string "...world!"
	#       size 12
	#       size                    # Returns the value
	#     }
	module Container
		def self.included(klass)
			klass.extend(ClassMethods)
		end

		module ClassMethods
		  def zofo_attribute(name, klass)
		    zofo_attributes name
		    @@zofo_attributes ||= {}
		    @@zofo_attributes[name]=klass
		    puts "Added attribute #{name}, now we have #{@@zofo_attributes}"
		  end
		  
		  # FIXME allow specifying a class (like for zofo_attribute) using a hash
			def zofo_attributes(*attributes)
				attr_writer *attributes

				# For each attribute, define the generalezed setter. The
				# generalized setter accepts a value or a proc and always returns
				# the (new) value.
				attributes.each { |attribute|
					define_method(attribute) { |value=(value_omitted=true), &proc|
						variable_name="@#{attribute}"

						unless value_omitted
							#puts "Assigning a #{value.class} to #{self.class}'s #{attribute}"
						  # Retrieve the expected class
						  expected_class=@@zofo_attributes[attribute]
						  if expected_class.nil?
                # We don't expect a specific class - assign the value 
                instance_variable_set(variable_name, value)
						  elsif value.is_a?(expected_class)
						    # The value matches the expected class - assign it 
						    instance_variable_set(variable_name, value)
						  else
						    # The value does not match the expected class - try to create
						    # a new instance of the expected class
                puts "Expected #{expected_class}, got #{value.class} - try to create it"
                instance_variable_set(variable_name, expected_class.new(value))
						  end
						end

						value=instance_variable_get(variable_name)

						if proc
							#puts "Executing #{proc} in the context of the #{value.class}"
							value.instance_eval &proc
						end

						return value
					}
				}
			end
		end
	end
end

