public import Checkpoint

extension Parser {

    public struct Peek<Upstream: Parser.`Protocol`>
    where Upstream.Input: Restorable {
        @usableFromInline
        internal let upstream: Upstream

        @inlinable
        public init(_ upstream: Upstream) {
            self.upstream = upstream
        }
    }
}

extension Parser.Peek: Parser.`Protocol`
where Upstream.Output: Escapable {

    public typealias Input = Upstream.Input

    public typealias Output = Upstream.Output

    public typealias Failure = Upstream.Failure

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) -> Output {
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

extension Parser.`Protocol` where Input: Restorable {

    @inlinable
    public func peek() -> Parser.Peek<Self> {
        Parser.Peek(self)
    }
}
