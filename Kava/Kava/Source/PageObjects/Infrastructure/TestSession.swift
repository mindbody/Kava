//
//  TestSession.swift
//  Kava
//
//  Created by John Hammerlund on 2/18/16.
//  Copyright © 2016 MINDBODY Inc. All rights reserved.
//

import Foundation
import XCTest

public class TestSession {
    
    private(set) var application: XCUIApplication;
    
    private(set) var currentTest: XCTestCase
    
    public init(test: XCTestCase, application: XCUIApplication? = XCUIApplication()) {
        self.application = application!
        self.currentTest = test
    }
    
}
