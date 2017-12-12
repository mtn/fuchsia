require_relative 'lexer'
require_relative 'parser'

require 'pp'


module Interpreter

    def self.run(expr)
        tokens = Lexer.new(expr).lex
        ast = Parser.new(tokens).parse
        ast = removeEpsilon(ast)

        puts "===================================="
        p ast
        pp astToDict(ast)

        loop do
            # puts "===================================="
            # p ast
            # pp astToDict(ast)
            new = ast.reduce

            break if ast.inspect == new.inspect
            ast = new
        end

        return ast
    end

end
