public import Iterator
public import Iterator_Protocol
public import Parser

extension Parser.First {

    public struct Element<Source: Iterator.`Protocol`>: Parser.`Protocol`
    where Source.Element: Copyable & Escapable, Source.Failure == Never {

        public typealias Input = Source

        public typealias Output = Source.Element

        public typealias Failure = Parser.EndOfInput.Error

        @inlinable
        public init() {}

        @inlinable
        public borrowing func parse(_ input: inout Source) throws(Failure) -> Output {
            guard let element = input.next() else {
                throw .unexpected(expected: "any element")
            }

            return element
        }
    }
}
