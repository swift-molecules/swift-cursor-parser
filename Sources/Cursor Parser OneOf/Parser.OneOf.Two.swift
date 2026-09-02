public import Checkpoint
public import Parser
public import Product

extension Parser.OneOf {

    public struct Two<P0: Parser.`Protocol`, P1: Parser.`Protocol`>: Parser.`Protocol`
    where
        P0.Input == P1.Input,
        P0.Output == P1.Output,
        P0.Input: Restorable,
        P0.Output: Escapable
    {

        public typealias Input = P0.Input

        public typealias Output = P0.Output

        public typealias Failure = Product::Product<P0.Failure, P1.Failure>

        public let p0: P0

        public let p1: P1

        @inlinable
        public init(_ p0: P0, _ p1: P1) {
            self.p0 = p0
            self.p1 = p1
        }

        @inlinable
        public borrowing func parse(_ input: inout Input) throws(Failure) -> Output {
            let checkpoint = input.checkpoint

            do throws(P0.Failure) {
                return try p0.parse(&input)
            } catch let error0 {
                input.seek(to: checkpoint)
                do throws(P1.Failure) {
                    return try p1.parse(&input)
                } catch let error1 {
                    throw Failure(error0, error1)
                }
            }
        }
    }
}
