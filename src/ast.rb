
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
        "λ#{@param.inspect}.#{@body.inspect}"
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
            p 'lhs was an abstraction'
            puts 'lhs'
            p lhs
            puts 'rhs'
            p rhs
            new = env.clone
            new[@lhs.param] = @rhs
            puts "bodyclass"
            p @lhs.body.class
            puts "body"
            p @lhs.body
            puts "param"
            p @lhs.param
            return @lhs.body.reduce(new)
        end
        return Application(@lhs.reduce(env),@rhs.reduce(env))
    end

    def inspect
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

