// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-cursor-parser",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Cursor Parser OneOf", targets: ["Cursor Parser OneOf"]),
        .library(name: "Cursor Parser Optionally", targets: ["Cursor Parser Optionally"]),
        .library(name: "Cursor Parser Many", targets: ["Cursor Parser Many"]),
        .library(name: "Cursor Parser Peek", targets: ["Cursor Parser Peek"]),
        .library(name: "Cursor Parser Not", targets: ["Cursor Parser Not"]),
        .library(name: "Cursor Parser Test Support", targets: ["Cursor Parser Test Support"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-parser.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-checkpoint.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-iterator.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cursor.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-product.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-either.git",
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
        .package(
            url: "https://github.com/swift-molecules/swift-iterator-parser.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Cursor Parser OneOf",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
                .product(name: "Product", package: "swift-product"),
            ]
        ),
        .target(
            name: "Cursor Parser Optionally",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
            ]
        ),
        .target(
            name: "Cursor Parser Many",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
            ]
        ),
        .target(
            name: "Cursor Parser Peek",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
            ]
        ),
        .target(
            name: "Cursor Parser Not",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
            ]
        ),
        .target(
            name: "Cursor Parser Test Support",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
                .product(name: "Iterator", package: "swift-iterator"),
                .product(name: "Iterator Protocol", package: "swift-iterator"),
                .product(name: "Cursor", package: "swift-cursor"),
                .product(name: "Cursor Standard Library Integration", package: "swift-cursor"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Cursor Parser Many Tests",
            dependencies: [
                .product(name: "Iterator Parser", package: "swift-iterator-parser"),
                .target(name: "Cursor Parser Many"),
                .target(name: "Cursor Parser Test Support"),
                .product(name: "Cursor Standard Library Integration", package: "swift-cursor"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
                .product(name: "Either", package: "swift-either"),
                .product(name: "Always", package: "swift-always"),
                .product(name: "Always Parser", package: "swift-always-parser"),
            ]
        ),
        .testTarget(
            name: "Cursor Parser Not Tests",
            dependencies: [
                .product(name: "Iterator Parser", package: "swift-iterator-parser"),
                .target(name: "Cursor Parser Not"),
                .target(name: "Cursor Parser Test Support"),
                .product(name: "Cursor Standard Library Integration", package: "swift-cursor"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
                .product(name: "Either", package: "swift-either"),
            ]
        ),
        .testTarget(
            name: "Cursor Parser OneOf Tests",
            dependencies: [
                .product(name: "Iterator Parser", package: "swift-iterator-parser"),
                .target(name: "Cursor Parser OneOf"),
                .target(name: "Cursor Parser Test Support"),
                .product(name: "Cursor Standard Library Integration", package: "swift-cursor"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
                .product(name: "Either", package: "swift-either"),
                .product(name: "Always", package: "swift-always"),
                .product(name: "Always Parser", package: "swift-always-parser"),
                .product(name: "Parser Map", package: "swift-parser"),
            ]
        ),
        .testTarget(
            name: "Cursor Parser Optionally Tests",
            dependencies: [
                .product(name: "Iterator Parser", package: "swift-iterator-parser"),
                .target(name: "Cursor Parser Optionally"),
                .target(name: "Cursor Parser Test Support"),
                .product(name: "Cursor Standard Library Integration", package: "swift-cursor"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
                .product(name: "Either", package: "swift-either"),
            ]
        ),
        .testTarget(
            name: "Cursor Parser Peek Tests",
            dependencies: [
                .product(name: "Iterator Parser", package: "swift-iterator-parser"),
                .target(name: "Cursor Parser Peek"),
                .target(name: "Cursor Parser Test Support"),
                .product(name: "Cursor Standard Library Integration", package: "swift-cursor"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
                .product(name: "Either", package: "swift-either"),
            ]
        ),
        .testTarget(
            name: "Cursor Parser FlatMap Tests",
            dependencies: [
                .product(name: "Iterator Parser", package: "swift-iterator-parser"),
                .target(name: "Cursor Parser Test Support"),
                .product(name: "Cursor Standard Library Integration", package: "swift-cursor"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
                .product(name: "Either", package: "swift-either"),
                .product(name: "Always", package: "swift-always"),
                .product(name: "Always Parser", package: "swift-always-parser"),
                .product(name: "Parser FlatMap", package: "swift-parser"),
            ]
        ),
        .testTarget(
            name: "Cursor Parser Map Tests",
            dependencies: [
                .product(name: "Iterator Parser", package: "swift-iterator-parser"),
                .target(name: "Cursor Parser Test Support"),
                .product(name: "Cursor Standard Library Integration", package: "swift-cursor"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
                .product(name: "Either", package: "swift-either"),
                .product(name: "Parser Map", package: "swift-parser"),
            ]
        ),
        .testTarget(
            name: "Cursor Parser Invariant Tests",
            dependencies: [
                .product(name: "Iterator Parser", package: "swift-iterator-parser"),
                .target(name: "Cursor Parser Many"),
                .target(name: "Cursor Parser Not"),
                .target(name: "Cursor Parser OneOf"),
                .target(name: "Cursor Parser Optionally"),
                .target(name: "Cursor Parser Peek"),
                .target(name: "Cursor Parser Test Support"),
                .product(name: "Cursor Standard Library Integration", package: "swift-cursor"),
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
                .product(name: "Either", package: "swift-either"),
                .product(name: "Either", package: "swift-either"),
                .product(name: "Always", package: "swift-always"),
                .product(name: "Always Parser", package: "swift-always-parser"),
                .product(name: "Parser FlatMap", package: "swift-parser"),
                .product(name: "Parser Map", package: "swift-parser"),
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
