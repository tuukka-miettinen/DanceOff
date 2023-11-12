//
//  ToastView.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 11.11.2023.
//

import Foundation
import SwiftUI

struct ToastView: View {
    var message: String

    var body: some View {
        Text(message)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .multilineTextAlignment(.center)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(message: "This is a toast\nwith multiline text")
    }
}
