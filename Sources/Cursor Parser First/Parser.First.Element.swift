public import Iterator
public import Iterator_Protocol

extension Parser.First {

    public struct Element<Source: Iterator.`Protocol`>
    where Source.Element: Copyable & Escapable, Source.Failure == Never {

        @inlinable
        public init() {}
    }
}

extension Parser.First.Element: Parser.`Protocol` {

    public typealias Input = Source

    public typealias Output = Source.Element

    public typealias Failure = Parser.EndOfInput.Error

    @inlinable
    public func parse(_ input: inout Source) throws(Failure) -> Output {
        guard let element = input.next() else {
            throw .unexpected(expected: "any element")
        }

        return element
    }
}
