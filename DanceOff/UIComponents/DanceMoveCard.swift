//
//  DanceMoveCard.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 11.11.2023.
//

import SwiftUI

struct DanceMoveCard: View {
    var imageName: String
    var name: String

    var body: some View {
        VStack {
            Image(imageName) // Placeholder image, replace with actual dance move images
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .padding(5)

            Text(name)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
        .padding(10)
        .cornerRadius(10)
    }
}

struct DanceMoveCard_Previews: PreviewProvider {
    static var previews: some View {
        DanceMoveCard(imageName: "challenge1", name: "Dance move")
    }
}
