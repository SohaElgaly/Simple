//
//  AuthViewModel.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

import Foundation
import Combine
class AuthViewModel: ObservableObject {

    @Published var phone = ""
    @Published var password = ""
    @Published var fullName = ""
    @Published var email = ""
    @Published var confirmPassword = ""
    @Published var phoneError: String? = nil
    @Published var passwordError: String? = nil
    @Published var emailError: String? = nil
    @Published var nameError: String? = nil
    @Published var confirmPasswordError: String? = nil
    @Published var isLoading = false
    @Published var isAuthenticated = false
    @Published  var showSuccessAlert = false
    private let localization = LocalizationManager.shared
    
    init() {
        checkIfLoggedIn()
    }
    func checkIfLoggedIn() {
        DispatchQueue.main.async { 
            if StorageManager.shared.loadUser() != nil {
                self.isAuthenticated = true
            }
        }
    }


    func login() {
        phoneError = nil
        passwordError = nil
   
        guard !phone.isEmpty else {
            phoneError = (localization.loacalizedKey("error_empty_phone"))
            return
        }
        
        guard Validation.isValidPhone(phone) else {
            phoneError = (localization.loacalizedKey("error_invalid_phone"))
            return
        }
 
        guard !password.isEmpty else {
            passwordError = (localization.loacalizedKey("error_empty_password"))
            return
        }
        
        guard Validation.isValidPassword(password) else {
            passwordError = (localization.loacalizedKey("error_weak_password"))
            return
        }
        
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            self.isLoading = false
          
            if let savedUser = StorageManager.shared.loadUser() {
                if savedUser.phone == self.phone && savedUser.password == self.password {
                    self.isAuthenticated = true
                } else {
                    self.passwordError = (localization.loacalizedKey("error_invalid_credentials"))
                }
            } else {
                self.phoneError = (localization.loacalizedKey("error_user_not_found"))
            }
        }
    }
    
    func register(completion: @escaping (Bool) -> Void) {
  
        phoneError = nil
        passwordError = nil
        emailError = nil
        nameError = nil
        confirmPasswordError = nil
        
        guard !fullName.isEmpty else {
            nameError = (localization.loacalizedKey("error_empty_name"))
            completion(false)
            return
        }
        
        guard Validation.isValidName(fullName) else {
            nameError = (localization.loacalizedKey("error_short_name"))
            completion(false)
            return
        }
    
        guard !email.isEmpty else {
            emailError = (localization.loacalizedKey("error_empty_email"))
            completion(false)
            return
        }
        
        guard Validation.isValidEmail(email) else {
           emailError = (localization.loacalizedKey("error_invalid_email"))
            completion(false)
            return
        }
        
        guard !phone.isEmpty else {
            phoneError = (localization.loacalizedKey("error_empty_phone"))
            completion(false)
            return
        }
        
        guard Validation.isValidPhone(phone) else {
           phoneError = (localization.loacalizedKey("error_invalid_phone"))
            completion(false)
            return
        }
       
        guard !password.isEmpty else {
          passwordError = (localization.loacalizedKey("error_empty_password"))
            completion(false)
            return
        }
        
        guard Validation.isValidPassword(password) else {
            passwordError = (localization.loacalizedKey("error_weak_password"))
            completion(false)
            return
        }
       
        guard !confirmPassword.isEmpty else {
            confirmPasswordError = (localization.loacalizedKey("error_empty_confirm_password"))
            completion(false)
            return
        }
        
        guard password == confirmPassword else {
            confirmPasswordError = (localization.loacalizedKey("error_passwords_not_match"))
            completion(false)
            return
        }
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else {
                completion(false)
                return
            }
            
            self.isLoading = false

            let user = User(
                email: self.email.lowercased().trimmingCharacters(in: .whitespaces), fullName: self.fullName.trimmingCharacters(in: .whitespaces),
                phone: self.phone.trimmingCharacters(in: .whitespaces),
                password: self.password
            )

            StorageManager.shared.saveUser(user)
       
            self.isAuthenticated = true 
            completion(true)
        }
        
    }
    
    func logout() {
        StorageManager.shared.deleteUser()
        clearFields()
        isAuthenticated = false
    }

    func clearFields() {
        phone = ""
        password = ""
        fullName = ""
        email = ""
        confirmPassword = ""
        
    }
    
    
    func getCurrentUser() -> User? {
        return StorageManager.shared.loadUser()
    }
}
