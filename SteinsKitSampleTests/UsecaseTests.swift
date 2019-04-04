//
//  UsecaseTests.swift
//  SteinsKitSampleTests
//
//  Created by 史 翔新 on 2019/04/04.
//  Copyright © 2019 Crazism. All rights reserved.
//

import XCTest
@testable import SteinsKitSample

private let successString = "success"
private let failureString = "failure"

class UsecaseTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let repository = Repository()
        let validation = ValidationUtility()
        let usecase = Usecase(repository: repository, validation: validation)
        
        usecase._timesOfCalculation.runWithLatestValue {
            XCTAssert($0 == 0, "Should be 0, but got \($0)")
        }
        usecase._calculationResult.runWithLatestValue {
            XCTFail("Should not be inited yet, but got \($0)")
        }
        
        usecase._calculateLength(of: successString)
        usecase._timesOfCalculation.runWithLatestValue {
            XCTAssert($0 == 1, "Should be 1, but got \($0)")
        }
        usecase._calculationResult.runWithLatestValue {
            XCTAssert($0 == "7", "Should be success, but got \($0)")
        }
        
        usecase._calculateLength(of: failureString)
        usecase._timesOfCalculation.runWithLatestValue {
            XCTAssert($0 == 2, "Should be 2, but got \($0)")
        }
        usecase._calculationResult.runWithLatestValue {
            XCTAssert($0 == "Error Domain=a Code=0 \"(null)\"", "Should be Error Domain=a Code=0 \"(null)\", but got \($0)")
        }
        
        usecase._calculateLength(of: "any other string")
        usecase._timesOfCalculation.runWithLatestValue {
            XCTAssert($0 == 3, "Should be 3, but got \($0)")
        }
        usecase._calculationResult.runWithLatestValue {
            XCTAssert($0 == "nonAsciiCharacters", "Should be nonAsciiCharacters, but got \($0)")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

private final class Repository: RepositoryProtocol {
    
    func count(string: String, completion: @escaping (Result<Int, Error>) -> Void) {
        if string == successString {
            completion(.success(7))
        } else {
            completion(.failure(NSError(domain: "a", code: 0, userInfo: nil)))
        }
    }
    
}

private final class ValidationUtility: ValidationUtilityProtocol {
    
    func result(of input: String) -> AsciiStringValidationResult {
        switch input {
        case successString, failureString:
            return .success(input)
            
        case _:
            return .failure(.nonAsciiCharacters)
        }
    }
    
}
