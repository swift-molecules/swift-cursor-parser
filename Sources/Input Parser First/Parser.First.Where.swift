public import Input_Protocol

extension Parser.First {

    public struct Where<Source: Input.Streaming>
    where Source.Element: Copyable {
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

extension Parser.First.Where: Parser.`Protocol` {

    public typealias Input = Source

    public typealias Output = Source.Element

    public typealias Failure = Either<Parser.EndOfInput.Error, Parser.Match.Error>

    @inlinable
    public func parse(_ input: inout Source) throws(Failure) -> Output {
        guard !input.isEmpty else {
            throw .left(.unexpected(expected: expected))
        }

        let element = try! input.advance()
        guard predicate(element) else {
            throw .right(.predicateFailed(description: expected))
        }
        return element
    }
}
