public import Checkpoint
public import Parser

extension Parser {

    public struct Peek<Upstream: Parser.`Protocol`>: Parser.`Protocol`
    where
        Upstream.Input: Restorable & ~Copyable & ~Escapable,
        Upstream.Output: ~Copyable & Escapable
    {

        public typealias Input = Upstream.Input

        public typealias Output = Upstream.Output

        public typealias Failure = Upstream.Failure

        @usableFromInline
        internal let upstream: Upstream

        @inlinable
        public init(_ upstream: Upstream) {
            self.upstream = upstream
        }

        @inlinable
        public borrowing func parse(_ input: inout Input) throws(Failure) -> Output {
            let checkpoint = input.checkpoint
            do throws(Upstream.Failure) {
                let result = try upstream.parse(&input)
                input.seek(to: checkpoint)
                return result
            } catch {
                input.seek(to: checkpoint)
                throw error
            }
        }
    }
}

extension Parser.`Protocol`
where Input: Restorable & ~Copyable & ~Escapable, Output: ~Copyable & Escapable {

    @inlinable
    public func peek() -> Parser.Peek<Self> {
        Parser.Peek(self)
    }
}
