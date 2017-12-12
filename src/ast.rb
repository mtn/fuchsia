
class Abstraction
    attr_reader :param
    attr_accessor :body

    def initialize(param,body)
        @param = param
        @body = body
    end

    def reduce(env={})
        new = env.clone
        if new.key? @param.name
            new.delete(@param.name)
        end

        if @body.is_a? Application
            if @body.rhs == @param and not @body.lhs.freeIn(@param)
                return @body.lhs.reduce(new)
            end
        end

        Abstraction.new(@param,@body.reduce(new))
    end

    def freeIn(atom)
        atom != @param and @body.freeIn(atom)
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
    attr_accessor :lhs
    attr_accessor :rhs

    def initialize(lhs,rhs)
        @lhs = lhs
        @rhs = rhs
    end

    def reduce(env={})
        if @lhs.is_a? Abstraction
            new = env.clone
            new[@lhs.param.name] = @rhs

            return @lhs.body.reduce(new)
        end

        Application.new(@lhs.reduce(env),@rhs.reduce(env))
    end

    def freeIn(atom)
        @lhs.freeIn(atom) or @rhs.freeIn(atom)
    end

    def inspect
        "(#{@lhs.inspect} #{@rhs.inspect})"
    end

    def ==(other)
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

    def freeIn(atom)
        atom == self
    end

    def inspect
        "#{@name}"
    end

    def ==(other)
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

# Walk AST, removing epsilons
def removeEpsilon(ast)
    if ast.is_a? Application and ast.rhs.is_a? Epsilon
        ast = ast.lhs
        ast = removeEpsilon(ast)
    end

    if ast.is_a? Application
        ast.lhs = removeEpsilon(ast.lhs)
        ast.rhs = removeEpsilon(ast.rhs)
    end

    if ast.is_a? Abstraction
        ast.body = removeEpsilon(ast.body)
    end

    ast
end

