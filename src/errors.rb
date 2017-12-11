
# Lexer Errors

class LexError < RuntimeError; end

class MalformedIdentifier < LexError
    def initialize(tok)
        @tok = tok
    end

    def message
        "Malfored Identifier: #{@tok}. Identifiers must start with lowercase"
    end
end


# Parser Errors

class ParseError < RuntimeError; end

class UnexpectedToken < ParseError
    def initialize(given, expected)
        @given = given
        @expected = expected
    end

    def message
        "\nUnexpected Token:\n\tGiven: #{@given.inspect}\n\tExpected: #{@expected.inspect}"
    end
end

class UnexpectedTokenType < ParseError
    def initialize(given, expected)
        @given = given
        @expected = expected
    end

    def message
        "\nUnexpected Token Type:\n\tGiven: #{@given}\n\tExpected: #{@expected}"
    end
end
