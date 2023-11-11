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
        ZStack {
            VStack {
                Text("Dance Off!")
                    .font(.headline)
                Text(viewModel.danceOffData)
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
            .animation(
                .linear(duration: 0.1),
                value: viewModel.backgroundColor)
            
            VStack {
                if let message = viewModel.toastMessage {
                    withAnimation {
                        ToastView(message: message)
                    }
                }
                Spacer()
            }
            .padding(.top, 30)
            .animation(Animation.easeInOut(duration: 0.25), value: viewModel.toastMessage)

        }
        .onTapGesture {
            viewModel.showToast(message: "Toaster!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
