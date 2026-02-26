//
//  BundleInfo.swift
//  MediaRemoteAdapter
//
//  Created by Phil Lacan on 2/23/26.
//

import Foundation

public struct BundleInfo: Codable {
    public let bid: String
    public let name: String
    
    public init(using description: String) throws {
        let pattern = #"(\S+)-(\d+) \(([^)]+)\)"#
        if let regex = try? NSRegularExpression(pattern: pattern),
            let match = regex.firstMatch(in: description, range: NSRange(description.startIndex..., in: description)),
            let bid = Range(match.range(at: 1), in: description).map({ String(description[$0]) }),
            let name = Range(match.range(at: 3), in: description).map({ String(description[$0]) }) {
            
            self.bid = bid
            self.name = name
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "string didn't match pattern \"bid-pid (name)\""))
        }
    }
}
