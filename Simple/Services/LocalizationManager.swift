//
//  LocalizationManager.swift
//  Simple
//
//  Created by Soha Elgaly on 29/01/2026.
//

import Foundation
import SwiftUI
import Combine
class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()


    @Published var currentLang: Language  {
        didSet {
            UserDefaults.standard.set(currentLang.rawValue, forKey: "appLanguage")
        }
    }
    
    
    enum Language : String ,CaseIterable {
        case english = "en"
        case arabic = "ar"
        
        var displayName: String {
            switch self {
                case .english: return "English"
                case .arabic: return "العربية"
            }
    }
        
        var isRTL: Bool {
            return self == .arabic
        }
    }
    
    private init() {
           if let savedLang = UserDefaults.standard.string(forKey: "appLanguage"),
              let language = Language(rawValue: savedLang) {
               self.currentLang = language
           } else {
               self.currentLang = .english
           }
       }
       
    func toggleLang() {
        currentLang =  currentLang == .english ? .arabic : .english
    }
    
    func loacalizedKey(_ key : String) -> String {
      guard let path = Bundle.main.path(forResource: currentLang.rawValue, ofType: "lproj"),
            let bundle = Bundle(path: path) else {
          return key
      }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
    
    var direction: LayoutDirection {
        return currentLang.isRTL ? .rightToLeft : .leftToRight
    }
}
