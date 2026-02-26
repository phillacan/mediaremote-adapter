//
//  main.swift
//  MediaRemoteAdapter
//
//  Created by Phil Lacan on 2/22/26.
//

import Foundation
import MediaRemoteAdapter

let controller = MediaController()

controller.onTrackInfoReceived = { trackInfo in
    guard let payload = trackInfo?.payload else {
        print("NIL")
        return
    }
    let app = payload.applicationName ?? payload.bundleIdentifier ?? "<unknown app>"
    let isPlaying = payload.isPlaying ?? false
    let title = payload.title ?? "<no title>"
    print("[notif] \(app) | playing=\(isPlaying) | \(title)")
}
controller.startListening()

func fetchActiveBundles() -> [BundleInfo] {
    var result: [BundleInfo] = []
    var done = false
    controller.getActiveClients { bundles in
        result = bundles
        done = true
    }
    while !done {
        RunLoop.current.run(mode: .default, before: Date(timeIntervalSinceNow: 0.05))
    }
    return result
}

func printMenu() {
    print("")
    print("Choose an option:")
    print("1) Get active bundles")
    print("2) Enable override")
    print("3) Disable override")
    print("4) Set override app (pick from active bundles)")
    print("5) Pause")
    print("6) Play")
    print("q) Quit")
}

DispatchQueue.global(qos: .userInitiated).async {
    while true {
        printMenu()
        guard let choice = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            continue
        }

        switch choice.lowercased() {
        case "1":
            let bundles = fetchActiveBundles()
            if bundles.isEmpty {
                print("No active bundles")
            } else {
                for (idx, bundle) in bundles.enumerated() {
                    print("\(idx + 1)) \(bundle.name) - \(bundle.bid)")
                }
            }
        case "2":
            controller.enableAppOverride(enabled: true)
            print("Override enabled")
        case "3":
            controller.enableAppOverride(enabled: false)
            print("Override disabled")
        case "4":
            let bundles = fetchActiveBundles()
            if bundles.isEmpty {
                print("No active bundles to select")
                continue
            }
            for (idx, bundle) in bundles.enumerated() {
                print("\(idx + 1)) \(bundle.name) - \(bundle.bid)")
            }
            print("Select number:")
            guard let selection = readLine(),
                  let index = Int(selection),
                  index >= 1,
                  index <= bundles.count
            else {
                print("Invalid selection")
                continue
            }
            let bundle = bundles[index - 1]
            controller.setOverridingApp(bundleID: bundle.bid)
            print("Override app set to \(bundle.bid)")
        case "5":
            controller.pause()
            print("Pause sent")
        case "6":
            controller.play()
            print("Play sent")
        case "q", "quit", "exit":
            exit(0)
        default:
            print("Unknown option")
        }
    }
}

RunLoop.main.run()
