//
//  MotionDetectorViewModel.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 9.11.2023.
//

import Foundation
import CoreMotion
import Combine
import SwiftUI

class MotionDetectorViewModel: ObservableObject {
    @Published var accelerometerData = "Waiting for data..."
    @Published var backgroundColor: Color? = nil;
    private var motionManager = CMMotionManager()
    private var motionComparer = MotionComparer();
    private var motionDataProcessor = MotionDataProcessor()
    private var isRecording = false
    private var recordedData: [CMAcceleration] = []
    private var dataWindow: [CMAcceleration] = []
    private let windowSize = 20 // Example size, adjust as needed
    private let windowOverlap = 19 // Example overlap, adjust as needed
    
    init() {
        startUpdates()
    }
    
    private func startUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1 / 10
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let data = data else { return }
                let processedData = self.motionDataProcessor.processNewDataPoint(data.acceleration)
                let normalizedData = self.motionDataProcessor.normalizeDataPoint(processedData)
                
                DispatchQueue.main.async {
                    if self.isRecording {
                        self.addDatatoWindow(currentData: normalizedData)
                        self.backgroundColor = self.colorBasedOnMovement(value: normalizedData)
                        self.accelerometerData = "x: \((normalizedData.x * 100).rounded())"
                            + "\ny: \((normalizedData.y * 100).rounded())"
                            + "\nz: \((normalizedData.z * 100).rounded())"
                        
                    } else {
                        self.backgroundColor = Color.white
                    }
                }
                if self.isRecording {
                    self.recordedData.append(normalizedData)
                }
            }
        }
    }

    func startRecording() {
        recordedData.removeAll()
        isRecording = true
    }

    func stopRecording() {
        isRecording = false
        logData()
        let score = motionComparer.compareMovements(
            currentData: threeChops,
            recordedData: recordedData)
        print("score: \(score)")
    }

    private func logData() {
        for data in recordedData {
            print("CMAcceleration(x: \(data.x), y: \(data.y), z: \(data.z)),")
        }
    }
    
    private func colorBasedOnMovement(value: CMAcceleration) -> Color {
        // This is a simple example. You might want to create more complex logic.
        return Color(
            red: min(50, abs(value.x)),
            green: min(50, abs(value.y)),
            blue: min(50, abs(value.z)))
    }
    
    private func addDatatoWindow(currentData: CMAcceleration) {
        dataWindow.append(currentData)
        if dataWindow.count >= windowSize {
            processWindow()
            // Remove old data points to make room for new ones
            dataWindow.removeFirst(windowSize - windowOverlap)
        }
    }

    private func processWindow() {
        // Process the data in dataWindow here
        // For example, compare with a reference movement or log the data
        // Update UI elements if necessary
        let threeChopsScore = motionComparer.compareMovements(
            currentData: threeChops,
            recordedData: dataWindow)
        print("threeChopsScore: \(threeChopsScore)")
    }
    
    deinit {
        motionManager.stopAccelerometerUpdates()
    }
}
