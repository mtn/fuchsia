
class Abstraction
    def initialize(param,body)
        @param = param
        @body = body
    end

    def inspect
        "λ#{@param}.#{@body}"
    end
end

class Application
    def initialize(lhs,rhs)
        @lhs = lhs
        @rhs = rhs
    end

    def inspect
        "#{@lhs.inspect} #{@rhs.inspect}"
    end
end

class Identifier
    def initialize(val)
        @val = val
    end

    def inspect
        "#{@val}"
    end
end

