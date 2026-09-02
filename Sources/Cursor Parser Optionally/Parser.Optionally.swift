public import Checkpoint
public import Parser

extension Parser {

    public struct Optionally<Wrapped: Parser.`Protocol`>: Parser.`Protocol`
    where Wrapped.Input: Restorable, Wrapped.Output: Escapable {

        public typealias Input = Wrapped.Input

        public typealias Output = Wrapped.Output?

        public typealias Failure = Never

        public let wrapped: Wrapped

        @inlinable
        public init(_ wrapped: Wrapped) {
            self.wrapped = wrapped
        }

        @inlinable
        public init(@Parser.Builder<Wrapped.Input> _ wrapped: () -> Wrapped) {
            self.init(wrapped())
        }

        @inlinable
        public borrowing func parse(_ input: inout Input) -> Output {
            let checkpoint = input.checkpoint
            do throws(Wrapped.Failure) {
                return try wrapped.parse(&input)
            } catch {
                input.seek(to: checkpoint)
                return nil
            }
        }
    }
}
