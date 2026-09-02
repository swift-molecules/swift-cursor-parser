public import Parser

extension Parser.OneOf {

    public struct Sequence<Input, Output, Body: Parser.`Protocol`>: Parser.`Protocol`
    where Body.Input == Input, Body.Output == Output {

        public typealias Failure = Body.Failure

        public let body: Body

        @inlinable
        public init(
            @Parser.OneOf.Builder<Input, Output> _ build: () -> Body
        ) {
            self.body = build()
        }

        @inlinable
        public borrowing func parse(_ input: inout Input) throws(Failure) -> Output {
            try body.parse(&input)
        }
    }
}
