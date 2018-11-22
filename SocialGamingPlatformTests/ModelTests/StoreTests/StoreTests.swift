//
//  StoreTests.swift
//  SocialGamingPlatformTests
//
//  Created by Dennis Lin on 10/30/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import XCTest
import Firebase
@testable import SocialGamingPlatform

class StoreTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        Auth.auth().signIn(withEmail: "test@test.test",
//                               password: "abcabc")
//        teststore = Store()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
//    func test_test() {
//        Auth.auth().signIn(withEmail: "abc@abc.abc", password: "abcabc"){ (user, error) in
//            if error == nil{
//                let teststore = Store()
//                teststore.addItems()
//                XCTAssertEqual(teststore.items.count, 0)
//            }
//        }
//        let teststore = Store()
//        print("rrrrrrrrr")
//        print(teststore.ref)
//        teststore.addItems()
//        XCTAssertEqual(teststore.items.count, 0)
//    }
    
    func test_addItems() {
        var teststore = Store()
        teststore.addItems()
        XCTAssertEqual(teststore.items.count, 0)
    }
//
    func test_removeExistingGames() {
        var teststore = Store()
        teststore.addItems()
        teststore.removeExistingGames()
        XCTAssertEqual(teststore.items.count, 0)
    }
//
//    func test_remove() {
//        var teststore = Store()
//        teststore.remove(item: teststore.items[0])
//        XCTAssertEqual(teststore.items.count, 3)
//    }
}
