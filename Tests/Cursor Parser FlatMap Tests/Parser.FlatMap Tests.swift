import Parser
import Checkpoint
import Always
import Always_Parser
import Cursor_Parser_First
import Cursor_Parser_Test_Support
import Parser_FlatMap
import Testing

@Suite
struct `Parser.FlatMap` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
}

extension `Parser.FlatMap`.Unit {
    @Test
    func `chains parsers where second depends on first output`() throws(any Swift.Error) {
        let parser = Parser.First.Element<Parser.Test.Input>()
            .flatMap { count -> Parser.Test.Take in
                Parser.Test.Take(Int(count))
            }
        var input = Parser.Test.Input([0x03, 0x0A, 0x0B, 0x0C, 0xFF])

        let result = try parser.parse(&input)

        #expect(result.count == 3)
        #expect(input.first == 0xFF)
    }
}

extension `Parser.FlatMap`.`Edge Case` {
    @Test
    func `upstream failure prevents downstream execution`() {
        let parser = Parser.First.Element<Parser.Test.Input>()
            .flatMap { _ in Always<Int>.Parser<Parser.Test.Input>(0) }
        var input = Parser.Test.Input([])

        #expect(throws: (any Swift.Error).self) {
            try parser.parse(&input)
        }
    }

    @Test
    func `downstream failure propagates as right error`() {
        let parser = Always<UInt8>.Parser<Parser.Test.Input>(5)
            .flatMap { count -> Parser.Test.Take in
                Parser.Test.Take(Int(count))
            }
        var input = Parser.Test.Input([0x01, 0x02])

        #expect(throws: (any Swift.Error).self) {
            try parser.parse(&input)
        }
    }
}
