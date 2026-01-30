//
//  MainView.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var localization = LocalizationManager.shared
    @State private var selectedTab = 0
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
              
                HomeTabView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text(localization.loacalizedKey("home_tab"))
                    }
                    .tag(0)
                
            
                PostsTabView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text(localization.loacalizedKey("posts_tab"))
                    }
                    .tag(1)
            }
            .navigationTitle(selectedTab == 0
                ? localization.loacalizedKey("home_tab")
                : localization.loacalizedKey("posts_tab"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.black)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
        .environment(\.layoutDirection, localization.direction)
    }
}

#Preview {
    MainView()
}
