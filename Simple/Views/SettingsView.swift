//
//  SettingsView.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

// SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var localization = LocalizationManager.shared
    @StateObject private var authViewModel = AuthViewModel()
    @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationStack {
            List {
              
                Section(header: Text(localization.loacalizedKey("language_section"))) {
                    HStack {
                        Text(localization.loacalizedKey("current_language"))
                        Spacer()
                        Text(localization.currentLang.displayName)
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        withAnimation {
                            localization.toggleLang()
                        }
                    }) {
                        HStack {
                            Image(systemName: "globe")
                            Text(localization.loacalizedKey("change_language"))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .foregroundColor(.black)
                    }
                }
                
             
                Section(header: Text(localization.loacalizedKey("account_section"))) {
                    if let user = authViewModel.getCurrentUser() {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(user.fullName)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(user.phone)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                    
                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text(localization.loacalizedKey("logout"))
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle(localization.loacalizedKey("settings"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                }
            }
            .alert(isPresented: $showLogoutAlert) {
                Alert(
                    title: Text(localization.loacalizedKey("logout")),
                    message: Text(localization.loacalizedKey("logout_confirmation")),
                    primaryButton: .destructive(Text(localization.loacalizedKey("logout"))) {
                        authViewModel.logout()
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel(Text(localization.loacalizedKey("cancel")))
                )
            }
        }
        .environment(\.layoutDirection, localization.direction)
    }
}

#Preview {
    SettingsView()
}
