//
//  AIOutfitCheckerUITests.swift
//  AIOutfitCheckerUITests
//
//  UI Tests
//

import XCTest

final class AIOutfitCheckerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTabNavigation() throws {
        let homeTab = app.tabBars.buttons["Home"]
        let historyTab = app.tabBars.buttons["History"]
        let settingsTab = app.tabBars.buttons["Settings"]
        
        XCTAssertTrue(homeTab.exists)
        XCTAssertTrue(historyTab.exists)
        XCTAssertTrue(settingsTab.exists)
        
        historyTab.tap()
        XCTAssertTrue(app.navigationBars["History"].exists)
        
        settingsTab.tap()
        XCTAssertTrue(app.navigationBars["Settings"].exists)
        
        homeTab.tap()
        XCTAssertTrue(app.navigationBars["Home"].exists)
    }
    
    func testHomeScreenElements() throws {
        XCTAssertTrue(app.navigationBars["Home"].exists)
        XCTAssertTrue(app.buttons["CHECK OUTFIT"].exists)
    }
}
