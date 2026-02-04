//
//  SettingsViewModel.swift
//  AIOutfitChecker
//
//  ViewModel: Settings feature state management
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class SettingsViewModel {
    var usagePlan: UsagePlan = .free
    var checksRemaining: Int = 10
    var totalChecks: Int = 10
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    var checksUsed: Int {
        totalChecks - checksRemaining
    }
    
    func checkUsageLimit() -> Bool {
        return checksRemaining > 0
    }
    
    func consumeCheck() {
        guard checksRemaining > 0 else { return }
        checksRemaining -= 1
    }
}

enum UsagePlan: String, Codable {
    case free = "Free"
    case premium = "Premium"
}
