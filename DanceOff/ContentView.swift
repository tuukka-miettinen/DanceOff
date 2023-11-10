//
//  ContentView.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 9.11.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = MotionDetectorViewModel()

    var body: some View {
        VStack {
            Text("Accelerometer Data")
                .font(.headline)
            Text(viewModel.accelerometerData)
                .font(.body)
                .padding()

            Button("Start Recording") {
                viewModel.startRecording()
            }
            .padding()

            Button("Stop Recording") {
                viewModel.stopRecording()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(viewModel.backgroundColor ?? Color.white)
        .animation(.linear(duration: 0.1), value: viewModel.backgroundColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
