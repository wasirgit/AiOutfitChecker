//
//  Constants.swift
//  AIOutfitChecker
//
//  App-wide constants and enums
//

import Foundation

enum AppConstants {
    // API Configuration
    enum API {
        static let baseURL = "https://api.aioutfitchecker.com"
        static let timeout: TimeInterval = 30.0
    }
    
    // UI Constants
    enum UI {
        static let cornerRadius: CGFloat = 8.0
        static let defaultPadding: CGFloat = 16.0
        static let buttonHeight: CGFloat = 50.0
    }
    
    // Limits
    enum Limits {
        static let maxImageSize: Int = 10 * 1024 * 1024 // 10MB
        static let freeChecksPerDay = 10
        static let premiumChecksPerDay = 100
    }
    
    // Storage Keys
    enum StorageKeys {
        static let history = "outfit_history"
        static let settings = "app_settings"
    }
}
