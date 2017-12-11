# fuchsia

Fuchsia is an untyped lambda calculus interpreter. Expressions are evaluated according to normal order reduction ([outside-in](https://en.wikipedia.org/wiki/Beta_normal_form#Reduction_strategies)). The core has no dependencies outside the standard library, though tests are implemented with RSpec.

## Usage

To try the repl:

    ruby fuchsia.rb

Fuchsia can also be run with an input file:

    ruby fuchsia.rb FILE

Expressions in the input file should be newline-delimited.

## Tests

Tests are implemented with RSpec. First, install dependencies:

    bundle install --path .bundle

Then, run tests with:

    bundle exec rspec

They include alpha-renaming, beta-reduction, eta-reduction, and various combinations.

## Notes

The lexer/parser were hand-written according to the following grammar:

    <expression>  := <atom>
                   | <abstraction>
                   | <application>
                   | (<expression>)

    <abstraction> := λ<atom>.<expr>

    <application> := <expression> <expression>

    <atom>        := [a-z][a-zA-Z]*

Without left recursion:


Without left recursion,

    <expression>  := <atom>
                   | <abstraction>
                   | <application>
                   | (<expression>)

    <abstraction> := λ<atom>.<expr>

    <application> := <atom> <expression>
                   | <abstraction> <expression>

    <atom>        := [a-z][a-zA-Z]*


Variable names can be arbitrarily long so long as they begin with a lowercase letter and otherwise only consist of alphabetic characters, so arbitrarily long expressions can be evaluated.

## Resources

* [Lecture slides](https://drona.csa.iisc.ernet.in/~deepakd/pav/lecture-notes.pdf), good except for a few errors.
* [Assignment spec](http://www.cs.rpi.edu/academics/courses/fall15/proglang/pa1/Programming%20Assignment%201.pdf), basis for test-cases.
* [A Tutorial Introduction to the Lambda Calculus](http://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf)

## License

MIT, see [LICENSE](https://github.com/mtn/fuchsia/blob/master/LICENSE).
