//
//  MotionDataProcessor.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 10.11.2023.
//

import CoreMotion
import SwiftUI

class MotionDataProcessor {
    var lastDataPoint: CMAcceleration?
    var threshold = 1;
    var colorAmplifier = 2.0;
    
    func processNewDataPoint(_ newData: CMAcceleration) -> CMAcceleration {
        guard let lastData = lastDataPoint else {
            lastDataPoint = newData
            return newData
        }

        let deltaX = newData.x - lastData.x
        let deltaY = newData.y - lastData.y
        let deltaZ = newData.z - lastData.z

        lastDataPoint = newData

        return CMAcceleration(x: deltaX, y: deltaY, z: deltaZ)
    }
    
    func colorBasedOnMovement(value: CMAcceleration) -> Color {
        return Color(
            red: min(100, abs(value.x) * colorAmplifier),
            green: min(100, abs(value.y) * colorAmplifier),
            blue: min(100, abs(value.z) * colorAmplifier))
    }
    
}
