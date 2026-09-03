public import Cursor_Standard_Library_Integration
public import Parser

extension Parser {

    public enum Test {}
}

extension Parser.Test {

    public struct Take: Sendable {

        public let count: Int

        @inlinable
        public init(_ count: Int) {
            self.count = count
        }
    }
}

extension Parser.Test.Take {

    public enum Error: Swift.Error, Sendable, Equatable {

        case countTooLow(expected: Int, got: Int)
    }
}

extension Parser.Test.Take: Parser.`Protocol` {

    public typealias Input = ArraySlice<UInt8>

    public typealias Output = [UInt8]

    public typealias Failure = Parser.Test.Take.Error

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) -> [UInt8] {
        var result: [UInt8] = []
        result.reserveCapacity(count)
        while result.count < count {
            guard let element = input.next() else {
                throw .countTooLow(expected: count, got: result.count)
            }
            result.append(element)
        }
        return result
    }
}

extension Parser.Test {

    public struct TakeWhile {

        @usableFromInline
        let predicate: (UInt8) -> Bool

        @inlinable
        public init(_ predicate: @escaping (UInt8) -> Bool) {
            self.predicate = predicate
        }
    }
}

extension Parser.Test.TakeWhile: Parser.`Protocol` {

    public typealias Input = ArraySlice<UInt8>

    public typealias Output = [UInt8]

    public typealias Failure = Never

    @inlinable
    public func parse(_ input: inout Input) -> [UInt8] {
        var result: [UInt8] = []
        while let element = input.first, predicate(element) {
            _ = input.popFirst()
            result.append(element)
        }
        return result
    }
}

extension Parser.Test {

    public struct Rest: Sendable {

        @inlinable
        public init() {}
    }
}

extension Parser.Test.Rest: Parser.`Protocol` {

    public typealias Input = ArraySlice<UInt8>

    public typealias Output = [UInt8]

    public typealias Failure = Never

    @inlinable
    public func parse(_ input: inout Input) -> [UInt8] {
        var result: [UInt8] = []
        while let element = input.next() {
            result.append(element)
        }
        return result
    }
}

extension Parser.Test {

    public struct End: Sendable {

        @inlinable
        public init() {}
    }
}

extension Parser.Test.End {

    public enum Error: Swift.Error, Sendable, Equatable {

        case unexpectedInput
    }
}

extension Parser.Test.End: Parser.`Protocol` {

    public typealias Input = ArraySlice<UInt8>

    public typealias Output = Void

    public typealias Failure = Parser.Test.End.Error

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) {
        guard input.isEmpty else {
            throw .unexpectedInput
        }
    }
}
