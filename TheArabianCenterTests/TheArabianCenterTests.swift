//
//  TheArabianCenterTests.swift
//  TheArabianCenterTests
//
//  Created by Ahmed Henawey on 2/19/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import XCTest
@testable import TheArabianCenter

class TheArabianCenterTests: XCTestCase {
    
    var expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        expectation = expectation(description: "Time out")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    class ShareInteractorOutputSpy: ShareInteractorOutput
    {
        let expectation: XCTestExpectation
        
        var presentRetrieveCalled = false
        var presentRetrieveErrorCalled = false
        var syncError:Sync.Error = .unknownError
        
        init(tests: TheArabianCenterTests) {
            expectation = tests.expectation!
        }
        
        func presentShareSucceed(shareResponse:Share.Response){
            
        }
        func presentShareError(error: Share.Error){
            
        }
        
        func presentRetrieveSucceed(syncResponse:Sync.Response){
            presentRetrieveCalled = true
            expectation.fulfill()
        }
        func presentRetrieveError(error: Sync.Error){
            presentRetrieveErrorCalled = true
            syncError = error
            expectation.fulfill()
        }
        
        func presentRetrieveImageSucceed(response:Image.Download.Response){
            
        }
        func presentRetrieveImageError(error: UI.Image.Download.Error){
            
        }
    }
    
    func testSavingOfferFailure()
    {
        let shareInteractor = ShareInteractor()
        
        // Given
        let shareInteractorOutputSpy = ShareInteractorOutputSpy(tests: self)
        
        shareInteractor.output = shareInteractorOutputSpy
        
        let request = UI.Sync.Retrieve.Request(id: nil)
        
        // When
        shareInteractor.retrieve(request: request)
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                NSLog("Error: \(error)");
            }
        }
        // Then
        
        XCTAssertEqual(shareInteractorOutputSpy.syncError, Sync.Error.invalidData)
        XCTAssert(shareInteractorOutputSpy.presentRetrieveErrorCalled, "saving offer should ask presenter to present Error \(shareInteractorOutputSpy.syncError)")
    }
    
    func testRetrievingOfferSuccessful()
    {
        let shareInteractor = ShareInteractor()
        
        // Given
        let shareInteractorOutputSpy = ShareInteractorOutputSpy(tests: self)
        
        shareInteractor.output = shareInteractorOutputSpy
        
        let request = UI.Sync.Retrieve.Request(id: "-KdgwehflI-lPIo6VD0q")
        
        // When
        shareInteractor.retrieve(request: request)
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                NSLog("Error: \(error)");
            }
        }
        // Then
        XCTAssert(shareInteractorOutputSpy.presentRetrieveCalled, "retrieving offer  should ask presenter to do it")
    }
    
    
}
extension Sync.Error: Equatable{
    public static func ==(lhs: Sync.Error, rhs: Sync.Error) -> Bool {
        switch (lhs, rhs) {
        case (.invalidData, .invalidData):
            return true
        default:
            return false
        }
        
    }
}
