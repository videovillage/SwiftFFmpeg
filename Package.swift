// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftFFmpeg",
    products: [
    .library(
      name: "SwiftFFmpeg",
      targets: ["SwiftFFmpeg"]
    )
  ],
    dependencies: [
        .package(
            url: "https://github.com/videovillage/CFFmpeg.git",
            .branch("main")
        )
    ],
    targets: [
    .target(
      name: "SwiftFFmpeg",
      dependencies: ["CFFmpeg"]
    ),
    .target(
      name: "SwiftFFmpegExamples",
      dependencies: ["SwiftFFmpeg"]
    ),
    .testTarget(
      name: "SwiftFFmpegTests",
      dependencies: ["SwiftFFmpeg"]
    ),
  ]
)
