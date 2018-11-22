//
//  MessageBoardTests.swift
//  SocialGamingPlatformTests
//
//  Created by Dennis Lin on 10/30/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
@testable import SocialGamingPlatform

class MessageBoardTests: XCTestCase {

    var testmessageboard: MessageBoard!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testmessageboard = MessageBoard()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_init() {
        XCTAssertEqual(testmessageboard.latestMessages.count, 0)
    }

}
