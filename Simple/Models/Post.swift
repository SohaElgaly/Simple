//
//  Post.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

import Foundation

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
