public import Iterator
public import Iterator_Protocol

extension Parser.First {

    public struct Where<Source: Iterator.`Protocol`>
    where Source.Element: Copyable & Escapable, Source.Failure == Never {
        @usableFromInline
        let predicate: (Source.Element) -> Bool

        @usableFromInline
        let expected: String

        @inlinable
        public init(
            expected: String = "matching element",
            _ predicate: @escaping (Source.Element) -> Bool
        ) {
            self.predicate = predicate
            self.expected = expected
        }
    }
}

extension Parser.First.Where
where Source.Element: Copyable & Escapable, Source.Failure == Never {

    public enum Error: Swift.Error, Equatable {
        case predicateFailed(expected: String)
    }
}

extension Parser.First.Where: Parser.`Protocol` {

    public typealias Input = Source

    public typealias Output = Source.Element

    public typealias Failure = Either<Parser.EndOfInput.Error, Parser.First.Where<Source>.Error>

    @inlinable
    public func parse(_ input: inout Source) throws(Failure) -> Output {
        guard let element = input.next() else {
            throw .left(.unexpected(expected: expected))
        }

        guard predicate(element) else {
            throw .right(.predicateFailed(expected: expected))
        }
        return element
    }
}
