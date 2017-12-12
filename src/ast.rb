
class Abstraction
    attr_reader :param
    attr_reader :body

    def initialize(param,body)
        @param = param
        @body = body
    end

    def reduce(env={})
        new = env.clone
        if new.key? @param.name
            new.delete(@param.name)
        end
        return Abstraction.new(@param,@body.reduce(new))
    end

    def inspect
        "(λ#{@param.inspect}.#{@body.inspect})"
    end

    def ==(other)
        return false if not other.is_a? Abstraction
        @param == other.param and @body == other.body
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

            if not new.has_value? @lhs.param
                new[@lhs.param.name] = @rhs
            end

            return @lhs.body.reduce(new)
        end

        if @rhs.is_a? Epsilon
            return @lhs.reduce(env)
        end

        return Application.new(@lhs.reduce(env),@rhs.reduce(env))
    end

    def inspect
        if @rhs.is_a? Epsilon
            return "#{@lhs.inspect}"
        end
        "(#{@lhs.inspect} #{@rhs.inspect})"
    end

    def ==(other)
        if other.is_a? Atom
            other = Application.new(other, Epsilon.new)
        end

        return false if not other.is_a? Application
        @lhs == other.lhs and @rhs == other.rhs
    end
end

class Atom
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def reduce(env={})
        if env.key? @name
            return env[@name]
        end
        self
    end

    def inspect
        "#{@name}"
    end

    def ==(other)
        if other.is_a? Application and other.rhs.is_a? Epsilon
            other = other.lhs
        end

        return false if not other.is_a? Atom
        @name == other.name
    end
end

# Base case
class Epsilon
    def reduce(env)
        self
    end

    def inspect
        "ε"
    end

    def ==(other)
        other.is_a? Epsilon
    end
end

def astToDict(ast, ast_dict={})
    if not ast_dict
        ast_dict = {}
    end

    if ast.is_a? Application
        ast_dict['type'] = "Application"
        ast_dict['lhs'] = astToDict(ast.lhs, ast_dict['lhs'])
        ast_dict['rhs'] = astToDict(ast.rhs, ast_dict['rhs'])
    elsif ast.is_a? Abstraction
        ast_dict['type'] = "Abstraction"
        ast_dict['param'] = astToDict(ast.param, ast_dict['param'])
        ast_dict['body'] = astToDict(ast.body, ast_dict['body'])
    elsif ast.is_a? Atom
        ast_dict['type'] = "Atom"
        ast_dict['name'] = ast.name
    elsif ast.is_a? Epsilon
        ast_dict['type'] = "Epsilon"
    end

    ast_dict
end

