require_relative 'lexer'
require_relative 'parser'


module Interpreter

    def self.run(expr)
        tokens = Lexer.new(expr).lex
        ast = Parser.new(tokens).parse
        ast = removeEpsilon(ast)

        loop do
            new = ast.reduce

            break if ast.inspect == new.inspect
            ast = new
        end

        return ast
    end

end
