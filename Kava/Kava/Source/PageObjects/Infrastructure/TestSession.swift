//
//  TestSession.swift
//  Kava
//
//  Created by John Hammerlund on 2/18/16.
//  Copyright © 2016 MINDBODY Inc. All rights reserved.
//

import Foundation
import XCTest

/**
 Represents the current test case. UI test entities cannot exist
 without a running TestSession.
*/
open class TestSession {
    
    open private(set) var application: XCUIApplication;
    
    open private(set) var currentTest: XCTestCase
    
    public init(test: XCTestCase, application: XCUIApplication? = XCUIApplication()) {
        self.application = application!
        self.currentTest = test
    }
    
}
