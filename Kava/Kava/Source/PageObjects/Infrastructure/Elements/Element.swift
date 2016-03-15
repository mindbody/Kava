//
//  Element.swift
//  Kava
//
//  Created by John Hammerlund on 3/7/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

/**
 A protocol defining UI entities on a screen, whether it be elements or
 groups of elements.
*/
public protocol UITestEntity {
    
    var session: TestSession { get }
    
    var backingElement: XCUIElement { get }

}

/**
 A UI entity that defines a single element on a screen, which wraps behavior
 in an XCUIElement.
*/
public class Element : UITestEntity {
    
    // The wrapped XCUIElement
    public let backingElement: XCUIElement
    
    // The current test session. XCUIElements cannot exist without a running XCTest.
    public let session: TestSession
    
    // The block in which the element lives, which could simply be an ApplicationBlock
    public let parentBlock: Block
    
    /**
     Designated initializer. This creates a new Element that wraps an XCUIElement, 
     assigned to the given parent block.
     @param parentBlock The parent Block (element group)
     @param backingElement The wrapped XCUIElement
    */
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        self.session = parentBlock.session
        self.parentBlock = parentBlock
        self.backingElement = backingElement
    }
    
}