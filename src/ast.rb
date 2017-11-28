
class Application
    def initialize(lhs,rhs)
        @lhs = lhs
        @rhs = rhs
    end

    def inspect
    end
end

class Abstraction
    def initialize(param,body)
        @param = param
        @body = body
    end

    def inspect
    end
end

class Identifier
    def initialize(val)
        @val = val
    end

    def inspect
    end
end

