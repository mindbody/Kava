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
    
    public func waitForPredicate(predicate: NSPredicate, evaluatedWithObject object: AnyObject? = nil, timeout: NSTimeInterval, handler: XCWaitCompletionHandler? = nil) {
        // If no object is provided, the expectation predicate still
        // needs an object to be evaluated against, even if not used
        let objectToEvaluate = object ?? self
        
        self.expectationForPredicate(predicate, evaluatedWithObject: objectToEvaluate, handler: nil)
        
        self.waitForExpectationsWithTimeout(timeout, handler: handler)
    }
    
    public func waitForBlockToDisappear<T where T:Block, T:AnyObject>(block: T, withTimeout timeout: NSTimeInterval, handler: XCWaitCompletionHandler? = nil) {
        let blockExistsPredicate = NSPredicate { (evaluatedObject, bindings) -> Bool in
            guard let evaluatedBlock = evaluatedObject as? T else {
                XCTFail()
                return false
            }
            return !evaluatedBlock.exists()
        }
        
        self.waitForPredicate(blockExistsPredicate, evaluatedWithObject: block, timeout: timeout, handler: handler)
    }
    
    public func waitForBlockToExist<T where T:Block, T:AnyObject>(block: T, withTimeout timeout: NSTimeInterval, handler: XCWaitCompletionHandler? = nil) {
        let blockExistsPredicate = NSPredicate { (evaluatedObject, bindings) -> Bool in
            guard let evaluatedBlock = evaluatedObject as? T else {
                XCTFail()
                return false
            }
            return evaluatedBlock.exists()
        }
        
        self.waitForPredicate(blockExistsPredicate, evaluatedWithObject: block, timeout: timeout, handler: handler)
    }
    
}

internal extension XCUIElement {
    
    func clearText() -> Void {
        guard let currentText = self.value as? String else {
            XCTFail("Cannot clear text on an element that doesn't contain text")
            return
        }
        
        let deleteString = currentText.characters.map { _ in "\u{8}" }.joinWithSeparator("")
        
        if (deleteString.characters.count > 0) {
            self.typeText(deleteString)
        }
    }
    
}
