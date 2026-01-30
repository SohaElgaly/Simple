//
//  HomeViewModel.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
     let localization = LocalizationManager.shared
    @Published var  horizontalItems = ["Posts", "Images", "Comments", "Views", "Feedback", "Messages", "Notifications", "Settings"]
    @Published var verticalItems = ["images-2", "images-3", "images-4", "images-5", "images-6", "fofo"]
}
