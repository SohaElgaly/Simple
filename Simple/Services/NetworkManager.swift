//
//  NetworkManager.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//


import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchPosts(completion: @escaping ([Post]?) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            print("Network connection error")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let posts = try? JSONDecoder().decode([Post].self, from: data) {
                completion(posts)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
