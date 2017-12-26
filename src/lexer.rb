require_relative 'tokens'
require_relative 'errors'

class Lexer
    def initialize(input)
        @input = input
        @ind = 0
    end

    def peek
        @input[@ind]
    end

    def advance
        @ind += 1
    end

    def getTok
        while @input[@ind] and isspace(@input[@ind])
            advance
        end

        if not @input[@ind]
            return nil
        end

        case @input[@ind]
        when 'λ' then
            advance
            return LambdaTok.new
        when '\\' then
            advance
            return LambdaTok.new
        when '.' then
            advance
            return DotTok.new
        when '(' then
            advance
            return LParenTok.new
        when ')' then
            advance
            return RParenTok.new
        when "\0" then
            advance
            return EOFTok.new
        else
            if isalpha(@input[@ind]) and islower(@input[@ind])
                name = ''
                loop do
                    if @input[@ind].nil? or not isalpha(@input[@ind])
                        return AtomTok.new(name)
                    end

                    name += @input[@ind]
                    advance
                end
            else
                raise MalformedIdentifier.new(@input[@ind])
            end
        end
    end

    def lex
        toks = []

        loop do
            tok = getTok()
            if tok
                toks.push(tok)
            else
                break
            end
        end

        toks.push(EOFTok.new)

        toks
    end
end

def isspace(c)
    c.match(/^\s*$/)
end

def isalpha(c)
    c.match(/^[[:alpha:]]$/)
end

def islower(s)
    !!s.match(/\p{Lower}/)
end

