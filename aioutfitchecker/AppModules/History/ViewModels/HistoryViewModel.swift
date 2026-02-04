//
//  HistoryViewModel.swift
//  AIOutfitChecker
//
//  ViewModel: History feature state management
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class HistoryViewModel {
    var historyItems: [HistoryItem] = []
    var isLoading = false
    var errorMessage: String?
    
    private let storageService: StorageServiceProtocol
    
    init(storageService: StorageServiceProtocol = StorageService.shared) {
        self.storageService = storageService
        loadHistory()
    }
    
    func loadHistory() {
        isLoading = true
        do {
            historyItems = try storageService.loadHistory()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func addToHistory(_ outfit: Outfit) {
        let item = HistoryItem(outfit: outfit)
        historyItems.insert(item, at: 0)
        
        do {
            try storageService.saveHistory(historyItems)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteHistoryItem(_ item: HistoryItem) {
        historyItems.removeAll { $0.id == item.id }
        
        do {
            try storageService.saveHistory(historyItems)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
