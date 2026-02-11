// swift-tools-version: 5.9
// Package.swift for Grounded dependencies

import PackageDescription

let package = Package(
    name: "Grounded",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Grounded",
            targets: ["Grounded"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/superwall/Superwall-iOS", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "Grounded",
            dependencies: [
                .product(name: "SuperwallKit", package: "Superwall-iOS")
            ]
        )
    ]
)
