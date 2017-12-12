require_relative '../src/interpreter'

describe Interpreter do

    describe ".run" do

        context "identity combinator" do
            it "evaluated to" do
                expect(Interpreter.run("(λx.x) y").inspect).to eql("y")
            end
        end

        context "application combinator" do
            it "evaluated to" do
                expect(Interpreter.run("((λy.λx.(y x)) (λx.x x)) y").inspect)
                    .to eql("(y y)")
            end
        end

        context "simple eta-reducable expression" do
            it "evaluated to" do
                expect(Interpreter.run("λx.(y x)").inspect).to eql("y")
            end
        end

        context "complex eta-reducable expression" do
            it "evaluated to" do
                expect(Interpreter.run("(λx.(λx.y x) (λx.z x)) x").inspect)
                    .to eql("(y z)")
            end
        end

        context "if-else combinator" do
            it "evaluated to" do
                expect(Interpreter.run("(λp.λa.λb.p a b) (λa.λb. a) a b").inspect)
                    .to eql("a")
            end
        end

        context "alpha-beta-eta combination" do
            it "evaluated to" do
                expect(Interpreter.run("(λz.z (λx. w x)) y").inspect)
                    .to eql("(y w)")
            end
        end

        context "possible name collision" do
            it "evaluated to" do
                expect(Interpreter.run("(λx.λx.(x x)) y w").inspect).to eql("(w w)")
            end
        end

    end

end
