//
//  MessageTests.swift
//  SocialGamingPlatformTests
//
//  Created by Dennis Lin on 10/30/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
import MessageKit
import FirebaseFirestore
@testable import SocialGamingPlatform

class MessageTests: XCTestCase {
    
    var testmessage: Message!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testmessage = Message(content: "test")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoacal() {
        XCTAssertEqual(testmessage.content, "test")
        XCTAssertNil(testmessage.id)
        XCTAssertTrue(testmessage == testmessage)
        XCTAssertFalse(testmessage > testmessage)
        let representation = testmessage.representation
        XCTAssertEqual(representation["content"] as! String, testmessage.content)
        XCTAssertEqual(representation["senderID"] as! String, Constants.refs.getCurrentUserID())
    }

}
