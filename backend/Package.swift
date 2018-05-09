// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "backend",
    products: [
        .library(name: "App", targets: ["App"]),
        .executable(name: "Run", targets: ["Run"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.2.0")),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: ["Vapor"],
            exclude: ["Config", "Database", "Public", "Resources"]
        ),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App", "Testing"])
    ]
)
