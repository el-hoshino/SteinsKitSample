//
//  ViewControllerTests.swift
//  SteinsKitSampleTests
//
//  Created by 史 翔新 on 2019/04/04.
//  Copyright © 2019 Crazism. All rights reserved.
//

import XCTest
import SteinsKit
@testable import SteinsKitSample

class ViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let vc = ViewController()
        vc.usecase = Usecase()
        
        vc.loadView()
        vc.viewDidLoad()
        
        XCTAssert(vc.outputTextView.text == "123\nYou have calculated 100 times", "Output Text View's text is expected to be 123\\nYou have calculated 100 times, but got \(vc.outputTextView.text as Any)")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

private final class Usecase: UsecaseProtocol {
    
    let timesOfCalculation: AnyObservable<Int> = {
        let variable = Variable(100)
        return variable.asAnyObservable()
    }()
    
    let calculationResult: AnyObservable<String> = {
        let variable = Variable("123")
        return variable.asAnyObservable()
    }()
    
    func calculateLength(of string: String) {
        
    }
    
}
