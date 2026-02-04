//
//  Outfit.swift
//  AIOutfitChecker
//
//  Model: Outfit analysis result
//

import Foundation
import UIKit

struct Outfit: Identifiable, Codable {
    let id: UUID
    let imageData: Data?
    let occasion: Occasion
    let score: Int
    let positivePoints: [String]
    let improvementPoints: [String]
    let suggestion: String
    let createdAt: Date
    
    init(
        id: UUID = UUID(),
        imageData: Data? = nil,
        occasion: Occasion,
        score: Int,
        positivePoints: [String],
        improvementPoints: [String],
        suggestion: String,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.imageData = imageData
        self.occasion = occasion
        self.score = score
        self.positivePoints = positivePoints
        self.improvementPoints = improvementPoints
        self.suggestion = suggestion
        self.createdAt = createdAt
    }
}

enum Occasion: String, CaseIterable, Codable {
    case casual = "Casual"
    case formal = "Formal"
    case business = "Business"
    case party = "Party"
    case date = "Date"
    case workout = "Workout"
}
