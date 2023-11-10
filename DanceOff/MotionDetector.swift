//
//  MotionDetector.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 9.11.2023.
//

import CoreMotion

class MotionDetector {
    let motionManager = CMMotionManager()
    var updateInterval: TimeInterval
    var handler: (CMAccelerometerData?, Error?) -> Void

    init(updateInterval: TimeInterval, handler: @escaping (CMAccelerometerData?, Error?) -> Void) {
        self.updateInterval = updateInterval
        self.handler = handler
        startMotionUpdates()
    }

    func startMotionUpdates() {
        // Check if the accelerometer hardware is available.
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = updateInterval
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [weak self] (data, error) in
                self?.handler(data, error)
            }
        }
    }
    
    func stopMotionUpdates() {
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    deinit {
        stopMotionUpdates()
    }
}
