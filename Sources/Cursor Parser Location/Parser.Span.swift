import Checkpoint
public import Cursor
public import Cursor_Index
import Iterator
import Iterator_Protocol
public import Parser
public import Parser_Error

extension Parser {

    public struct Span<Base: Cursor.Counted, Upstream: Parser.`Protocol`>: Parser.`Protocol`
    where Upstream.Input == Base, Upstream.Output: Copyable & Escapable {

        public typealias Input = Cursor.Tracked<Base>

        public typealias Output = Parser.Spanned<Upstream.Output>

        public typealias Failure = Parser.Error.Located<Upstream.Failure>

        @usableFromInline
        let upstream: Upstream

        @inlinable
        public init(_ upstream: Upstream) {
            self.upstream = upstream
        }

        @inlinable
        public borrowing func parse(_ input: inout Input) throws(Failure) -> Output {
            let (value, start) = try input.parseTracked(upstream)
            return Parser.Spanned(value, start: start, end: input.currentOffset)
        }
    }
}

extension Parser.`Protocol` where Input: Cursor.Counted & Copyable & Escapable, Output: Copyable & Escapable {

    @inlinable
    public func spanned() -> Parser.Span<Input, Self> {
        Parser.Span(self)
    }
}
