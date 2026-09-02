public import Checkpoint
public import Parser

extension Parser {

    public struct Not<Upstream: Parser.`Protocol`>: Parser.`Protocol`
    where
        Upstream.Input: Restorable & ~Copyable & ~Escapable,
        Upstream.Output: ~Copyable & ~Escapable
    {

        public typealias Input = Upstream.Input

        public typealias Output = Void

        public typealias Failure = Parser.Not<Upstream>.Error

        @usableFromInline
        internal let upstream: Upstream

        @inlinable
        public init(_ upstream: Upstream) {
            self.upstream = upstream
        }

        @inlinable
        public borrowing func parse(_ input: inout Input) throws(Failure) {
            let checkpoint = input.checkpoint
            do throws(Upstream.Failure) {
                _ = try upstream.parse(&input)
            } catch {
                input.seek(to: checkpoint)
                return
            }
            input.seek(to: checkpoint)
            throw .unexpectedMatch
        }
    }
}

extension Parser.Not
where Upstream.Input: ~Copyable & ~Escapable, Upstream.Output: ~Copyable & ~Escapable {

    public enum Error: Swift.Error, Hashable {

        case unexpectedMatch
    }
}

extension Parser.`Protocol`
where Input: Restorable & ~Copyable & ~Escapable, Output: ~Copyable & ~Escapable {

    @inlinable
    public func not() -> Parser.Not<Self> {
        Parser.Not(self)
    }
}
