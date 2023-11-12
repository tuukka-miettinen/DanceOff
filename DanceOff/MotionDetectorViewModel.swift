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
    @Published var danceOffData = ""
    @Published var backgroundColor: Color? = nil;
    @Published var showToast = false
    @Published var toastMessage: String?
    @Published var accelerometerUpdateInterval: Double = 1 / 60;
    @Published var isRecording = false
    private var toastTimer: Timer?
    private let windowSize = 30
    private let windowOverlap = 25
    private var motionManager = CMMotionManager()
    private var motionComparer = MotionComparer();
    private var motionDataProcessor = MotionDataProcessor()
    private var recordedData: [CMAcceleration] = []
    private var dataWindow: [CMAcceleration] = []
    private var potentialDances: [DanceModel] = []
    private var messagesQueue = [String]()
    private var debug = true
    
    init() {
        startUpdates()
    }
    
    private func startUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = accelerometerUpdateInterval
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self, let data = data else { return }
                let accelerationDataPoint = data.acceleration;
                let deltaData = self.motionDataProcessor.processNewDataPoint(accelerationDataPoint)
                
                if isRecording {
                    if (debug) { recordedData.append(accelerationDataPoint) }
                    
                    // Add current data point to data window which is used to detect if the start of any pre-recorded dance has been done
                    addDatatoWindow(currentData: accelerationDataPoint)
                    
                    // Add current data point to every ongoing potential dance in order to later check if it matches any pre-recorded dance
                    for dance in potentialDances {
                        dance.movementData.append(accelerationDataPoint)
                    }
                    
                    checkIfAnyOngoingDanceIsDone()
                }
                
                DispatchQueue.main.async {
                    if self.isRecording {
                        self.backgroundColor = self.motionDataProcessor.colorBasedOnMovement(value: deltaData)
                    } else {
                        self.backgroundColor = Color.white
                    }
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
        if debug { logData() }
    }
    
    func showToast(message: String) {
        messagesQueue.append(message)
        showNextMessage()
    }
    
    private func showNextMessage() {
        guard toastMessage == nil, !messagesQueue.isEmpty else { return }
        toastMessage = messagesQueue.removeFirst()
        toastTimer?.invalidate()
        toastTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] _ in
            self?.toastMessage = nil
            self?.showNextMessage()
        }
    }
    
    private func logData() {
        print(String(repeating: "\n", count: 100)) // clear console
        for data in recordedData {
            print("CMAcceleration(x: \(data.x), y: \(data.y), z: \(data.z)),")
        }
    }
    
    deinit {
        motionManager.stopAccelerometerUpdates()
    }
    
    //                  movement window processing
    // ================================================================
    private func addDatatoWindow(currentData: CMAcceleration) {
        dataWindow.append(currentData)
        if dataWindow.count >= windowSize {
            processWindow()
            dataWindow.removeFirst(windowSize - windowOverlap)
        }
    }
    
    private func processWindow() {
        compareWindowToDance(dance: threeChops)
        compareWindowToDance(dance: floss)
        compareWindowToDance(dance: rideThePony)
    }
    
    private func compareWindowToDance(dance: DanceModel) {
        let danceStartScore = motionComparer.compareMovements(
            currentData: Array(dance.movementData[0...30]),
            recordedData: dataWindow)
        // if debug { print("dance '\(dance.name)' score: \(danceStartScore)") }
        if let danceStartThreshold = dance.startThreshold {
            if danceStartScore < danceStartThreshold {
                if debug { print("starting potential dance '\(dance.name)' score: \(danceStartScore)") }
                startPotentialDance(danceName: dance.name);
            }
        }
    }
    
    //                  dance movement processing
    // ================================================================
    private func startPotentialDance(danceName: String) {
        potentialDances.append(DanceModel(name: danceName, movementData: dataWindow))
    }
    
    private func checkIfAnyOngoingDanceIsDone() {
        checkDance(dance: threeChops)
        checkDance(dance: floss)
        checkDance(dance: rideThePony)
    }
    
    private func checkDance(dance: DanceModel) {
        if let matchIndex = potentialDances.firstIndex(where: {
            $0.name == dance.name && $0.movementData.count >= dance.movementData.count
        }) {
            let currentDance = potentialDances[matchIndex]
            if (currentDance.valid) {
                let score = self.motionComparer.compareMovements(
                    currentData: currentDance.movementData,
                    recordedData: dance.movementData)
                if debug { print("checking dance \(dance.name) score: \(score)") }
                
                if let danceScoreThreshold = dance.scoreThreshold {
                    if score < danceScoreThreshold {
                        let userScore = (danceScoreThreshold - score) // The lower the score is, the better the dance matched the dance data
                        toastSuccessAndGivePoints(userScore: userScore, dance: dance)
                        invalidateOtherDancesOfSameType(dance: dance)
                    }
                }
            }
            
            potentialDances.remove(at: matchIndex)
        }
    }
    
    private func toastSuccessAndGivePoints(userScore: Double, dance: DanceModel) {
        let amplifier = 1.5
        let clampedScore = (50.0 + min(userScore * amplifier, 50)).rounded(toPlaces: 1); // give the user a final score between 50 and 100%
        if debug { print("did \(dance.name): \(userScore.rounded(toPlaces: 2)) -> \(clampedScore)") }
        showToast(message: "\(dance.friendlyName)\nScore \(clampedScore)")
        // TODO: implement giving points
    }
    
    private func invalidateOtherDancesOfSameType(dance: DanceModel) {
        for invalidatingDance in potentialDances.filter({ $0.name == dance.name && $0.id != dance.id }) {
            invalidatingDance.valid = false;
        }
    }
    
}
