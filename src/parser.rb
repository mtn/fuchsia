require_relative 'tokens'
require_relative 'ast'

class Parser
    def initialize(tokens)
        @tokens = tokens
        @ind = 0
    end

    def advance
        @ind += 1
    end

    def consume(type)
        raise UnexpectedTokenType.new(@tokens[@ind].class, type) \
            unless @tokens[@ind].is_a? type

        advance
        @tokens[@ind-1]
    end

    def parseExpression
        if @tokens[@ind].is_a? LParenTok
            return parseApplication
        elsif @tokens[@ind].is_a? LambdaTok
            return parseAbstraction
        elsif @tokens[@ind].is_a? AtomTok
            return parseAtom
        else
            raise UnexpectedToken.new(@tokens[@ind], ["'","\\", "λ", "aToM"])
        end
    end

    def parseApplication
        consume(LParenTok)

        lexpr = parseExpression
        rexpr = parseExpression

        consume(RParenTok)

        Application.new(lexpr, rexpr)
    end

    def parseAbstraction
        consume(LambdaTok)
        param = parseAtom
        consume(DotTok)
        Abstraction.new(param, parseExpression)
    end

    def parseAtom
        Atom.new(consume(AtomTok).name)
    end

    def parse
        res = parseExpression

        consume(EOFTok)

        res
    end
end
