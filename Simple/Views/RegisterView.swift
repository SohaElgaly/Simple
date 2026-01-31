//
//  RegisterView.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm: AuthViewModel
    @EnvironmentObject var localization: LocalizationManager
      

      var body: some View {
          ZStack {
              Color.gray.opacity(0.1)
                  .ignoresSafeArea()
              
              ScrollView {
                  VStack(spacing: 25) {
                      
                      VStack(spacing: 10) {
                          Image(systemName: "person.badge.plus.fill")
                              .resizable()
                              .frame(width: 80, height: 80)
                              .foregroundColor(.black)
                              .padding(.top, 30)
                          
                          Text(localization.loacalizedKey("register_title"))
                              .font(.system(size: 32, weight: .bold))
                              .foregroundColor(.primary)
                      }
                      
                   
                      VStack(spacing: 15) {
                
                          VStack(alignment: .leading, spacing: 5) {
                              Text(localization.loacalizedKey("full_name_placeholder"))
                                  .font(.subheadline)
                                  .fontWeight(.semibold)
                                  .foregroundColor(.black)
                                  
                              TextField("", text: $vm.fullName)
                                  .textContentType(.name)
                                  .autocapitalization(.words)
                                  .padding()
                                  .background(Color(.systemBackground))
                                  .cornerRadius(10)
                                  .overlay(
                                      RoundedRectangle(cornerRadius: 10)
                                          .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                  )
                              if let error = vm.nameError {
                                 Text(error)
                                     .foregroundColor(.red)
                                     .font(.caption)
                             }
                          }
                          
                          VStack(alignment: .leading, spacing: 5) {
                              Text(localization.loacalizedKey("email_placeholder"))
                                  .font(.subheadline)
                                  .fontWeight(.semibold)
                                  .foregroundColor(.black)
                              TextField("", text: $vm.email)
                                  .keyboardType(.emailAddress)
                                  .textContentType(.emailAddress)
                                  .autocapitalization(.none)
                                  .disableAutocorrection(true)
                                  .padding()
                                  .background(Color(.systemBackground))
                                  .cornerRadius(10)
                                  .overlay(
                                      RoundedRectangle(cornerRadius: 10)
                                          .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                  )
                              if let error = vm.emailError {
                                 Text(error)
                                     .foregroundColor(.red)
                                     .font(.caption)
                             }
                          }
                          
                          VStack(alignment: .leading, spacing: 5) {
                              Text(localization.loacalizedKey("phone_placeholder"))
                                  .font(.subheadline)
                                  .fontWeight(.semibold)
                                  .foregroundColor(.black)
                              TextField("", text: $vm.phone)
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
                                  .fontWeight(.semibold)
                                  .foregroundColor(.black)
                              SecureField("", text: $vm.password)
                                  .textContentType(.newPassword)
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
                          
                          VStack(alignment: .leading, spacing: 5) {
                              Text(localization.loacalizedKey("confirm_password_placeholder"))
                                  .font(.subheadline)
                                  .fontWeight(.semibold)
                                  .foregroundColor(.black)
                              SecureField("", text: $vm.confirmPassword)
                                  .textContentType(.newPassword)
                                  .padding()
                                  .background(Color(.systemBackground))
                                  .cornerRadius(10)
                                  .overlay(
                                      RoundedRectangle(cornerRadius: 10)
                                          .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                  )
                              if let error = vm.confirmPasswordError {
                                 Text(error)
                                     .foregroundColor(.red)
                                     .font(.caption)
                             }
                          }
                      }
                      .padding(.horizontal, 20)
                      
                      Button
                      {
                          vm.register { success in
                                if success {
                                    vm.showSuccessAlert = true
                                    }
                        }
                      } label: {
                          HStack {
                              if vm.isLoading {
                                  ProgressView()
                                      .progressViewStyle(CircularProgressViewStyle(tint: .white))
                              } else {
                                  Text(localization.loacalizedKey("create_account"))
                                      .fontWeight(.semibold)
                                      .foregroundStyle(.black)
                              }
                          }
                          .frame(maxWidth: .infinity)
                          .padding()
                          .background(Color(.systemBackground))
                          .cornerRadius(10)
                          .overlay(
                              RoundedRectangle(cornerRadius: 10)
                                  .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                          )
                         
                      }
                      .disabled(vm.isLoading)
                      .padding(.horizontal, 20)
                      
                      VStack(spacing: 10) {
                          Text(localization.loacalizedKey("have_account"))
                              .foregroundColor(.secondary)
                          
                          Button {
                              vm.clearFields()
                              presentationMode.wrappedValue.dismiss()
                          }label: {
                              Text(localization.loacalizedKey("sign_in"))
                                  .fontWeight(.semibold)
                                  .foregroundColor(.black)
                          }
                      }
                      .padding(.top, 10)
                    
                  }
              }
              
              
              .navigationDestination(isPresented: $vm.isAuthenticated) {
                  MainView()
              }
          
          }
          .environment(\.layoutDirection, localization.direction)
          .navigationBarTitleDisplayMode(.inline)
          .navigationBarBackButtonHidden(true)
          .toolbar {
              ToolbarItem(placement: .navigationBarLeading) {
                  Button(action: {
                      vm.clearFields()
                      presentationMode.wrappedValue.dismiss()
                  }) {
                      HStack(spacing: 5) {
                          Image(systemName: localization.currentLang.isRTL ? "chevron.right" : "chevron.left")
                          Text(localization.loacalizedKey("sign_in"))
                      }
                  }
              }
          }
          .alert(isPresented: $vm.showSuccessAlert) {
              Alert(
                  title: Text(localization.loacalizedKey("success")),
                  message: Text("🥳🥳"),
                  dismissButton: .default(Text(localization.loacalizedKey("ok")))
              )
          }
      }
  
     
  }

#Preview {
    RegisterView(vm: AuthViewModel())
        .environmentObject(LocalizationManager.shared)
      
}
