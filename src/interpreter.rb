require_relative 'lexer'
require_relative 'parser'

require 'pp'


module Interpreter

    def self.run(expr)
        tokens = Lexer.new(expr).lex
        ast = Parser.new(tokens).parse

        puts "ast in step"
        pp astToDict(ast)
        # p ast
        # p ast.class
        # while ast.inspect != ast.reduce.inspect
        #     puts "ast in step"
        #     p ast
        #     ast = ast.reduce
        # end

        return ast
    end

end
