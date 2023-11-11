//
//  CreateDanceMoveView.swift
//  DanceOff
//
//  Created by Ming Xiong on 11.11.2023.
//

import SwiftUI

struct CreateDanceMoveView: View {
    @State private var danceMoveName = ""
    @State private var description = ""
    @State private var isPublic = false
    @State private var isRecording = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("Create Dance Move")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                Button(action: {
                    isRecording.toggle()
                }) {
                    Image(systemName: isRecording ? "stop.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(isRecording ? .red : .white)
                }
                
                TextField("Dance Move Name", text: $danceMoveName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                TextEditor(text: $description)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white, lineWidth: 1))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                Toggle("Make it Public", isOn: $isPublic)
                    .toggleStyle(SwitchToggleStyle(tint: .white))
                    .padding()
                
                Button(action: { }) {
                    Text("Save Dance Move")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
        }
    }
}

struct CreateDanceMoveView_Previews: PreviewProvider {
    static var previews: some View {
        CreateDanceMoveView()
    }
}
