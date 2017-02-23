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
        
        var presentSyncCalled = false
        var presentSyncErrorCalled = false
        var syncError:Sync.Error = .unknownError
        
        init(tests: TheArabianCenterTests) {
            expectation = tests.expectation!
        }
        
        func presentShareSucceed(shareResponse:Share.Response){
            
        }
        func presentShareError(error: Share.Error){
            
        }
        
        func presentSyncSucceed(syncResponse:Sync.Response){
            presentSyncCalled = true
            expectation.fulfill()
        }
        func presentSyncError(error: Sync.Error){
            presentSyncErrorCalled = true
            syncError = error
            expectation.fulfill()
        }
    }
    
    func testSavingOfferFailure()
    {
        let shareInteractor = ShareInteractor()
        
        // Given
        let shareInteractorOutputSpy = ShareInteractorOutputSpy(tests: self)
        
        shareInteractor.output = shareInteractorOutputSpy
        
        let request = Sync.Save.Request(title: "", description: "", image: nil, location: nil)
        
        // When
        shareInteractor.save(request: request)
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                NSLog("Error: \(error)");
            }
        }
        // Then
        
        XCTAssertEqual(shareInteractorOutputSpy.syncError, Sync.Error.invalidData)
        XCTAssert(shareInteractorOutputSpy.presentSyncErrorCalled, "saving offer should ask presenter to present Error \(shareInteractorOutputSpy.syncError)")
    }
    
    func testSavingOfferSuccessful()
    {
        let shareInteractor = ShareInteractor()
        
        // Given
        let shareInteractorOutputSpy = ShareInteractorOutputSpy(tests: self)
        
        shareInteractor.output = shareInteractorOutputSpy
        
        let request = Sync.Save.Request(title: "", description: "", image: UIImage(named: "twitter"), location: nil)
        
        // When
        shareInteractor.save(request: request)
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                NSLog("Error: \(error)");
            }
        }
        // Then
        XCTAssert(shareInteractorOutputSpy.presentSyncCalled, "saving offer  should ask presenter to do it")
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
