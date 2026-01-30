//
//  StorageManager.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

import Foundation
class StorageManager {
    
    static let shared = StorageManager()
  
  //  var errorMessage: String? = nil
    private let localization = LocalizationManager.shared
    private let userDefaultsKey = "savedUser"
   // private let postsKey = "cachedPosts"
    
    private init() {}
    func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
 
    func loadUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            return user
        }
        return nil
    }
    
 
    func deleteUser() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
    
//     func saveToCache(posts: [Post]) {
//        if let encoded = try? JSONEncoder().encode(posts) {
//            UserDefaults.standard.set(encoded, forKey: postsKey)
//        }
//    }
//    
//    func loadFromCache() -> [Post]? {
//        if let data = UserDefaults.standard.data(forKey: postsKey),
//           let posts = try? JSONDecoder().decode([Post].self, from: data) {
//            return posts
//        } else {
//            errorMessage = localization.loacalizedKey("no_posts")
//            return nil
//        }
//    }

}
