//
//  SystemTimerTest.swift
//  Tomighty
//
//  Created by Devon Tucker on Sep/27/2016.
//  Copyright © 2016 Gig Software. All rights reserved.
//

import XCTest
@testable import Tomighty

class SystemTimerTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInterruptWithNoTrigger() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sysTimer = SystemTimer()
        sysTimer.interrupt()
    }
}
