module ZofoPlot
    class Collection <Array
        def initialize(expected_class)
            @expected_class=expected_class
        end
        
        def add(*args, &proc)
            value=if args.size == 1 && args[0].is_a?(@expected_class)
                args[0]
            else
                @expected_class.new(*args)
            end
            
            value.instance_eval(&proc) if proc
            
            self << value
        end
    end
end
