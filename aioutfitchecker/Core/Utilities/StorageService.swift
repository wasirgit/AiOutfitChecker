//
//  StorageService.swift
//  AIOutfitChecker
//
//  Service: Local storage for history and settings
//

import Foundation

protocol StorageServiceProtocol {
    func saveHistory(_ items: [HistoryItem]) throws
    func loadHistory() throws -> [HistoryItem]
    func clearHistory() throws
}

final class StorageService: StorageServiceProtocol {
    static let shared = StorageService()
    
    private let userDefaults = UserDefaults.standard
    private let historyKey = AppConstants.StorageKeys.history
    
    private init() {}
    
    func saveHistory(_ items: [HistoryItem]) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(items)
        userDefaults.set(data, forKey: historyKey)
    }
    
    func loadHistory() throws -> [HistoryItem] {
        guard let data = userDefaults.data(forKey: historyKey) else {
            return []
        }
        let decoder = JSONDecoder()
        return try decoder.decode([HistoryItem].self, from: data)
    }
    
    func clearHistory() throws {
        userDefaults.removeObject(forKey: historyKey)
    }
}
