//
//  MotionComparer.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 10.11.2023.
//

import CoreMotion
import Foundation

class MotionComparer {
    func compareMovements(currentData: [CMAcceleration], recordedData: [CMAcceleration]) -> Double {
        let normalizedCurrentData = currentData.map { [ $0.x, $0.y, $0.z ] };
        let normalizedRecordedData = recordedData.map { [ $0.x, $0.y, $0.z ] };
        
        let distance = partialDynamicTimeWarping(
            sequence1: normalizedCurrentData,
            sequence2: normalizedRecordedData);
        return distance;    
    }
    
    func euclideanDistance(point1: [Double], point2: [Double]) -> Double {
        guard point1.count == 3 && point2.count == 3 else { return Double.infinity }
        let dx = point1[0] - point2[0]
        let dy = point1[1] - point2[1]
        let dz = point1[2] - point2[2]
        return sqrt(dx * dx + dy * dy + dz * dz)
    }

    func dynamicTimeWarping(sequence1: [[Double]], sequence2: [[Double]]) -> Double {
        let n = sequence1.count
        let m = sequence2.count
        var dtwMatrix = Array(repeating: Array(repeating: Double.infinity, count: m), count: n)

        dtwMatrix[0][0] = 0.0

        for i in 1..<n {
            for j in 1..<m {
                let cost = euclideanDistance(point1: sequence1[i], point2: sequence2[j])
                dtwMatrix[i][j] = cost + min(dtwMatrix[i-1][j],    // Insertion
                                             dtwMatrix[i][j-1],    // Deletion
                                             dtwMatrix[i-1][j-1])  // Match
            }
        }

        return dtwMatrix[n-1][m-1]
    }

    func partialDynamicTimeWarping(sequence1: [[Double]], sequence2: [[Double]]) -> Double {
        let n = sequence1.count
        let m = sequence2.count
        var dtwMatrix = Array(repeating: Array(repeating: Double.infinity, count: m), count: n)

        dtwMatrix[0][0] = 0.0

        // Initialize the first column to 0 for partial matching
        for i in 1..<n {
            dtwMatrix[i][0] = 0.0
        }

        for i in 1..<n {
            for j in 1..<m {
                let cost = euclideanDistance(point1: sequence1[i], point2: sequence2[j])
                dtwMatrix[i][j] = cost + min(dtwMatrix[i-1][j],    // Insertion
                                             dtwMatrix[i][j-1],    // Deletion
                                             dtwMatrix[i-1][j-1])  // Match
            }
        }

        // Find the minimum value in the last row for partial matching
        return dtwMatrix[n-1].min() ?? Double.infinity
    }
}
