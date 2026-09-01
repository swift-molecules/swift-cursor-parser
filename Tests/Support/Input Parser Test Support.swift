public import Collection_Test_Support
public import Input_Namespace
public import Input_Slice
public import Parser

extension Parser {

    public enum Test {}
}

extension Parser.Test {

    public typealias Input = Input_Namespace::Input.Slice<Collection.Fixture.Source<UInt8>>
}

extension Input.Slice: @retroactive ExpressibleByArrayLiteral
where Base == Collection.Fixture.Source<UInt8> {

    public init(arrayLiteral elements: UInt8...) {
        self.init(Collection.Fixture.Source(elements))
    }
}

extension Input.Slice where Base == Collection.Fixture.Source<UInt8> {

    public init(_ bytes: [UInt8]) {
        self.init(Collection.Fixture.Source(bytes))
    }

    public init(utf8 string: Swift.String) {
        self.init([UInt8](string.utf8))
    }
}
