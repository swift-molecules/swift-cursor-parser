public import Parser
extension Parser.OneOf {

    @resultBuilder
    public struct Builder<Input: ~Copyable & ~Escapable, Output: ~Copyable & Escapable> {}
}

extension Parser.OneOf.Builder where Input: ~Copyable & ~Escapable, Output: ~Copyable & Escapable {

    @inlinable
    public static func buildBlock<P: Parser.`Protocol`>(
        _ parser: P
    ) -> P where P.Input == Input, P.Output == Output, P.Input: ~Copyable & ~Escapable, P.Output: ~Copyable & Escapable {
        parser
    }

    @inlinable
    public static func buildBlock<P0: Parser.`Protocol`, P1: Parser.`Protocol`>(
        _ p0: P0,
        _ p1: P1
    ) -> Parser.OneOf.Two<P0, P1>
    where
        P0.Input == Input,
        P1.Input == Input,
        P0.Output == Output,
        P1.Output == Output,
        P0.Input: ~Copyable & ~Escapable,
        P1.Input: ~Copyable & ~Escapable,
        P0.Output: ~Copyable & Escapable,
        P1.Output: ~Copyable & Escapable
    {
        Parser.OneOf.Two(p0, p1)
    }

    @inlinable
    public static func buildBlock<
        P0: Parser.`Protocol`,
        P1: Parser.`Protocol`,
        P2: Parser.`Protocol`
    >(
        _ p0: P0,
        _ p1: P1,
        _ p2: P2
    ) -> Parser.OneOf.Three<P0, P1, P2>
    where
        P0.Input == Input,
        P1.Input == Input,
        P2.Input == Input,
        P0.Output == Output,
        P1.Output == Output,
        P2.Output == Output,
        P0.Input: ~Copyable & ~Escapable,
        P1.Input: ~Copyable & ~Escapable,
        P2.Input: ~Copyable & ~Escapable,
        P0.Output: ~Copyable & Escapable,
        P1.Output: ~Copyable & Escapable,
        P2.Output: ~Copyable & Escapable
    {
        Parser.OneOf.Three(p0, p1, p2)
    }

    @inlinable
    public static func buildPartialBlock<P: Parser.`Protocol`>(
        first: P
    ) -> P where P.Input == Input, P.Output == Output, P.Input: ~Copyable & ~Escapable, P.Output: ~Copyable & Escapable {
        first
    }

    @inlinable
    public static func buildPartialBlock<Accumulated: Parser.`Protocol`, Next: Parser.`Protocol`>(
        accumulated: Accumulated,
        next: Next
    ) -> Parser.OneOf.Two<Accumulated, Next>
    where
        Accumulated.Input == Input,
        Next.Input == Input,
        Accumulated.Output == Output,
        Next.Output == Output,
        Accumulated.Input: ~Copyable & ~Escapable,
        Next.Input: ~Copyable & ~Escapable,
        Accumulated.Output: ~Copyable & Escapable,
        Next.Output: ~Copyable & Escapable
    {
        Parser.OneOf.Two(accumulated, next)
    }
}
