//
//  SettingsOption.swift
//  AIOutfitChecker
//
//  Model: Settings menu option
//

import Foundation

struct SettingsOption: Identifiable {
    let id = UUID()
    let title: String
    let detail: String?
    let action: () -> Void
}

struct SettingsSection {
    let title: String
    let options: [SettingsOption]
}
