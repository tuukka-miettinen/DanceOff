//
//  Exte sk .swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 11.11.2023.
//

import Foundation

extension Double {
    // https://stackoverflow.com/a/32581409
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
