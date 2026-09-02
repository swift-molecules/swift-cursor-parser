import Checkpoint
public import Cursor
public import Cursor_Index
import Iterator
import Iterator_Protocol
public import Parser
public import Parser_Error

extension Parser {

    public struct Locate<Base: Cursor.Counted, Upstream: Parser.`Protocol`>: Parser.`Protocol`
    where Upstream.Input == Base, Upstream.Output: Copyable & Escapable {

        public typealias Input = Cursor.Tracked<Base>

        public typealias Output = Upstream.Output

        public typealias Failure = Parser.Error.Located<Upstream.Failure>

        @usableFromInline
        let upstream: Upstream

        @inlinable
        public init(_ upstream: Upstream) {
            self.upstream = upstream
        }

        @inlinable
        public borrowing func parse(_ input: inout Input) throws(Failure) -> Output {
            try input.parseTracked(upstream).output
        }
    }
}

extension Parser.`Protocol` where Input: Cursor.Counted & Copyable & Escapable, Output: Copyable & Escapable {

    @inlinable
    public func located() -> Parser.Locate<Input, Self> {
        Parser.Locate(self)
    }
}
