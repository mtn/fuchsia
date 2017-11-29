require_relative 'src/parser'
require_relative 'src/lexer'

tokens = Lexer.new("λx. (y x)").lex
parser = Parser.new(tokens)
parser.parse
