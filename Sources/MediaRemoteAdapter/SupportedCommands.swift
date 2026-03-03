import Foundation

/// Basic supported commands 
public struct SupportedCommands: Codable, Sendable {
    public let play: Bool
    public let pause: Bool
    public let toggle: Bool
    public let prev: Bool
    public let next: Bool
    public let seek: Bool
    
    public init(from raw: String) {
        let rawCommands = raw.components(separatedBy: "\"").filter {
                $0.count > 10
            } .filter {
                let chunks = $0.components(separatedBy: ", ")
                return chunks.count >= 3 && Int(chunks[2].last?.description ?? "0") == 1
            } .map {
                $0.components(separatedBy: ", ")[1].lowercased()
            }

        play = rawCommands.contains(where: { $0.hasPrefix("play") })
        pause = rawCommands.contains(where: { $0.hasPrefix("pause") })
        toggle = rawCommands.contains(where: { $0.hasPrefix("toggle") })
        prev = rawCommands.contains(where: { $0.hasPrefix("previous") })
        next = rawCommands.contains(where: { $0.hasPrefix("next") })
        seek = rawCommands.contains(where: { $0.hasPrefix("seek") })
    }
}
