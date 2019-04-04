//
//  ValidationUtilityTests.swift
//  SteinsKitSampleTests
//
//  Created by 史 翔新 on 2019/04/04.
//  Copyright © 2019 Crazism. All rights reserved.
//

import XCTest
@testable import SteinsKitSample

class ValidationUtilityTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let validString = "123abc"
        let invalidString = "あいうえお"
        
        let utility = ValidationUtility()
        
        let validResult = utility.result(of: validString)
        let invalidResult = utility.result(of: invalidString)
        
        XCTAssert(validResult == .success(validString), "Expected .success(\(validString)), but got \(validResult)")
        XCTAssert(invalidResult == .failure(.nonAsciiCharacters), "Expected .failure(.nonAsciiCharacters), but got \(invalidResult)")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
