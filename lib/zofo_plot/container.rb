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
# Setting a value by regular or generalized setter:
#   line.color my_color
#   line.color=my_color
#
# Assigning a converted value by generalized setter:
#   line.color "#ff00ff"
#   line.color [255, 0, 255]
#   line.color 255, 0, 255
#   line.color hash, where hash = { red => 255, green => 0, blue => 255 }
#     Note that we can't specify a hash literal, this would clash with a block 
#
# Do we want to allow assigning a converted value by regular setter?
#   1. this does not preserve assignment semantics
#   2. check this - if left is sometimes the same as right and sometimes not,
#      it's probably not a good idea:
#      class Foo
#        def x(*args) ; p args; end
#        def x=(*args); p args; end
#      end
#
#      foo=Foo.new
#      foo.x [1,2,3]; foo.x=[1,2,3]
#      foo.x 1,2,3  ; foo.x=1,2,3
#      foo.x arr    ; foo.x=arr
 


# Old: We don't allow assigning a converted value by regular setter, for two reasons:
#   1. `line.color=255, 0, 255` passes an array to the setter: [255, 0, 255]
#        1. line.color [a,b,c] could mean something different from line.color=[a,b,c]
#        2. 
#   2. We want to preserve setter semantics.

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

