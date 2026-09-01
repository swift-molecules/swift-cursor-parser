public import Checkpoint

extension Parser {

    public struct Optionally<Wrapped: Parser.`Protocol`>
    where Wrapped.Input: Restorable {

        public let wrapped: Wrapped

        @inlinable
        public init(_ wrapped: Wrapped) {
            self.wrapped = wrapped
        }
    }
}

extension Parser.Optionally {

    @inlinable
    public init(@Parser.Builder<Wrapped.Input> _ wrapped: () -> Wrapped) {
        self.init(wrapped())
    }
}

extension Parser.Optionally: Parser.`Protocol`
where Wrapped.Output: Escapable {

    public typealias Input = Wrapped.Input

    public typealias Output = Wrapped.Output?

    public typealias Failure = Never

    @inlinable
    public func parse(_ input: inout Input) -> Output {
        let checkpoint = input.checkpoint
        do throws(Wrapped.Failure) {
            return try wrapped.parse(&input)
        } catch {
            input.seek(to: checkpoint)
            return nil
        }
    }
}
