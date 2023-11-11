//
//  DanceView.swift
//  DanceOff
//
//  Created by Ming Xiong on 11.11.2023.
//

import SwiftUI

struct IonaDanceView: View {
    @State private var selectedOption: String = ""
    @State private var isRecording: Bool = false

    var danceOptions: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

    var body: some View {
        VStack {
            Text("Trending dances")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(danceOptions, id: \.self) { option in
                        DanceMoveCard(imageName: "challenge\(option)", name: "DanceMove \(option)")
                    }
                }
            }
            .padding()

            Button(action: {
                isRecording.toggle()
            }) {
                Text(isRecording ? "Stop Recording" : "Start Dancing")
                    .padding()
                    .background(isRecording ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}

struct IonaDanceView_Previews: PreviewProvider {
    static var previews: some View {
        IonaDanceView()
    }
}
