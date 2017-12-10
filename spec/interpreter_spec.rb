require_relative '../src/interpreter'

describe Interpreter do

    describe ".run" do
        context "given identity combinator" do
            it "returns argument" do
                expect(Interpreter.run("(λx.x y)")).to eql("y")
            end
        end
    end

end
