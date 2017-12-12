
class Abstraction
    attr_reader :param
    attr_reader :body

    def initialize(param,body)
        @param = param
        @body = body
    end

    def reduce(env={})
        puts "reducing lambda"
        p self
        puts "lambdafin"
        new = env.clone
        if new.key? @param.name
            new.delete(@param.name)
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
        puts "reducing application"
        p self
        if @lhs.is_a? Abstraction
            puts "lhs was an abstraction"
            new = env.clone
            new[@lhs.param.name] = @rhs

            return @lhs.body.reduce(new)
        else
            puts "lhs was not an abstraction"
            p @lhs
        end
        return Application.new(@lhs.reduce(env),@rhs.reduce(env))
    end

    def inspect
        if @rhs.is_a? Epsilon
            return "#{@lhs.inspect}"
        end
        "(#{@lhs.inspect} #{@rhs.inspect})"
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
end

# Base case
class Epsilon
    def reduce(env)
        self
    end

    def inspect
        "ε"
    end
end

def astToDict(ast, ast_dict={})
    if not ast_dict
        ast_dict = {}
    end
    if ast.is_a? Application
        ast_dict['type'] = "Application"
        ast_dict['lhs'] = astToDict(ast.lhs, ast_dict['lhs'])
        ast_dict['rhs'] = astToDict(ast.lhs, ast_dict['lhs'])
    elsif ast.is_a? Abstraction
        ast_dict['type'] = "Abstraction"
        ast_dict['param'] = astToDict(ast.param, ast_dict['lhs'])
        ast_dict['body'] = astToDict(ast.body, ast_dict['lhs'])
    elsif ast.is_a? Atom
        ast_dict['type'] = "Atom"
        ast_dict['name'] = ast.name
    elsif ast.is_a? Epsilon
        ast_dict['type'] = "Epsilon"
    end

    ast_dict
end

