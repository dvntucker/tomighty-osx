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

    func testInterruptWithNoTrigger() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sysTimer = SystemTimer()
        sysTimer.interrupt()
    }
    
    func testTimerGetsInvoked()  {
        var clickCount = 0
        let sysTimer = SystemTimer()
        sysTimer.triggerRepeatedly(intervalInSeconds: 1, { clickCount = clickCount + 1 })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: { () in
            XCTAssert(clickCount > 0)
            sysTimer.interrupt()
        })
    }
}
