//
//  UserTests.swift
//  SocialGamingPlatformTests
//
//  Created by Dennis Lin on 10/30/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
@testable import SocialGamingPlatform

class UserTests: XCTestCase {
    
    var testuser: User!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        testuser = User(email: "test@test.com")
    }

    override func tearDown() {
        testuser.email = "test@test.com"
        testuser.isOnline = false
        testuser.score = 0
        testuser.level = 1
        testuser.friends = []
        testuser.gameList = ["BlackJack"]
        testuser.powerup = Powerup(multiplier: 1, timeLimit: 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_levelUP() {
        let levelBefore = testuser.level
        testuser.levelUP()
        XCTAssertEqual(levelBefore, testuser.level - 1)
        tearDown()
    }
    
    func test_addFriend() {
        let user2 = "test2@test.com"
        testuser.addFriend(friend: user2)
        XCTAssertEqual(testuser.friends.count, 1)
        XCTAssertEqual(testuser.friends[0], user2)
        tearDown()
    }
    
    func test_addScore() {
        testuser.addScore(newScore: 30)
        XCTAssertEqual(testuser.score, 30)
        tearDown()
    }
    
    func test_setStatus() {
        testuser.setStatus(isOnline: true)
        XCTAssertEqual(testuser.isOnline, true)
        tearDown()
    }
    
    func test_applyPowerup() {
        let powerup = Powerup(multiplier: 2, timeLimit: 5)
        testuser.applyPowerup(powerup: powerup)
        testuser.addScore(newScore: 30)
        XCTAssertEqual(testuser.score, 30*2)
        tearDown()
    }
    
    func test_serializable() {
        let userDict = testuser.toDictionary()
        XCTAssertEqual((userDict["email"] as! String), testuser.email)
        XCTAssertEqual((userDict["isOnline"] as! Bool), testuser.isOnline)
        XCTAssertEqual((userDict["score"] as! Int), testuser.score)
        XCTAssertEqual((userDict["level"] as! Int), testuser.level)
        XCTAssertEqual((userDict["friends"] as! [String]), testuser.friends)
        XCTAssertEqual((userDict["gameList"] as! [String]), testuser.gameList)
        let powerup = userDict["powerup"] as! NSDictionary
        XCTAssertEqual(powerup["multiplier"] as! Int, testuser.powerup.multiplier)
        XCTAssertEqual(powerup["timeLimit"] as! Int, testuser.powerup.timeLimit)
        XCTAssertNil(powerup["nil"])
    }

}
