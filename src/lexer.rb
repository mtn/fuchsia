require_relative 'tokens'

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
        if not @input[@ind]
            return nil
        end

        while @input[@ind] and isspace(@input[@ind])
            advance
        end

        if @ind == @input.length
            return nil
        end

        case @input[@ind]
        when 'λ' then
            advance
            return LambdaTok.new
        end
    end
end

def isspace(c)
    c.match(/^\s*$/)
end

def isalpha(c)
    c.match(/^[[:alpha:]]$/)
end

