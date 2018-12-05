//
//  StoreItemTests.swift
//  SocialGamingPlatformTests
//
//  Created by Adam Luo on 11/21/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
@testable import SocialGamingPlatform

class StoreItemTests: XCTestCase {

    var test_storeitem1: StoreItem!
    var test_storeitem2: StoreItem!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        test_storeitem1 = StoreItem(name: "test", price: 10, detail: nil, power: Powerup(multiplier: 20, timeLimit: 30))
        test_storeitem2 = StoreItem(name: "test2", price: 20, detail: "detail", power: nil)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_init() {
        XCTAssertEqual(test_storeitem1.name, "test")
        XCTAssertEqual(test_storeitem1.price, 10)
//        XCTAssertEqual(test_storeitem1.detail, "multiplier: 20\ntime limit: 30")
        XCTAssertEqual(test_storeitem1.detail, "multiplier: 20")
        XCTAssertEqual(test_storeitem1.powerUp?.multiplier, 20)
        XCTAssertEqual(test_storeitem1.powerUp?.timeLimit, 30)
        XCTAssertEqual(test_storeitem2.detail, "detail")
    }

}
