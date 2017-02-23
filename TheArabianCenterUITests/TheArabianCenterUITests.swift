//
//  TheArabianCenterUITests.swift
//  TheArabianCenterUITests
//
//  Created by Ahmed Henawey on 2/19/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import XCTest

class TheArabianCenterUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChangeLanguageFromEnglishToArabic() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let button = app.buttons.element(matching: .button, identifier: "changeLang")
        
        let predicate = NSPredicate(format: "exists == 1")
        
        let queryArabic =  app.buttons["مسح العرض"]
        expectation(for: predicate, evaluatedWith: queryArabic, handler: nil)
        
        let queryEnglish = app.buttons["Scan Offer"]
        expectation(for: predicate, evaluatedWith: queryEnglish, handler: nil)
        
        button.tap()
        button.tap()
        
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
