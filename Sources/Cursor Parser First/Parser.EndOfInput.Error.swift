public import Parser
extension Parser.EndOfInput {

    public enum Error: Swift.Error, Equatable {

        case unexpected(expected: String)
    }
}
