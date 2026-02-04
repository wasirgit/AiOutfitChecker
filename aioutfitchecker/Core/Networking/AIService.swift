//
//  AIService.swift
//  AIOutfitChecker
//
//  Service: AI outfit analysis API calls
//

import Foundation
import UIKit

protocol AIServiceProtocol {
    func analyzeOutfit(image: UIImage, occasion: Occasion) async throws -> Outfit
}

final class AIService: AIServiceProtocol {
    static let shared = AIService()
    
    private init() {}
    
    func analyzeOutfit(image: UIImage, occasion: Occasion) async throws -> Outfit {
        // Simulate API call delay
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
        
        // Mock response for wireframe
        return Outfit(
            occasion: occasion,
            score: Int.random(in: 70...95),
            positivePoints: [
                "Colors complement well",
                "Fit is appropriate for occasion"
            ],
            improvementPoints: [
                "Consider adding accessories",
                "Shoes could match better"
            ],
            suggestion: "Try adding a watch or bracelet to complete the look"
        )
    }
}
