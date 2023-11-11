//
//  LeaderboardView.swift
//  DanceOff
//
//  Created by Ming Xiong on 11.11.2023.
//

import SwiftUI

struct Player: Identifiable {
    var id = UUID()
    var name: String
    var score: Int
    var avatar: String
}

struct LeaderboardView: View {
    @State private var players: [Player] = [
        Player(name: "DanceMaster123", score: 1820, avatar: "person.circle.fill"),
        Player(name: "GroovyGuru", score: 1095, avatar: "person.fill"),
        Player(name: "FunkyDancer22", score: 1385, avatar: "person.2.fill"),
        Player(name: "RhythmKing", score: 1475, avatar: "person.3.fill"),
        Player(name: "JazzJiver", score: 1160, avatar: "person.crop.circle.fill"),
        Player(name: "TwistMaster", score: 110, avatar: "person.circle.fill"),
        Player(name: "DancePro", score: 1280, avatar: "person.fill"),
        Player(name: "HipHopHero", score: 870, avatar: "person.2.fill"),
        Player(name: "HelloDance", score: 765, avatar: "person.3.fill"),
        Player(name: "TopPlayer", score: 355, avatar: "person.crop.circle.fill"),
    ]
    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(players.sorted(by: { $0.score > $1.score })) { player in
                        LeaderboardCard(player: player, isLeading: player.score == players.max(by: { $0.score < $1.score })?.score)
                            .padding(.horizontal)
                    }
                }
            }
        }
        
    }
}

struct LeaderboardCard: View {
    var player: Player
    var isLeading: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading) {
                Image(systemName: player.avatar)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .padding(10)
                    .background(Color.purple.opacity(0.5))
                    .cornerRadius(50)
            }.padding(6)
            VStack(alignment: .leading) {
                Text(player.name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("Score: \(player.score)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(10)
            
            if isLeading {
                Image(systemName: "crown.fill")
                    .foregroundColor(.yellow)
                    .font(.headline)
                    .padding(.trailing, 5)
                    .transition(.scale)
            }
            
            Spacer()
        }
        
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
