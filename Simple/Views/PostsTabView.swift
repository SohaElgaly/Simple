//
//  PostsTabView.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//


import SwiftUI

struct PostsTabView: View {
    @StateObject private var vm = PostsViewModel()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
  
                if vm.isOffline {
                    HStack {
                        Image(systemName: "wifi.slash")
                        Text(vm.localization.loacalizedKey("offline_mode"))
                    }
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                }
               
                if vm.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if vm.posts.isEmpty {
                    Spacer()
                    VStack(spacing: 20) {
                        Image(systemName: "wifi.slash")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text(vm.localization.loacalizedKey("no_internet"))
                            .font(.headline)
                        
                        Button(action: { vm.loadPosts() }) {
                            Text(vm.localization.loacalizedKey("retry"))
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 12)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                    }
                    Spacer()
                } else {
                    List(vm.posts) { post in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("User \(post.userId)")
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(5)
                                
                                Spacer()
                                
                                Text("#\(post.id)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Text(post.title)
                                .font(.headline)
                            
                            Text(post.body)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                        .padding(.vertical, 5)
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .environment(\.layoutDirection, vm.localization.direction)
    }
}

#Preview {
    PostsTabView()
}
