public import Input_Protocol

extension Parser.First {

    public struct Element<Source: Input.Streaming>
    where Source.Element: Copyable {

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
        guard !input.isEmpty else {
            throw .unexpected(expected: "any element")
        }

        return try! input.advance()
    }
}
