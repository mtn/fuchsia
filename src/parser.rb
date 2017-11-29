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

    def matchType(tok)
        @tokens[@ind].is_a? tok.class
    end

    def consume(tok)
        if matchType(tok)
            ret = @tokens[@ind]
            advance
            return ret
        end
        nil
    end

    def parseTerm
        if consume(LambdaTok.new)
            idtok = consume(IdentifierTok.new(@tokens[@ind].name))
            raise ParseError if idtok.nil?
            id = Identifier.new(idtok.name)

            consume(DotTok.new)
            term = parseTerm

            return Abstraction.new(id,term)
        else
            return parseApplication
        end
    end

    def parseApplication
        lhs = parseAtom

        loop do
            rhs = parseAtom
            if rhs.nil?
                return lhs
            else
                lhs = Application.new(lhs,rhs)
            end
        end
    end

    def parseAtom
        if consume(LParenTok.new)
            term = parseTerm
            raise ParseError unless consume(RParenTok.new)
            return term
        elsif id = consume(IdentifierTok.new(''))
            return Identifier.new(id.name)
        else
            return nil
        end
    end

    def parse
        res = parseTerm
        raise ParseError unless @tokens[@ind].is_a? EOFTok
        return res
    end
end
