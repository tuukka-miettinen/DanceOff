//
//  MotionDataProcessor.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 10.11.2023.
//

import CoreMotion

class MotionDataProcessor {
    var lastDataPoint: CMAcceleration?
    var threshold: Double = 1;
    
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
    
    func normalizeDataPoint(_ newData: CMAcceleration) -> CMAcceleration {
        return CMAcceleration(
            x: newData.x > threshold ? 1 : newData.x,
            y: newData.y > threshold ? 1 : newData.y,
            z: newData.z > threshold ? 1 : newData.z
        )
    }
}
