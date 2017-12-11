
class Abstraction
    attr_reader :param
    attr_reader :body

    def initialize(param,body)
        @param = param
        @body = body
    end

    def reduce(env={})
        new = env.clone
        if new.include? @param
            new.delete(@param)
        end
        Abstraction.new(@param,@body.reduce(new))
    end

    def inspect
        "(λ#{@param.inspect}.#{@body.inspect})"
    end
end

class Application
    attr_reader :lhs
    attr_reader :rhs

    def initialize(lhs,rhs)
        @lhs = lhs
        @rhs = rhs
    end

    def reduce(env={})
        if @lhs.is_a? Abstraction
            new = env.clone
            new[@lhs.param] = @rhs

            return @lhs.body.reduce(new)
        end
        return Application.new(@lhs.reduce(env),@rhs.reduce(env))
    end

    def inspect
        if @rhs.is_a? Epsilon
            return "#{@lhs.inspect}"
        end
        "#{@lhs.inspect} #{@rhs.inspect}"
    end
end

class Atom
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def reduce(env={})
        if env.include? @name
            @name = env[@name]
        end
        self
    end

    def inspect
        "#{@name}"
    end
end

# Base case
class Epsilon
    def reduce(env)
        self
    end

    def inspect; end
end

