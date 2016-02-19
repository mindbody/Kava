//
//  Block.swift
//  Kava
//
//  Created by John Hammerlund on 2/18/16.
//  Copyright © 2016 MINDBODY Inc. All rights reserved.
//

import Foundation
import XCTest

public protocol Block {
    
    var session: TestSession { get set }
    
    var element: XCUIElement { get set }
    
    func exists() -> Bool
    
    func rootBlock() -> Block
    
    init(session: TestSession, element: XCUIElement?)
}

public extension Block {
    
    public func rootBlock() -> Block {
        return ApplicationBlock(session: self.session)
    }
    
}

public final class ApplicationBlock : Block {
    
    public init(session: TestSession, element: XCUIElement? = nil) {
        self.session = session
        self.element = element ?? XCUIApplication()
    }
    
    public func exists() -> Bool {
        return true
    }
    
    public func rootBlock() -> Block {
        return self
    }
    
    public var session: TestSession
    
    public var element: XCUIElement
    
}

public class PageBlock : Block {
    
    public required init(session: TestSession, element: XCUIElement? = nil) {
        self.session = session
        self.element = element ?? session.application
    }
    
    public required convenience init(block: Block) {
        self.init(session: block.session, element: block.element)
    }
    
    public func exists() -> Bool {
        fatalError("Must override")
    }
    
    public func dismissKeyboard() -> Self {
        return self
    }
    
    public var session: TestSession
    
    public var element: XCUIElement
    
}
