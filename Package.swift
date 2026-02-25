// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MediaRemoteAdapter",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "MediaRemoteAdapter",
            type: .dynamic,
            targets: ["MediaRemoteAdapter"]),
        .executable(name: "adapter-cli", targets: ["AdapterCLI"]),

    ],
    dependencies: [],
    targets: [
        .target(
            name: "MediaRemoteAdapter",
            dependencies: ["CIMediaRemote"],
            resources: [
                .copy("Resources/run.pl")
            ]
        ),
        .target(
            name: "CIMediaRemote",
            dependencies: [],
            publicHeadersPath: "include",
            cSettings: [
                .unsafeFlags(["-fno-objc-arc"])
            ],
            linkerSettings: [
                .unsafeFlags(["-framework", "Foundation"]),
                .unsafeFlags(["-framework", "AppKit"])
            ]
        ),
        .executableTarget(
            name: "AdapterCLI",
            dependencies: ["MediaRemoteAdapter"],
            path: "Sources/AdapterCLI"
        ),
    ]
) 
