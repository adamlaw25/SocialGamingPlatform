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
    
    let db = Firestore.firestore()
    var testmessage: Message!
    var reference: CollectionReference?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testmessage = Message(content: "test")
        reference = db.collection(["messages"].joined(separator: "/"))
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
        XCTAssertNotNil(testmessage.messageId)
    }
    
//    func testDB() {
//        reference?.getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                print("ddddddd")
//                if let documents = querySnapshot?.documents {
//                    print("d111111")
//                    let d = documents[0]
//                    print(d.data())
//                    let testMessage2 = Message(document: d)
//                    XCTAssertEqual(testMessage2?.content, "What uppppppp")
//
//                }
//            }
//        }
//    }
    
}
