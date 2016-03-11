//
//  Element.swift
//  Kava
//
//  Created by John Hammerlund on 3/7/16.
//  Copyright © 2016 MINDBODY, Inc. All rights reserved.
//

import Foundation
import XCTest

public protocol UITestEntity {
    
    var session: TestSession { get }
    
    var backingElement: XCUIElement { get }

}

public class Element : UITestEntity {
    
    public private(set) var backingElement: XCUIElement
    public private(set) var session: TestSession
    public private(set) var parentBlock: Block
    
    public required init(parentBlock: Block, backingElement: XCUIElement) {
        self.session = parentBlock.session
        self.parentBlock = parentBlock
        self.backingElement = backingElement
    }
    
    public func exists() -> Bool {
        return self.backingElement.exists
    }
    
}