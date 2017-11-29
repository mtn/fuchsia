require_relative 'tokens'

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
            ret = tok
            advance
            return ret
        end
        nil
    end

    def parseTerm(env)
        if consume(LambdaTok.new)
            id = consume(IdentifierTok.new)
            raise ParseError if id.nil?

            term = parseTerm(env.push(id))
            return Abstraction.new(id,term)
        else
            return parseApplication(env)
        end
    end

    def parseApplication(env)
        lhs = parseAtom(env)

        loop do
            rhs = parseAtom(env)
            if rhs.nil?
                return lhs
            else
                lhs = Application.new(lhs,rhs)
            end
        end
    end

    def parseAtom(env)
        if consume(LParenTok.new)
            term = parseTerm(env)
            raise ParseError unless consume(RParenTok.new)
            return term
        end
    end

    def parse

        p @tokens
    end
end
