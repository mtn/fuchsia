require_relative '../src/interpreter'

describe Interpreter do

    describe ".run" do

        context "identity combinator" do
            it "evaluated to" do
                expect(Interpreter.run("(λx.x y)")).to eql("y")
            end
        end

        context "application combinator" do
            it "evaluated to" do
                expect(Interpreter.run("((λy.λx.(y x) λx.(x x)) y)")).to eql("(y y)")
            end
        end

        context "simple eta-reducable expression" do
            it "evaluated to" do
                expect(Interpreter.run("λx.(y x)")).to eql("y")
            end
        end

        context "complex eta-reducable expression" do
            it "evaluated to" do
                expect(Interpreter.run("λx.((λx.(y x) λx.(z x)) x)")).to eql("(y z)")
            end
        end

        context "if-else combinator" do
            it "evaluated to" do
                expect(Interpreter.run("(((λb.λt.λe.((b t) e) λx.λy.x) x) y)"))
                    .to eql("x")
            end
        end

        context "alpha-beta-eta combination" do
            it "evaluated to" do
                expect(Interpreter.run("(λy.(λx.λy.(x y) y) (y w))")).to eql("(y w)")
            end
        end

        context "possible name collision" do
            it "evaluated to" do
                expect(Interpreter.run("(λx.λy.(y x) (y w))")).to eql("λz.(z (y w))")
            end
        end

        context "possible name collision and eta reduction" do
            it "evaluated to" do
                expect(Interpreter.run("(λx.λy.(x y) (y w))")).to eql("(y w)")
            end
        end

    end

end
