// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AuthModule",
    defaultLocalization: "ru",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "AuthModule",
            targets: ["AuthModule"]),
    ],
    targets: [
        .target(
            name: "AuthModule"),
    ]
)
