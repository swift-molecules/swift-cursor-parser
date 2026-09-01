public import Checkpoint
public import Cursor
public import Iterator
public import Iterator_Protocol
public import Parser

extension Parser {

    public enum Test {}
}

extension Parser.Test {

    public struct Input {

        public var bytes: [UInt8]

        public var position: Int

        @inlinable
        public init(_ bytes: [UInt8]) {
            self.bytes = bytes
            self.position = 0
        }

        @inlinable
        public init(utf8 string: Swift.String) {
            self.init([UInt8](string.utf8))
        }
    }
}

extension Parser.Test.Input: Cursor.Positioned {

    public typealias Element = UInt8

    public typealias Failure = Never

    @inlinable
    public mutating func next() -> UInt8? {
        guard position < bytes.count else { return nil }
        defer { position += 1 }
        return bytes[position]
    }

    @inlinable
    public var checkpoint: Int {
        position
    }

    @inlinable
    public mutating func seek(to checkpoint: Int) {
        position = checkpoint
    }

    @inlinable
    public var bounds: ClosedRange<Int> {
        0...bytes.count
    }
}

extension Parser.Test.Input {

    @inlinable
    public var first: UInt8? {
        position < bytes.count ? bytes[position] : nil
    }

    @inlinable
    public var isEmpty: Bool {
        position >= bytes.count
    }
}

extension Parser.Test.Input: ExpressibleByArrayLiteral {

    @inlinable
    public init(arrayLiteral elements: UInt8...) {
        self.init(elements)
    }
}

extension Parser.Test.Input: Equatable, Sendable {}

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

    public typealias Input = Parser.Test.Input

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

    public typealias Input = Parser.Test.Input

    public typealias Output = [UInt8]

    public typealias Failure = Never

    @inlinable
    public func parse(_ input: inout Input) -> [UInt8] {
        var result: [UInt8] = []
        while let element = input.first, predicate(element) {
            _ = input.next()
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

    public typealias Input = Parser.Test.Input

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

    public typealias Input = Parser.Test.Input

    public typealias Output = Void

    public typealias Failure = Parser.Test.End.Error

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) {
        guard input.isEmpty else {
            throw .unexpectedInput
        }
    }
}
