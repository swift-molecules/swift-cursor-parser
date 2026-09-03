public import Parser

extension Parser.Many where Source: ~Copyable & ~Escapable {

    public enum Error: Swift.Error {

        case countTooLow(expected: Int, got: Int)

        case countTooHigh(expected: Int, got: Int)

        case element(Element.Failure)
    }
}

extension Parser.Many.Error: Equatable where Source: ~Copyable & ~Escapable, Element.Failure: Equatable {}

extension Parser.Many.Separated
where
    Source: ~Copyable & ~Escapable,
    Separator.Input: ~Copyable & ~Escapable,
    Separator.Output: ~Copyable & ~Escapable
{

    public enum Error: Swift.Error {

        case countTooLow(expected: Int, got: Int)

        case countTooHigh(expected: Int, got: Int)

        case element(Element.Failure)

        case separator(Separator.Failure)
    }
}

extension Parser.Many.Separated.Error: Equatable
where
    Source: ~Copyable & ~Escapable,
    Separator.Input: ~Copyable & ~Escapable,
    Separator.Output: ~Copyable & ~Escapable,
    Element.Failure: Equatable,
    Separator.Failure: Equatable
{}
