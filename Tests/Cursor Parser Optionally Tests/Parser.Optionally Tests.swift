import Parser
import Checkpoint
import Iterator_Parser
import Cursor_Parser_Optionally
import Cursor_Parser_Test_Support
import Cursor_Standard_Library_Integration
import Testing

@Suite
struct `Parser.Optionally` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
}

extension `Parser.Optionally`.Unit {
    @Test
    func `returns value when parser succeeds`() {
        let parser = Parser.Optionally<Parser.First.Where<ArraySlice<UInt8>>> {
            Parser.First.Where<ArraySlice<UInt8>> { $0 == 0x41 }
        }
        var input = ArraySlice<UInt8>([0x41, 0x42])

        let result = parser.parse(&input)

        #expect(result != nil)
        #expect(input.first == 0x42)
    }

    @Test
    func `returns nil when parser fails`() {
        let parser = Parser.Optionally<Parser.First.Where<ArraySlice<UInt8>>> {
            Parser.First.Where<ArraySlice<UInt8>> { $0 == 0x41 }
        }
        var input = ArraySlice<UInt8>([0x42])

        let result = parser.parse(&input)

        #expect(result == nil)
    }
}

extension `Parser.Optionally`.`Edge Case` {
    @Test
    func `backtracks on failure`() {
        let parser = Parser.Optionally<Parser.First.Where<ArraySlice<UInt8>>> {
            Parser.First.Where<ArraySlice<UInt8>> { $0 == 0xFF }
        }
        var input = ArraySlice<UInt8>([0x01, 0x02])

        _ = parser.parse(&input)

        #expect(input.first == 0x01)
    }

    @Test
    func `returns nil on empty input`() {
        let parser = Parser.Optionally<Parser.First.Element<ArraySlice<UInt8>>> {
            Parser.First.Element<ArraySlice<UInt8>>()
        }
        var input = ArraySlice<UInt8>([])

        let result = parser.parse(&input)

        #expect(result == nil)
    }
}
