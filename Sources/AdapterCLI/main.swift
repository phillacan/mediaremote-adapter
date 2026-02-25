//
//  main.swift
//  MediaRemoteAdapter
//
//  Created by Phil Lacan on 2/22/26.
//

import Foundation
import MediaRemoteAdapter

let controller = MediaController(debounce: false)

controller.onTrackInfoReceived = { trackInfo in
    guard let info = trackInfo?.payload else {
        print("NIL")
        return
    }

    let app = info.applicationName ?? info.bundleIdentifier ?? "<unknown app>"
    let title = info.title ?? "<no title>"
    let artist = info.artist ?? "<no artist>"
    let state = (info.isPlaying ?? false) ? "playing" : "paused"

    print("[\(app)] \(state) - \(title) / \(artist)")
}

controller.onListenerTerminated = {
    print("listener terminated")
}

controller.startListening()
RunLoop.main.run()
