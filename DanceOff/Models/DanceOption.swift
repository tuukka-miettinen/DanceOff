//
//  DanceOption.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 11.11.2023.
//

import Foundation

public class DanceOption: Hashable, Equatable {
    public init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    public let name: String
    public let image: String
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    public static func ==(lhs: DanceOption, rhs: DanceOption) -> Bool {
        return lhs.name == rhs.name
    }
}
