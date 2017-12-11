# fuchsia

Fuchsia is an untyped lambda calculus interpreter. Expressions are evaluated according to normal order reduction. The core has no dependencies outside the standard library, though tests are implemented with RSpec.

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

## Resources

* [Lecture slides](https://drona.csa.iisc.ernet.in/~deepakd/pav/lecture-notes.pdf), good except for a few errors.
* [Assignment spec](http://www.cs.rpi.edu/academics/courses/fall15/proglang/pa1/Programming%20Assignment%201.pdf), test cases.

## License

MIT, see [LICENSE](https://github.com/mtn/fuchsia/blob/master/LICENSE).
