
class Token
    def ==(other)
        puts self.class
        return false unless other.is_a? self.class
    end
end

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

class AtomTok < Token
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def inspect
        "Tok[id_#{@name}]"
    end

    def ==(other)
        return false unless other.is_a? AtomTok
        @name == other.name
    end
end

