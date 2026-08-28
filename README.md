# swift-input-parser

Focused Parser integrations that require the checkpointing and restoration
semantics of the Input domain.

The package intentionally has no umbrella product. Import only the focused
product needed by a grammar: `Input Parser First`, `Input Parser OneOf`,
`Input Parser Optionally`, `Input Parser Many`, `Input Parser Peek`,
`Input Parser Not`, or `Input Parser Location`.
