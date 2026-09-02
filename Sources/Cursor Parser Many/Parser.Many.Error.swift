public import Parser
extension Parser.Many where Source: ~Copyable & ~Escapable {

    public enum Error: Swift.Error, Equatable {

        case countTooLow(expected: Int, got: Int)

        case countTooHigh(expected: Int, got: Int)
    }
}
