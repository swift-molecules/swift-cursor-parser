public import Checkpoint
public import Cursor
public import Cursor_Index
public import Iterator
public import Iterator_Protocol

extension Parser {

    public struct Locate<Base: Cursor.Counted, Upstream: Parser.`Protocol`>
    where Upstream.Input == Base {
        @usableFromInline
        let upstream: Upstream

        @inlinable
        public init(_ upstream: Upstream) {
            self.upstream = upstream
        }
    }
}

extension Parser.Locate: Parser.`Protocol`
where Upstream.Output: Copyable & Escapable {

    public typealias Input = Cursor.Tracked<Base>

    public typealias Output = Upstream.Output

    public typealias Failure = Parser.Error.Located<Upstream.Failure>

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) -> Output {
        try input.parseTracked(upstream).output
    }
}

extension Parser.`Protocol` where Input: Cursor.Counted & Copyable & Escapable {

    @inlinable
    public func located() -> Parser.Locate<Input, Self> {
        Parser.Locate(self)
    }
}
