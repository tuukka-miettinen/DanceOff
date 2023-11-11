//
//  DanceData.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 11.11.2023.
//

import Foundation
import CoreMotion

public class DanceModel {
    
    public init(name: String,
                friendlyName: String? = nil,
                startThreshold: Double? = nil,
                scoreThreshold: Double? = nil,
                movementData: [CMAcceleration]) {
        self.id = NSUUID().uuidString
        self.name = name
        self.friendlyName = friendlyName ?? name
        self.movementData = movementData
        self.valid = true

        // The start threshold is calculated using dynamic time warping and euclidean distance
        //   -- lower values for means harder to match for compared movement
        self.startThreshold = startThreshold ?? nil
        self.scoreThreshold = scoreThreshold ?? nil // The score threshold is also calculated using dynamic time warping and euclidean distance
    }
    
    public let id: String;
    public let name: String
    public let friendlyName: String
    public let startThreshold: Double?;
    public let scoreThreshold: Double?;
    public var valid: Bool;
    public var movementData: [CMAcceleration]
}
