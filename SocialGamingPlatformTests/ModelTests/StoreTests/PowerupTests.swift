
//
//  PowerupTests.swift
//  SocialGamingPlatformTests
//
//  Created by Dennis Lin on 10/30/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
@testable import SocialGamingPlatform

class PowerupTests: XCTestCase {

    var testpowerup: Powerup!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testpowerup = Powerup(multiplier: 2, timeLimit: 3600)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testpowerup = Powerup(multiplier: 2, timeLimit: 3600)
    }
    
    func test_init() {
        XCTAssertEqual(testpowerup.multiplier, 2)
        XCTAssertEqual(testpowerup.timeLimit, 3600)
        tearDown()
    }
    
    func test_serializable() {
        let powerupDict = testpowerup.toDictionary()
        XCTAssertEqual((powerupDict["multiplier"] as! Int), testpowerup.multiplier)
        XCTAssertEqual((powerupDict["timeLimit"] as! Int), testpowerup.timeLimit)
        XCTAssertNil(powerupDict["nil"])
        XCTAssertNil(testpowerup.valueForKey(key: "nil"))
    }
}
