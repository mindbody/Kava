//
//  Block.swift
//  Kava
//
//  Created by John Hammerlund on 2/18/16.
//  Copyright © 2016 MINDBODY Inc. All rights reserved.
//

import Foundation
import XCTest

/**
 A UI entity that defines a group of elements on a screen, which
 will usually have child Element entities and potentially child Blocks
 */
public protocol Block : class, UITestEntity {
    
    var parentBlock: Block? { get set }

    var exists: Bool { get }
    
    init(parentBlock: Block?, session: TestSession)
    
}

public extension Block {
    
    //MARK: Default implementations
    
    public var root: Block {
        if var parentBlock = self.parentBlock {
            while(parentBlock.parentBlock != nil) {
                parentBlock = parentBlock.parentBlock!
            }
            return parentBlock
        }
        return ApplicationBlock(parentBlock: nil, session: self.session)
    }
    
    /**
     Changes the current block scope, which may be useful when deeply nested in element groups.
     @param blockType The type of block to rescope to
     @param builder The provided block construction, or a default construction wrapping the application if none is provided
    */
    @discardableResult
    public func scopeTo<TResultBlock : Block>(_ blockType: TResultBlock.Type, builder: (() -> TResultBlock)? = nil ) -> TResultBlock {
        if let blockBuilder = builder {
            return blockBuilder()
        }
        return TResultBlock(parentBlock: nil, session: self.session)
    }
    
    //MARK: Helpers
    
    /**
     Marks a test expectation to be ran, which polls the provided predicate until it succeeds or 
     the timeout passes.
     @param predicate The predicate to be tested against
     @param timeout The timeout before forcing an expectation failure
    */
    @discardableResult
    public func wait(timeout: TimeInterval, predicate: NSPredicate) -> Self {
        self.session.currentTest.wait(forPredicate: predicate, timeout: timeout)
        return self
    }
    
    /**
     Marks a test expectation to be ran, which polls the provided block predicate until it succeeds or
     the timeout passes.
     @param block The block predicate to be tested against
     @param timeout The timeout before forcing an expectation failure
     */
    @discardableResult
    public func wait(timeout: TimeInterval, closure: @escaping ((Self) -> Bool)) -> Self {
        let predicate = NSPredicate { [weak self] (_, _) -> Bool in
            return withExtendedLifetime(self) {
                return closure(self!)
            }
        }
        return self.wait(timeout: timeout, predicate: predicate)
    }
    
    /**
     Helper for modifying system environment settings (device orientation, pressing system buttons, etc.)
    */
    @discardableResult
    public func modifyDeviceEnvironment(closure: ((Device) -> ())) -> Self {
        closure(Device.shared)
        return self
    }
}

/**
 A concrete block that defines the root of any block hierarchy, wrapping the singleton XCUIApplication
*/
public final class ApplicationBlock : Block {

    public private(set) var session: TestSession
    public let backingElement: XCUIElement = XCUIApplication()
    public var parentBlock: Block?
    
    public init(parentBlock: Block?, session: TestSession) {
        self.session = session
        self.parentBlock = nil // The application is the absolute root
    }
    
    public var exists: Bool = true
    
    public func rootBlock() -> Block {
        return self
    }
    
}

/**
 A concrete block that represents a "page", usually correlating to a view controller
*/
open class PageBlock : Block {
    
    public private(set) var session: TestSession
    open var backingElement: XCUIElement = XCUIApplication()
    open var parentBlock: Block?
    
    public required init(parentBlock: Block?, session: TestSession) {
        self.session = session
        self.parentBlock = parentBlock
    }
    
    public required convenience init(block: Block) {
        self.init(parentBlock: block.parentBlock, session: block.session)
    }
    
    open var exists: Bool = false
    
    open func dismissKeyboard() -> Self {
        return self
    }
    
}
