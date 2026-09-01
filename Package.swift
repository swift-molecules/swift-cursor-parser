// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-input-parser",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Input Parser First", targets: ["Input Parser First"]),
        .library(name: "Input Parser OneOf", targets: ["Input Parser OneOf"]),
        .library(name: "Input Parser Optionally", targets: ["Input Parser Optionally"]),
        .library(name: "Input Parser Many", targets: ["Input Parser Many"]),
        .library(name: "Input Parser Peek", targets: ["Input Parser Peek"]),
        .library(name: "Input Parser Not", targets: ["Input Parser Not"]),
        .library(name: "Input Parser Location", targets: ["Input Parser Location"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-parser.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-input.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-product.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-text.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-either.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-collection.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-collection-parser.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-always.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-always-parser.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Input Parser First",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Parser Match", package: "swift-parser"),
                .product(name: "Input Protocol", package: "swift-input"),
                .product(name: "Either", package: "swift-either"),
            ]
        ),
        .target(
            name: "Input Parser OneOf",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Input Protocol", package: "swift-input"),
                .product(name: "Product", package: "swift-product"),
            ]
        ),
        .target(
            name: "Input Parser Optionally",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Parser Take", package: "swift-parser"),
                .product(name: "Input Protocol", package: "swift-input"),
            ]
        ),
        .target(
            name: "Input Parser Many",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Parser Take", package: "swift-parser"),
                .product(name: "Input Protocol", package: "swift-input"),
            ]
        ),
        .target(
            name: "Input Parser Peek",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Input Protocol", package: "swift-input"),
            ]
        ),
        .target(
            name: "Input Parser Not",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Input Protocol", package: "swift-input"),
            ]
        ),
        .target(
            name: "Input Parser Location",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Parser Error", package: "swift-parser"),
                .product(name: "Input Namespace", package: "swift-input"),
                .product(name: "Input Protocol", package: "swift-input"),
                .product(name: "Index", package: "swift-index"),
                .product(name: "Text", package: "swift-text"),
                .product(name: "Either", package: "swift-either"),
            ]
        ),
        .target(
            name: "Input Parser Test Support",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Input Slice", package: "swift-input"),
                .product(name: "Collection Test Support", package: "swift-collection"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Input Parser First Tests",
            dependencies: [
                .target(name: "Input Parser First"),
                .target(name: "Input Parser Test Support"),
            ]
        ),
        .testTarget(
            name: "Input Parser Many Tests",
            dependencies: [
                .target(name: "Input Parser First"),
                .target(name: "Input Parser Many"),
                .target(name: "Input Parser Test Support"),
                .product(name: "Always", package: "swift-always"),
                .product(name: "Always Parser", package: "swift-always-parser"),
            ]
        ),
        .testTarget(
            name: "Input Parser Not Tests",
            dependencies: [
                .target(name: "Input Parser First"),
                .target(name: "Input Parser Not"),
                .target(name: "Input Parser Test Support"),
            ]
        ),
        .testTarget(
            name: "Input Parser OneOf Tests",
            dependencies: [
                .target(name: "Input Parser First"),
                .target(name: "Input Parser OneOf"),
                .target(name: "Input Parser Test Support"),
                .product(name: "Always", package: "swift-always"),
                .product(name: "Always Parser", package: "swift-always-parser"),
                .product(name: "Parser Map", package: "swift-parser"),
            ]
        ),
        .testTarget(
            name: "Input Parser Optionally Tests",
            dependencies: [
                .target(name: "Input Parser First"),
                .target(name: "Input Parser Optionally"),
                .target(name: "Input Parser Test Support"),
            ]
        ),
        .testTarget(
            name: "Input Parser Peek Tests",
            dependencies: [
                .target(name: "Input Parser First"),
                .target(name: "Input Parser Peek"),
                .target(name: "Input Parser Test Support"),
            ]
        ),
        .testTarget(
            name: "Input Parser Location Tests",
            dependencies: [
                .target(name: "Input Parser Location"),
                .target(name: "Input Parser Test Support"),
            ]
        ),
        .testTarget(
            name: "Input Parser Filter Tests",
            dependencies: [
                .target(name: "Input Parser First"),
                .target(name: "Input Parser Test Support"),
                .product(name: "Parser Filter", package: "swift-parser"),
            ]
        ),
        .testTarget(
            name: "Input Parser FlatMap Tests",
            dependencies: [
                .target(name: "Input Parser First"),
                .target(name: "Input Parser Test Support"),
                .product(name: "Always", package: "swift-always"),
                .product(name: "Always Parser", package: "swift-always-parser"),
                .product(name: "Parser FlatMap", package: "swift-parser"),
                .product(
                    name: "Collection Parser Consume",
                    package: "swift-collection-parser"
                ),
            ]
        ),
        .testTarget(
            name: "Input Parser Map Tests",
            dependencies: [
                .target(name: "Input Parser First"),
                .target(name: "Input Parser Test Support"),
                .product(name: "Parser Map", package: "swift-parser"),
            ]
        ),
        .testTarget(
            name: "Input Parser Take Tests",
            dependencies: [
                .target(name: "Input Parser First"),
                .target(name: "Input Parser Test Support"),
                .product(name: "Parser Match", package: "swift-parser"),
                .product(name: "Parser Take", package: "swift-parser"),
            ]
        ),
        .testTarget(
            name: "Input Parser Invariant Tests",
            dependencies: [
                .target(name: "Input Parser First"),
                .target(name: "Input Parser Many"),
                .target(name: "Input Parser Not"),
                .target(name: "Input Parser OneOf"),
                .target(name: "Input Parser Optionally"),
                .target(name: "Input Parser Peek"),
                .target(name: "Input Parser Test Support"),
                .product(name: "Either", package: "swift-either"),
                .product(name: "Always", package: "swift-always"),
                .product(name: "Always Parser", package: "swift-always-parser"),
                .product(name: "Parser Fail", package: "swift-parser"),
                .product(name: "Parser Filter", package: "swift-parser"),
                .product(name: "Parser FlatMap", package: "swift-parser"),
                .product(name: "Parser Map", package: "swift-parser"),
                .product(
                    name: "Collection Parser Consume",
                    package: "swift-collection-parser"
                ),
                .product(
                    name: "Collection Parser End",
                    package: "swift-collection-parser"
                ),
                .product(
                    name: "Collection Parser Prefix",
                    package: "swift-collection-parser"
                ),
                .product(
                    name: "Collection Parser Rest",
                    package: "swift-collection-parser"
                ),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
