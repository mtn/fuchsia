require 'readline'

require_relative 'src/interpreter'


if ARGV.size > 0
    contents = File.open(ARGV[0],"r").read.chomp
    lines = contents.split("\n")

    for line in lines
        p Interpreter.run(line)
    end

    return
end

while buf = Readline.readline('>> ', true)
    begin
        p Interpreter.run(buf)
    rescue => e
        if p.is_a? ParseError
            puts "#{e.message}"
        end
        puts "Error: '#{e.message}'"
    end
end
