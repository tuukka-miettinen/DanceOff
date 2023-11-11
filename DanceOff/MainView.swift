//
//  ContentView.swift
//  DanceOff
//
//  Created by Tuukka Miettinen on 11.11.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tag(0)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            DanceView()
                .tag(1)
                .tabItem {
                    Label("Dance", systemImage: "music.note")
                }
            CreateDanceMoveView()
                .tag(2)
                .tabItem {
                    Label("Create", systemImage: "plus.circle.fill")
                }
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            LeaderboardView()
                .tag(3)
                .tabItem {
                    Label("Leaderboard", systemImage: "chart.bar.fill")
                }
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
