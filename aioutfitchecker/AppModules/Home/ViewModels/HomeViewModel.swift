//
//  HomeViewModel.swift
//  AIOutfitChecker
//
//  ViewModel: Home feature state management
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class HomeViewModel {
    var selectedImage: UIImage?
    var selectedOccasion: Occasion?
    var isAnalyzing = false
    var analysisResult: Outfit?
    var errorMessage: String?
    
    private let aiService: AIServiceProtocol
    
    init(aiService: AIServiceProtocol = AIService.shared) {
        self.aiService = aiService
    }
    
    var canCheckOutfit: Bool {
        selectedImage != nil && selectedOccasion != nil
    }
    
    func selectOccasion(_ occasion: Occasion) {
        selectedOccasion = occasion
    }
    
    func setImage(_ image: UIImage?) {
        selectedImage = image
    }
    
    func checkOutfit() async {
        guard let image = selectedImage,
              let occasion = selectedOccasion else {
            return
        }
        
        isAnalyzing = true
        errorMessage = nil
        
        do {
            let result = try await aiService.analyzeOutfit(image: image, occasion: occasion)
            analysisResult = result
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isAnalyzing = false
    }
    
    func reset() {
        selectedImage = nil
        selectedOccasion = nil
        analysisResult = nil
        errorMessage = nil
    }
}
