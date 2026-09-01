# swift-cursor-parser

Parser combinators over restorable input — the backtracking fragment of the
parser algebra.

`swift-<domain>-parser` molecules come in two species, distinguished by which
slot of `parse: (inout Input) throws(Failure) -> Output` the domain occupies:

- **Data-lift** (swift-pair-parser, swift-either-parser, swift-always-parser,
  swift-lazy-parser, swift-product-parser): a *value* of the domain type is
  itself interpreted as a parser. The domain occupies the parser slot, so the
  types spell `Pair.Parser`, `extension Either: Parser.Protocol`.
- **Input-capability** (this package, swift-collection-parser): the domain
  names a *capability of the input state*, and buys combinators that are
  undefinable without it. No cursor value is or holds a parser, so the types
  correctly stay `Parser.*` with a `where Input:` constraint.

Each combinator constrains its input to the minimum capability it needs:

- `Restorable` (swift-checkpoint) — `OneOf` (choice by failure),
  `Optionally`, `Peek` and `Not` (lookahead), `Many` (repetition; also needs
  an equatable checkpoint to detect empty progress).
- `Iterator.Protocol` (swift-iterator) — `First` (consume one element).
- `Cursor.Counted` (swift-cursor) — `Location` (checkpoints as offsets,
  spans, and located errors via `Cursor.Tracked`).

Choice by data needs none of this and lives in swift-either-parser;
sequencing lives in swift-pair-parser and swift-product-parser.

The package intentionally has no umbrella product. Import only the focused
product needed by a grammar: `Cursor Parser First`, `Cursor Parser OneOf`,
`Cursor Parser Optionally`, `Cursor Parser Many`, `Cursor Parser Peek`,
`Cursor Parser Not`, or `Cursor Parser Location`.
