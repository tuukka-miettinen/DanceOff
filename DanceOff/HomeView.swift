//
//  HomeView.swift
//  DanceOff
//
//  Created by Ming Xiong on 11.11.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("danceoff_post")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(45)
                    .padding()
                
                Text("Dance Off!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .colorInvert()
                
                Text("Get ready to show your dance moves and challenge your friends!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .colorInvert()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.black)
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            
            .edgesIgnoringSafeArea(.vertical)
            
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
