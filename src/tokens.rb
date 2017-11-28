
class Token; end

class LambdaTok < Token
    def inspect
        "Tok[λ]"
    end
end

class DotTok < Token
    def inspect
        "Tok[.]"
    end
end

class LParenTok < Token
    def inspect
        "Tok[(]"
    end
end

class RParenTok < Token
    def inspect
        "Tok[)]"
    end
end

class EOFTok < Token
    def inspect
        "Tok[EOF]"
    end
end

class IdentifierTok < Token
    def initialize(name)
        @name = name
    end

    def inspect
        "Tok[id_#{@name}]"
    end
end
