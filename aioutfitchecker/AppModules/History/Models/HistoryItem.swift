//
//  HistoryItem.swift
//  AIOutfitChecker
//
//  Model: History item representation
//

import Foundation

struct HistoryItem: Identifiable, Codable {
    let id: UUID
    let outfit: Outfit
    let thumbnailData: Data?
    
    var score: Int { outfit.score }
    var occasion: Occasion { outfit.occasion }
    var date: Date { outfit.createdAt }
    
    init(outfit: Outfit, thumbnailData: Data? = nil) {
        self.id = outfit.id
        self.outfit = outfit
        self.thumbnailData = thumbnailData
    }
}
