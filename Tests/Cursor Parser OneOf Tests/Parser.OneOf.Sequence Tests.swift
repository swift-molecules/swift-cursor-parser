import Always
import Always_Parser
import Cursor_Parser_OneOf
import Cursor_Parser_Test_Support
import Parser_Map
import Testing

private enum Choice: Equatable {
    case a
    case b
}

@Suite
struct `Parser.OneOf.Sequence` {
    @Suite struct `Builder Propagation` {}
}

extension `Parser.OneOf.Sequence`.`Builder Propagation` {

    @Test
    func `builder-composed alternation parses through the first matching branch`() throws(any Swift
        .Error)
    {
        let alternation = Parser.OneOf.Sequence {
            Always<Void>.Parser<Parser.Test.Input>(()).map { _ in Choice.a }
            Always<Void>.Parser<Parser.Test.Input>(()).map { _ in Choice.b }
        }

        var input: Parser.Test.Input = [0x41]
        #expect(try alternation.parse(&input) == .a)
    }
}
