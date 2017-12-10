require_relative 'lexer'
require_relative 'parser'


module Interpreter

    def self.run(expr)
        tokens = Lexer.new(expr).lex
        ast = Parser.new(tokens).parse
        return evaluate(ast)
    end

    def self.evaluate(ast)
    end

end
