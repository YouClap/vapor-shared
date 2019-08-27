// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YouClap",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "YouClap", targets: ["YouClap"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.3.0"),
        .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.1"),
    ],
    targets: [
        .target(name: "YouClap", dependencies: ["Vapor", "FluentMySQL"]),
    ]
)
