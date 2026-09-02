public import Parser
public import Parser_Error
public import Text

public protocol __ParserErrorLocatedProtocol: Swift.Error {

    var offset: Text.Position { get }
}

extension Parser.Error.Located {

    public typealias `Protocol` = __ParserErrorLocatedProtocol
}

extension Parser.Error.Located: __ParserErrorLocatedProtocol {}
