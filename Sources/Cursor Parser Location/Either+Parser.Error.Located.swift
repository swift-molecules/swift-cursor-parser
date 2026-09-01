public import Either
public import Text

extension Either: Parser.Error.Located.`Protocol`
where Left: Parser.Error.Located.`Protocol`, Right: Parser.Error.Located.`Protocol` {

    @inlinable
    public var offset: Text.Position {
        switch self {
        case .left(let error): return error.offset
        case .right(let error): return error.offset
        }
    }
}

extension Either
where Left: Parser.Error.Located.`Protocol`, Right: Parser.Error.Located.`Protocol` {

    @inlinable
    public var earliestOffset: Text.Position {
        offset
    }
}
