require_relative 'lexer'
require_relative 'parser'


module Interpreter

    def self.run(expr)
        tokens = Lexer.new(expr).lex
        ast = Parser.new(tokens).parse

        while ast.inspect != ast.reduce.inspect
            ast = ast.reduce
        end

        return ast
    end

end
