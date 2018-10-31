//
//  SocialGamingPlatformTests.swift
//  SocialGamingPlatformTests
//
//  Created by Adam Law on 10/27/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
@testable import SocialGamingPlatform

class SocialGamingPlatformTests: XCTestCase {

    var controllerUnderTest: StartViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        controllerUnderTest = UIStoryboard(name: "Main",
                                           bundle: nil).instantiateInitialViewController() as? StartViewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        controllerUnderTest = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
