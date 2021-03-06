require_relative 'tokens'
require_relative 'ast'

class Parser
    def initialize(tokens)
        @tokens = tokens
        @ind = 0
    end

    def consume(type)
        raise UnexpectedTokenType.new(@tokens[@ind].class, type) \
            unless @tokens[@ind].is_a? type

        @ind += 1
        @tokens[@ind-1]
    end

    def parseExpression
        if @tokens[@ind].is_a? EOFTok or @tokens[@ind].is_a? RParenTok
            return Epsilon.new
        end

        parseApplication
    end

    def parseParenthesizedExpression
        consume(LParenTok)
        expr = parseExpression
        consume(RParenTok)

        return expr
    end

    def parseBounded
        if @tokens[@ind].is_a? AtomTok
            return parseAtom
        elsif @tokens[@ind].is_a? LambdaTok
            return parseAbstraction
        elsif @tokens[@ind].is_a? LParenTok
            return parseParenthesizedExpression
        end

        nil
    end

    def parseApplication
        lexpr = parseBounded
        loop do
            rexpr = parseBounded
            if not rexpr
                return lexpr
            else
                lexpr = Application.new(lexpr, rexpr)
            end
        end
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
