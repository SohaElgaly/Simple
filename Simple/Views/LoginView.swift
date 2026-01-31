//
//  LoginView.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var localization: LocalizationManager
    @ObservedObject var vm = AuthViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.1)
                    .ignoresSafeArea()
               
                VStack {
                    VStack(spacing: 10) {
                    Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.black)
                            .padding(.top, 50)

                    Text(localization.loacalizedKey("login_title"))
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)
                }
                    .padding(.bottom,50)
                    VStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(localization.loacalizedKey("phone_placeholder"))
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            TextField("" ,text: $vm.phone)
                                .keyboardType(.phonePad)
                                .textContentType(.telephoneNumber)
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            if let error = vm.phoneError {
                               Text(error)
                                   .foregroundColor(.red)
                                   .font(.caption)
                           }
                        }
                    
                        VStack(alignment: .leading, spacing: 5) {
                            Text(localization.loacalizedKey("password_placeholder"))
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            SecureField("" ,text: $vm.password)
                                .textContentType(.password)
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            if let error = vm.passwordError {
                               Text(error)
                                   .foregroundColor(.red)
                                   .font(.caption)
                           }
                        }
                       
                    }.padding(.horizontal,20)
                    
                    Button {
                        vm.login()
                    } label: {
                        Text(localization.loacalizedKey("sign_in"))
                           .fontWeight(.semibold)
                           .foregroundStyle(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.cornerRadius(10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding()
                    .disabled(vm.isLoading)
                    VStack(spacing: 10) {
                       Text(localization.loacalizedKey("no_account"))
                          .foregroundColor(.black)
                                                
                        NavigationLink(destination: RegisterView(vm: vm)) {
                            Text(localization.loacalizedKey("register_button"))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
               }
                .padding(.top, 10)
                    
                    
                    Button {
                    withAnimation {
                            localization.toggleLang()
                            }
                    } label: {
                        HStack(spacing: 8) {
                           Image(systemName: "globe")
                           Text(localization.loacalizedKey("change_language"))
                        }
                        .foregroundStyle(.black)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                    .padding(.top, 20)
                    
                }
            }
            .navigationDestination(isPresented: $vm.isAuthenticated) {
                MainView()
            }
        }
        .environment(\.layoutDirection, localization.direction)
        .navigationBarHidden(true)
    }
}

#Preview {
    LoginView()
        .environmentObject(LocalizationManager.shared)
}
