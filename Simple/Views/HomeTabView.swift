//
//  HomeTabView.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

// HomeTabView.swift
import SwiftUI

struct HomeTabView: View {
    @ObservedObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(vm.localization.loacalizedKey("horizontal_section_title"))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                
                                Text(vm.localization.loacalizedKey("swipe_to_explore"))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                                .font(.title3)
                        }
                        .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(vm.horizontalItems.indices, id: \.self) { index in
                                    HorizontalCard(
                                        item: vm.horizontalItems[index],
                                        index: index
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(vm.localization.loacalizedKey("vertical_section_title"))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                
                                Text("\(vm.verticalItems.count) \(vm.localization.loacalizedKey("item"))")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        LazyVStack(spacing: 15) {
                            ForEach(vm.verticalItems.indices, id: \.self) { index in
                                VerticalCard(
                                    imageName: vm.verticalItems[index],
                                    index: index
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer(minLength: 20)
                }
            }
        }
        .environment(\.layoutDirection, vm.localization.direction)
    }
}

struct HorizontalCard: View {
    let item: String
    let index: Int
  
    let colors: [Color] = [
        .blue, .purple, .pink, .orange, .green, .red, .indigo
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                colors[index % colors.count].opacity(0.7),
                                colors[index % colors.count].opacity(0.4)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 120)
                
                Image(systemName: getIcon(for: index))
                    .font(.system(size: 50))
                    .foregroundColor(.white.opacity(0.3))
                    .padding(15)
            }
            
     
            VStack(alignment: .leading, spacing: 8) {
                Text(item)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                HStack {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    
                    Text("Featured")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(15)
        }
        .frame(width: 180)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
    
    private func getIcon(for index: Int) -> String {
        let icons = ["star.fill", "heart.fill", "bolt.fill", "flame.fill", "sparkles", "crown.fill", "gift.fill"]
        return icons[index % icons.count]
    }
}

struct VerticalCard: View {
    let imageName: String
    let index: Int
    
    var body: some View {
        HStack(spacing: 0) {
      
            if let image = UIImage(named: imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipped()
                    .cornerRadius(12)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Item \(index + 1)")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Text("Description for item number \(index + 1)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer()
                
                HStack(spacing: 15) {
                    HStack(spacing: 4) {
                        Image(systemName: "eye.fill")
                            .font(.caption)
                        Text("\((index + 1) * 100)")
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "heart.fill")
                            .font(.caption)
                        Text("\((index + 1) * 10)")
                            .font(.caption)
                    }
                    .foregroundColor(.red.opacity(0.7))
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 120)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    HomeTabView()
}
