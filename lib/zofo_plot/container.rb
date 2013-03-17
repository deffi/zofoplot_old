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
	#       def initialzie
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
			def zofo_attributes(*attributes)
				attr_writer *attributes

				# For each attribute, define the generalezed setter. The
				# generalized setter accepts a value or a proc and always returns
				# the (new) value.
				attributes.each { |a|
					define_method(a) { |value=(value_omitted=true), &proc|
						variable="@#{a}"

						unless value_omitted
							#puts "Assigning a #{value.class} to #{self.class}'s #{a}"
							instance_variable_set(variable, value)
						end

						value=instance_variable_get(variable)

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

