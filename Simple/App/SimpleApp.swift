//
//  SimpleApp.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

import SwiftUI

@main
struct SimpleApp: App {
    @StateObject private var localization = LocalizationManager.shared
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(localization)
        }
    }
}
