//
//  User.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

import Foundation

struct User: Codable {
    let email : String
    let fullName : String
    let phone : String
    let password: String
    
    var firstName: String {
            return fullName.components(separatedBy: " ").first ?? fullName
        }
}
