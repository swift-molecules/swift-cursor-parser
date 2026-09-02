public import Checkpoint
public import Parser

extension Parser {

    public struct Many<Source: Restorable, Element: Parser.`Protocol`>: Parser.`Protocol`
    where Element.Input == Source, Source.Checkpoint: Equatable, Element.Output: Copyable & Escapable {

        public typealias Input = Source

        public typealias Output = [Element.Output]

        public typealias Failure = Parser.Many<Input, Element>.Error

        public let element: Element

        public let minimum: Int

        public let maximum: Int

        @inlinable
        public init(
            _ range: PartialRangeFrom<Int>,
            @Parser.Builder<Source> element: () -> Element
        ) {
            self.element = element()
            self.minimum = range.lowerBound
            self.maximum = .max
        }

        @inlinable
        public init(
            _ range: ClosedRange<Int>,
            @Parser.Builder<Source> element: () -> Element
        ) {
            self.element = element()
            self.minimum = range.lowerBound
            self.maximum = range.upperBound
        }

        @inlinable
        public init(
            @Parser.Builder<Source> element: () -> Element
        ) {
            self.element = element()
            self.minimum = 0
            self.maximum = .max
        }

        @inlinable
        public borrowing func parse(_ input: inout Source) throws(Failure) -> Output {
            var results: [Element.Output] = []
            if maximum < .max {
                results.reserveCapacity(maximum)
            } else if minimum > 0 {
                results.reserveCapacity(minimum)
            }

            while results.count < maximum {
                let checkpoint = input.checkpoint

                do throws(Element.Failure) {
                    let next = try element.parse(&input)
                    results.append(next)
                    if input.checkpoint == checkpoint {
                        break
                    }
                } catch {
                    input.seek(to: checkpoint)
                    break
                }
            }

            if results.count < minimum {
                throw Failure.countTooLow(expected: minimum, got: results.count)
            }

            return results
        }
    }
}
