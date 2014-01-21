module ZofoPlot
	# Provides a generalized method for creation.
	#
	# This module provides the class method "create". This method creates an
	# instance of the class and calls the specified block in the context of
	# the instance, using instance_eval (if a block is given).
	#
	# Example:
	#     class MyClass
	#         include ZofoElement
	#         attr_accessor :value
	#     end
	#
	#     my_instance=MyClass.create { value=2 }
	#
	# Or, in conjunction with Container:
	#     my_instance=MyClass.create { value 2 }
	#
	module Element
		def self.included(klass)
			klass.extend(ClassMethods)
		end

		module ClassMethods
			def create(&proc)
				instance=self.new
				instance.instance_eval(&proc) if block_given?
				return instance
			end
		end
	end
end

