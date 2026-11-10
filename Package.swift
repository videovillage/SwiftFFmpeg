// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftFFmpeg",
  platforms: [.macOS(.v12)],
  products: [
    .library(
      name: "SwiftFFmpeg",
      targets: ["SwiftFFmpeg"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/videovillage/CFFmpeg.git", revision: "a038ca251c9ae19920ad2a5c379456ae14d81eaf"),
  ],
  targets: [
    .target(
      name: "SwiftFFmpeg",
      dependencies: [.product(name: "CFFmpeg", package: "CFFmpeg")]
    ),
    .executableTarget(
      name: "Examples",
      dependencies: ["SwiftFFmpeg"]
    ),
    .testTarget(
      name: "Tests",
      dependencies: ["SwiftFFmpeg"]
    ),
  ]
)
