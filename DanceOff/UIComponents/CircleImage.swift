//
//  CircleImage.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 9.11.2023.
//

import Foundation
import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("max power")
            .clipShape(Circle())
            .overlay(
                Circle().stroke(.gray, lineWidth: 4)
            )
            .shadow(radius: 7)
            
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
