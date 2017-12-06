//
//  Utils.swift
//  Kava
//
//  Created by John Hammerlund on 2/18/16.
//  Copyright © 2016 MINDBODY Inc. All rights reserved.
//

import Foundation
import XCTest

public extension XCTestCase {
    
    public func wait(forPredicate predicate: NSPredicate, evaluatedWith object: Any? = nil, timeout: TimeInterval) -> Bool {
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: object)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
    
    public func waitForBlockToDisappear<T>(_ block: T, timeout: TimeInterval) -> Bool where T:Block  {
        let blockExistsPredicate = NSPredicate { (evaluatedObject, bindings) -> Bool in
            guard let evaluatedBlock = evaluatedObject as? T else {
                XCTFail()
                return false
            }
            return !evaluatedBlock.exists
        }
        
        return self.wait(forPredicate: blockExistsPredicate, evaluatedWith: block, timeout: timeout)
    }
    
    public func waitForBlockToExist<T>(_ block: T, withTimeout timeout: TimeInterval) -> Bool where T:Block  {
        let blockExistsPredicate = NSPredicate { (evaluatedObject, bindings) -> Bool in
            guard let evaluatedBlock = evaluatedObject as? T else {
                XCTFail()
                return false
            }
            return evaluatedBlock.exists
        }
        
        return self.wait(forPredicate: blockExistsPredicate, evaluatedWith: block, timeout: timeout)
    }
    
}

internal extension XCUIElement {
    
    func clearText() -> Void {
        guard let currentText = self.value as? String else {
            XCTFail("Cannot clear text on an element that doesn't contain text")
            return
        }
        
        let deleteString = currentText.map { _ in "\u{8}" }.joined(separator: "")
        
        if (deleteString.count > 0) {
            self.typeText(deleteString)
        }
    }
    
}
