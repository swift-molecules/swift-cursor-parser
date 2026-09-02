public import Parser
public import Parser_Error
import Iterator
public import Iterator_Protocol
public import Cardinal
public import Checkpoint
public import Cursor
public import Cursor_Index
public import Cardinal_Carrier
public import Cardinal_Tagged
public import Index
public import Ordinal
import Ordinal_Cardinal
public import Ordinal_Protocol
public import Ordinal_Tagged
public import Tagged

extension Cursor {

    public struct Tracked<Base: Cursor.Counted> {

        @usableFromInline
        internal var base: Base

        @usableFromInline
        internal var offset: Index::Index<Element>

        @inlinable
        public init(_ base: Base) {
            self.base = base
            self.offset = .zero
        }

        @inlinable
        public init(_ base: Base, offset: Index::Index<Element>) {
            self.base = base
            self.offset = offset
        }
    }
}

extension Cursor.Tracked {

    @inlinable
    public var input: Base { base }

    @inlinable
    public var currentOffset: Index::Index<Element> { offset }
}

extension Cursor.Tracked: Cursor.Counted {

    public typealias Element = Base.Element

    public struct Checkpoint: Comparable {
        @usableFromInline
        let baseCheckpoint: Base.Checkpoint

        @usableFromInline
        let trackedOffset: Index::Index<Element>

        @inlinable
        package init(baseCheckpoint: Base.Checkpoint, trackedOffset: Index::Index<Element>) {
            self.baseCheckpoint = baseCheckpoint
            self.trackedOffset = trackedOffset
        }
    }

    @inlinable
    public var count: Index::Index<Element>.Count {
        base.count
    }

    @inlinable
    public var checkpoint: Checkpoint {
        Checkpoint(baseCheckpoint: base.checkpoint, trackedOffset: offset)
    }

    @inlinable
    public var bounds: ClosedRange<Checkpoint> {
        let baseRange = base.bounds
        return Checkpoint(
            baseCheckpoint: baseRange.lowerBound,
            trackedOffset: .zero
        )...Checkpoint(baseCheckpoint: baseRange.upperBound, trackedOffset: .zero)
    }

    @inlinable
    public mutating func seek(to checkpoint: Checkpoint) {
        base.seek(to: checkpoint.baseCheckpoint)
        offset = checkpoint.trackedOffset
    }

    public typealias Failure = Base.Failure

    @inlinable
    public mutating func next() throws(Base.Failure) -> Element? {
        guard let element = try base.next() else { return nil }
        offset += .one
        return element
    }

    @inlinable
    public mutating func advance(by count: Index::Index<Element>.Count) {
        offset += count
        base.advance(by: count)
    }
}

extension Cursor.Tracked.Checkpoint {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.baseCheckpoint == rhs.baseCheckpoint
    }

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.baseCheckpoint < rhs.baseCheckpoint
    }
}

extension Cursor.Tracked.Checkpoint: Sendable where Base.Checkpoint: Sendable {}

extension Cursor.Tracked {

    @inlinable
    public mutating func parseTracked<P: Parser.`Protocol`>(
        _ parser: P
    ) throws(Parser.Error.Located<P.Failure>) -> (output: P.Output, start: Index::Index<Element>)
    where P.Input == Base, P.Output: Copyable & Escapable {
        let start = currentOffset
        let countBefore = base.count
        let value: P.Output
        do throws(P.Failure) {
            value = try parser.parse(&base)
        } catch {
            throw Parser.Error.Located(error, at: start)
        }
        offset += countBefore.subtract.saturating(base.count)
        return (value, start)
    }
}

extension Cursor.Tracked {

    @inlinable
    public func savepoint() -> (base: Base, offset: Index::Index<Element>) {
        (base, offset)
    }

    @inlinable
    public mutating func restore(to savepoint: (base: Base, offset: Index::Index<Element>)) {
        self.base = savepoint.base
        self.offset = savepoint.offset
    }
}
