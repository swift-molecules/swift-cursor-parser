# swift-input-parser

Parser combinators over restorable input.

`swift-<domain>-parser` molecules come in two species, distinguished by which
slot of `parse: (inout Input) throws(Failure) -> Output` the domain occupies:

- **Data-lift** (swift-pair-parser, swift-either-parser, swift-always-parser,
  swift-lazy-parser, swift-product-parser): a *value* of the domain type is
  itself interpreted as a parser — a pair of parsers sequences, an either of
  parsers branches. The domain occupies the parser slot, so the types spell
  `Pair.Parser`, `extension Either: Parser.Protocol`.
- **Input-capability** (this package, swift-collection-parser): the domain
  names a *capability of the input state*, and buys combinators that are
  undefinable without it. No `Input` value is or holds a parser, so the types
  correctly stay `Parser.*` with a `where Input:` constraint.

This package is the backtracking fragment of the parser algebra — the
combinators whose parse bodies must un-consume input, which only exists when
the input can checkpoint and restore (`Input.Restorable`, and for element
consumption `Input.Streaming`): `First` (consume one element), `OneOf`
(choice by failure), `Many` (repetition), `Optionally`, `Peek` and `Not`
(lookahead), and `Location` (checkpoints as positions and spans). Choice by
data needs none of this and lives in swift-either-parser; sequencing lives in
swift-pair-parser and swift-product-parser.

The package intentionally has no umbrella product. Import only the focused
product needed by a grammar: `Input Parser First`, `Input Parser OneOf`,
`Input Parser Optionally`, `Input Parser Many`, `Input Parser Peek`,
`Input Parser Not`, or `Input Parser Location`.
