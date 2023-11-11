//
//  ContentView.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 9.11.2023.
//

import SwiftUI

struct DanceView: View {
    @ObservedObject private var viewModel = MotionDetectorViewModel()
    
    var danceOptions: [DanceOption] = [
        DanceOption(name: "Chops", image: "chop"),
        DanceOption(name: "Floss", image: "floss"),
        DanceOption(name: "Pony", image: "challenge3"),
        DanceOption(name: "Scooby", image: "challenge4"),
        DanceOption(name: "Bond", image: "challenge5"),
        DanceOption(name: "Kick", image: "challenge6"),
        DanceOption(name: "Rock", image: "challenge7"),
        DanceOption(name: "Twirl", image: "challenge8"),
        DanceOption(name: "Jog", image: "challenge9")
    ]

    var body: some View {
        ZStack {
            VStack {
                if !viewModel.isRecording {
                    Text("Trending dances")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                            ForEach(danceOptions, id: \.self) { option in
                                DanceMoveCard(imageName: option.image, name: option.name)
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                    Button(action: { viewModel.startRecording() }) {
                        Text("Start Dancing")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                } else {
                    Spacer()
                    Button(action: { viewModel.stopRecording() }) {
                        Text("Finish Dancing")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
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
    }
}

struct DanceView_Previews: PreviewProvider {
    static var previews: some View {
        DanceView()
    }
}
