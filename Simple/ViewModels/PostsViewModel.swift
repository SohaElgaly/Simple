// PostsViewModel.swift




// PostsViewModel.swift
import Foundation
import Combine
class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var isOffline = false
    
    let localization = LocalizationManager.shared
    private let cacheKey = "posts"
    
    init() {
        loadPosts()
    }
    
    func loadPosts() {
        isLoading = true
        
        NetworkManager.shared.fetchPosts { [weak self] posts in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let posts = posts {
 
                    self?.posts = posts
                    self?.isOffline = false
                    self?.saveToCache(posts)
                } else {

                    self?.isOffline = true
                    self?.loadFromCache()
                }
            }
        }
    }
    
    private func saveToCache(_ posts: [Post]) {
        if let data = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(data, forKey: cacheKey)
        }
    }
    
    private func loadFromCache() {
        if let data = UserDefaults.standard.data(forKey: cacheKey),
           let posts = try? JSONDecoder().decode([Post].self, from: data) {
            self.posts = posts
        }
    }
}
