//
//  AIOutfitCheckerTests.swift
//  AIOutfitCheckerTests
//
//  Unit Tests
//

import XCTest
@testable import aioutfitchecker

final class AIOutfitCheckerTests: XCTestCase {
    
    func testOutfitModel() {
        let outfit = Outfit(
            occasion: .casual,
            score: 85,
            positivePoints: ["Test point"],
            improvementPoints: ["Test improvement"],
            suggestion: "Test suggestion"
        )
        
        XCTAssertEqual(outfit.score, 85)
        XCTAssertEqual(outfit.occasion, .casual)
    }
    
    func testOccasionEnum() {
        XCTAssertEqual(Occasion.casual.rawValue, "Casual")
        XCTAssertEqual(Occasion.allCases.count, 6)
    }
    
    func testStorageService() throws {
        let service = StorageService.shared
        let testItems: [HistoryItem] = []
        
        try service.saveHistory(testItems)
        let loaded = try service.loadHistory()
        
        XCTAssertEqual(loaded.count, 0)
    }
    
    func testSettingsViewModel() {
        let viewModel = SettingsViewModel()
        
        XCTAssertEqual(viewModel.usagePlan, .free)
        XCTAssertTrue(viewModel.checkUsageLimit())
    }
}
