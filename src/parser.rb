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

    def parseExpression(recursive=true)
        if @tokens[@ind].is_a? EOFTok or @tokens[@ind].is_a? RParenTok
            return Epsilon.new
        end

        if recursive
            return parseApplication
        end
    end

    def parseParenthesizedExpression
        consume(LParenTok)
        expr = parseExpression
        consume(RParenTok)

        return expr
    end

    def parseApplication
        if @tokens[@ind].is_a? AtomTok
            lexpr = parseAtom
        elsif @tokens[@ind].is_a? LambdaTok
            return parseAbstraction
        elsif @tokens[@ind].is_a? LParenTok
            lexpr = parseParenthesizedExpression
        end

        rexpr = parseExpression

        Application.new(lexpr, rexpr)
    end

    def parseAbstraction
        consume(LambdaTok)
        param = parseAtom
        consume(DotTok)
        abs = Abstraction.new(param, parseExpression)

        return abs
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
