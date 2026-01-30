//
//  Validation.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

import Foundation

struct Validation {
    
    
    static func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^01[0-9]{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    static func isValidName(_ name: String) -> Bool {
           let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
           return trimmedName.count >= 2
       }
    
    static func isValidPassword(_ password: String) -> Bool {
            return password.count >= 6
        }
    static func passwordsMatch(_ password: String, _ confirmPassword: String) -> Bool {
            return password == confirmPassword && !password.isEmpty
        }
}
